#ifndef INTERCOM_H
#define INTERCOM_H

#include "FreeRTOS.h"

#include "semphr.h"
#include "task.h"
#include "queue.h"
#include "bsp.h"


typedef enum{
	INIT_SIG,			/* The initialization event */
	ST_ENTRY_SIG,   	/* The state entry event */
	ENABLE_EQU_SIG, 	/* Enable the equalizer SM event */
	DISABLE_EQU_SIG,	/* Disable the equalizer SM event */
	CW_SIG,				/* Rotary encoder is spining clock-wise event */
	CCW_SIG,			/* Rotary encoder is spining clock-wise event */
	ONESHOT_TIMER_SIG,	/* one-shot timer event */
	BUTTON_PRESS_SIG
}rtry_sig_typedef;

typedef enum{
	UPDATE_TREBLE_COEEFF_SIG,
	UPDATE_BASS_COEEFF_SIG,
	COMPUTE_NEW_SAMPLE_SIG,
	UPDATE_VOL_COEEFF_SIG,
	RESET_ALL_COEFF_SIG
}audiopath_sig_typedef;


typedef struct{
	uint8_t sig;

	float input_coeff[INPUT_BUFFER_LENGTH];
	float output_coeff[OUTPUT_BUFFER_LENGTH];

	float vol_coeff;
}evt;


void INTERCOM_init(void);

xQueueHandle rotaryQueue;
xQueueHandle audioQueue;

extern BaseType_t xHigherPriorityTaskWoken;

#endif
