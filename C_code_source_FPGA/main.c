
#include <stdio.h>
#include "bsp.h"
#include "intercom.h"
#include "timers.h"
#include <string.h>
#include "xil_printf.h"



#define	PB_POLL_FREQ	75
#define TIMER_ID	1
#define AUDIO_PRIORITY	tskIDLE_PRIORITY+1
#define ROT_PRIORITY	tskIDLE_PRIORITY+2


#define PERIODSAMPLES2 512

// The definition of TCBs for each task
xTaskHandle hRotarySM;
xTaskHandle hAudioSM;




TimerHandle_t xTimer = NULL;

portTASK_FUNCTION_PROTO(vRotarySM, pvParameters);
portTASK_FUNCTION_PROTO(vAudioSM, pvParameters);

void vTimerCallback_pb( TimerHandle_t pxTimer );
void active_default_state(evt event, ROTARY_super_state_typedef *super_state, rot_pos_struct*);
void dormant_default_state(evt event, ROTARY_super_state_typedef *super_state);
void super_active_state (evt event, ROTARY_super_state_typedef *super_state);




// ============================================================================
int main(void) {

	INTERCOM_init();
	BSP_init();

	/* Creating two tasks for background operations and user-interface */
	xTaskCreate(vRotarySM, "RotarySM", configMINIMAL_STACK_SIZE*4, NULL, ROT_PRIORITY, &hRotarySM);
	xTaskCreate(vAudioSM,  "AudioSM", configMINIMAL_STACK_SIZE*4, NULL, AUDIO_PRIORITY, &hAudioSM);
	
	/* Create a timer with a software timer for sending data through serial connection.  */
	xTimer = xTimerCreate( (const char *) "Timer2",
							1,
							pdTRUE,
							(void *) TIMER_ID,
							vTimerCallback_pb);
	/* Check the timer was created. */
	configASSERT( xTimer );

	/* start the timer with a block time of 0 ticks. This means as soon
	   as the schedule starts the timer will start running and will expire after
	   1 seconds */
	xTimerStart( xTimer, 0 );

	vTaskStartScheduler(); // This should never return.
	
	// Will only get here if there was insufficient memory to create
	// the idle task.
	while(1);  
}

/* This task simulated audio data pth in ultimate design */
portTASK_FUNCTION(vAudioSM, pvParameters) {

	evt audio_evt;
    double amp = 11000 ;
    float amp_coeff = 1;
    int bi=0;
	short right;
	short left;
	filter* IIR_filter1;
	filter* IIR_filter2;
	float input_bass_coeff[INPUT_BUFFER_LENGTH] = {1.0, -1.8836532429909993, 0.8900591334898765};
	float output_bass_coeff[OUTPUT_BUFFER_LENGTH] = { -1.8836532429909993, 0.8900591334898765};


	float input_treble_coeff[INPUT_BUFFER_LENGTH] = {1.0, -1.4415303099387249, 0.5664860046574698};
	float output_treble_coeff[OUTPUT_BUFFER_LENGTH] = {-1.4415303099387249, 0.5664860046574698};


	float F = 200;
	short greatest_amplitude = 0;
	short greatest_amplitude_input = 0;
	double greatest_db = 0;
	short PERIODSAMPLES = (short)(44100.0/F);

	init_filter(IIR_filter1);
	init_filter(IIR_filter2);
	while(1) {

		xQueueReceive(audioQueue, &audio_evt, portMAX_DELAY);

		switch(audio_evt.sig)
				{
					case COMPUTE_NEW_SAMPLE_SIG:

						left = (short) (sin((double)bi/PERIODSAMPLES*2*M_PI) * amp * amp_coeff);
						right = (short) (sin((double)bi/PERIODSAMPLES*2*M_PI) * amp * amp_coeff);

						right = compute_filter_output(IIR_filter1, right, input_bass_coeff, output_bass_coeff);
						right = compute_filter_output(IIR_filter2, right, input_treble_coeff, output_treble_coeff);

						if (greatest_amplitude < right) {
							greatest_amplitude = right;
						}

						if (greatest_amplitude_input < left) {
							greatest_amplitude_input = left;

						}

						greatest_db = (greatest_amplitude/(float)greatest_amplitude_input);

						printf("%hi, %hi\r",left, right);

						bi++;

						break;

					case UPDATE_BASS_COEEFF_SIG:
						for(u8 i=0; i<INPUT_BUFFER_LENGTH; i++) {
							input_bass_coeff[i] = audio_evt.input_coeff[i];
						}
						for(u8 i=0; i<OUTPUT_BUFFER_LENGTH; i++) {
							output_bass_coeff[i] = audio_evt.output_coeff[i];
						}
						break;

					case UPDATE_VOL_COEEFF_SIG:
						amp_coeff = audio_evt.vol_coeff;

						break;

					case UPDATE_TREBLE_COEEFF_SIG:
						for(u8 i=0; i<INPUT_BUFFER_LENGTH; i++) {
							input_treble_coeff[i] = audio_evt.input_coeff[i];
						}
						for(u8 i=0; i<OUTPUT_BUFFER_LENGTH; i++) {
							output_treble_coeff[i] = audio_evt.output_coeff[i];
						}
						break;

					case RESET_ALL_COEFF_SIG:

						amp_coeff = 1;

						input_bass_coeff[0] = 1.0;
						input_bass_coeff[1] = -1.8836532429909993;
						input_bass_coeff[2] = 0.8900591334898765;
						output_bass_coeff[0] = -1.8836532429909993;
						output_bass_coeff[1] = 0.8900591334898765;

						input_treble_coeff[0] = 1.0;
						input_treble_coeff[1] = -1.4415303099387249;
						input_treble_coeff[2] =  0.5664860046574698;
						output_treble_coeff[0] = -1.4415303099387249;
						output_treble_coeff[1] = 0.5664860046574698;

						break;

					default:
						break;
				}
	}
}

/* This task implements the state machine for rotary encoder */
portTASK_FUNCTION(vRotarySM, pvParameters) {

	evt rotary_evt;
	ROTARY_super_state_typedef super_state = SUPER_ACTIVE_ST;

	while(1) {
		xQueueReceive(rotaryQueue, &rotary_evt, portMAX_DELAY);

		switch(super_state) {

			case SUPER_ACTIVE_ST:
				super_active_state(rotary_evt, &super_state);
				break;

			case SUPER_DORMANT_ST:
				dormant_default_state(rotary_evt, &super_state);
				break;
		}

	}
}

void super_active_state (evt event, ROTARY_super_state_typedef *super_state) {
	evt rcv_rot_evt;


	static rot_pos_struct rot_pos ={0};

	static ROTARY_state_typedef	state = INIT_ST;
	coeff_struct filter_coeff;




	switch(state)
	{
		case INIT_ST:

			switch(event.sig)
			{
				case INIT_SIG:
					state = VOLUME_ST;
					rcv_rot_evt.sig = ST_ENTRY_SIG;
					xQueueSendToBack ( rotaryQueue, &rcv_rot_evt, portMAX_DELAY);
					break;

				default:
					break;
			}

			break;

		case BASS_ST:

			switch(event.sig)
			{
				case ST_ENTRY_SIG:
					BSP_turnonBLED();
					break;

				case CW_SIG:
					if (rot_pos.bass < 12) {
						rot_pos.bass++;
					}

					BSP_reset_oneshot_timer();
					break;

				case CCW_SIG:
					if (rot_pos.bass > -12) {
						rot_pos.bass--;
					}

					BSP_reset_oneshot_timer();
					break;

				case ONESHOT_TIMER_SIG:

					filter_coeff = update_bass_equ_coeff(rot_pos.bass);

					rcv_rot_evt.sig =  UPDATE_BASS_COEEFF_SIG;

					for(u8 i=0; i<INPUT_BUFFER_LENGTH; i++) {
						rcv_rot_evt.input_coeff[i] = filter_coeff.input_coeff[i];
					}
					for(u8 i=0; i<OUTPUT_BUFFER_LENGTH; i++) {
						rcv_rot_evt.output_coeff[i] = filter_coeff.output_coeff[i];
					}
					xQueueSendToBack ( audioQueue, &rcv_rot_evt, portMAX_DELAY);

					break;

				case BUTTON_PRESS_SIG:
					state = TREBLE_ST;
					rcv_rot_evt.sig = ST_ENTRY_SIG;
					xQueueSendToBack ( rotaryQueue, &rcv_rot_evt, portMAX_DELAY);
					break;
				
				default:
					active_default_state(event, super_state, &rot_pos);
					break;
			}

			break;

	case VOLUME_ST:

		switch(event.sig)
		{
			case ST_ENTRY_SIG:
				BSP_turnonRLED();
				break;

			case CW_SIG:
				if (rot_pos.volume < 12) {
					rot_pos.volume++;
				}
				BSP_reset_oneshot_timer();
				break;

			case CCW_SIG:
				if (rot_pos.volume > -12) {
					rot_pos.volume--;
				}
 				BSP_reset_oneshot_timer();
				break;

			case ONESHOT_TIMER_SIG:

				rcv_rot_evt.sig =  UPDATE_VOL_COEEFF_SIG;
				rcv_rot_evt.vol_coeff = 1+((rot_pos.volume/12.0)*0.4);

				xQueueSendToBack ( audioQueue, &rcv_rot_evt, portMAX_DELAY);
				break;

			case BUTTON_PRESS_SIG:
				state = BASS_ST;
				rcv_rot_evt.sig = ST_ENTRY_SIG;
				xQueueSendToBack ( rotaryQueue, &rcv_rot_evt, portMAX_DELAY);
				break;

			default:
				active_default_state(event, super_state, &rot_pos);
				break;
		}

		break;

	case TREBLE_ST:

		switch(event.sig)
		{
			case ST_ENTRY_SIG:
				BSP_turnonXLED();
				break;

			case CW_SIG:
				if (rot_pos.treble < 12) {
					rot_pos.treble++;
				}
				BSP_reset_oneshot_timer();
				break;

			case CCW_SIG:
				if (rot_pos.treble > -12) {
					rot_pos.treble--;
				}
				BSP_reset_oneshot_timer();
				break;

			case ONESHOT_TIMER_SIG:

				filter_coeff = update_treble_equ_coeff(rot_pos.treble);

				rcv_rot_evt.sig =  UPDATE_TREBLE_COEEFF_SIG;

				for(u8 i=0; i<INPUT_BUFFER_LENGTH; i++) {
					rcv_rot_evt.input_coeff[i] = filter_coeff.input_coeff[i];
				}
				for(u8 i=0; i<OUTPUT_BUFFER_LENGTH; i++) {
					rcv_rot_evt.output_coeff[i] = filter_coeff.output_coeff[i];
				}
				xQueueSendToBack ( audioQueue, &rcv_rot_evt, portMAX_DELAY);

				break;

			case BUTTON_PRESS_SIG:
				state = VOLUME_ST;
				rcv_rot_evt.sig = ST_ENTRY_SIG;
				xQueueSendToBack ( rotaryQueue, &rcv_rot_evt, portMAX_DELAY);
				break;

			default:
				active_default_state(event, super_state, &rot_pos);
				break;
		}

		break;


		default:
			break;

	}

}


void active_default_state(evt event, ROTARY_super_state_typedef *super_state, rot_pos_struct* rot_pos) {

	evt audio_evt;

	switch(event.sig) {
		case DISABLE_EQU_SIG:
			*super_state = SUPER_DORMANT_ST;
			rot_pos->bass = 0;
			rot_pos->volume = 0;
			rot_pos->treble = 0;
			BSP_turnoff_LED();

			audio_evt.sig =  UPDATE_TREBLE_COEEFF_SIG;
			xQueueSendToBack ( audioQueue, &audio_evt, portMAX_DELAY);
			break;

		default:
			break;
	}
}

void dormant_default_state(evt event, ROTARY_super_state_typedef *super_state) {

	evt rotary_evt;
	switch(event.sig) {
		case ENABLE_EQU_SIG:
			*super_state = SUPER_ACTIVE_ST;
			rotary_evt.sig = ST_ENTRY_SIG;
			xQueueSendToBack (rotaryQueue, &rotary_evt, portMAX_DELAY);
			break;

		default:
			break;
	}
}

void vTimerCallback_pb( TimerHandle_t pxTimer )
{
	evt audio_evt;
	audio_evt.sig = COMPUTE_NEW_SAMPLE_SIG;
	xQueueSendToBack (audioQueue, &audio_evt, portMAX_DELAY);
}



