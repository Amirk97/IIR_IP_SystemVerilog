#include "bsp.h"



XGpio Gpio;
XTmrCtr TmrCtrInstancePtr1;
extern XScuGic xInterruptController;


int BSP_init (void) {
	
	/* Configure the interrupt handler compatible with
	 * FreeRTOS kernel
	 */
	prvSetupHardware();

	/* Initialize the timer
	 * which counts the time and issues an interrupt every 0.01 sec
	 * , used for stopwatch mode
	 */
	Timer_Config();

	GPIO_Config();

	return 0;
}


/* This code excerpt was inspired by example codes for
 * using FreeRTOS on  ARM cortex-A
 */
 void prvSetupHardware(void) {
	BaseType_t xStatus;
	XScuGic_Config *pxGICConfig;

	/* Ensure no interrupts execute while the scheduler is in an inconsistent
	state.  Interrupts are automatically enabled when the scheduler is
	started. */
	portDISABLE_INTERRUPTS();

	/* Obtain the configuration of the GIC. */
	pxGICConfig = XScuGic_LookupConfig( XPAR_SCUGIC_SINGLE_DEVICE_ID );

	/* Sanity check the FreeRTOSConfig.h settings are correct for the
	hardware. */
	configASSERT( pxGICConfig );
	configASSERT( pxGICConfig->CpuBaseAddress == ( configINTERRUPT_CONTROLLER_BASE_ADDRESS + configINTERRUPT_CONTROLLER_CPU_INTERFACE_OFFSET ) );
	configASSERT( pxGICConfig->DistBaseAddress == configINTERRUPT_CONTROLLER_BASE_ADDRESS );

	/* Install a default handler for each GIC interrupt. */
	xStatus = XScuGic_CfgInitialize( &xInterruptController, pxGICConfig, pxGICConfig->CpuBaseAddress );
	configASSERT( xStatus == XST_SUCCESS );
	( void ) xStatus; /* Remove compiler warning if configASSERT() is not defined. */


	/* The Xilinx projects use a BSP that do not allow the start up code to be
	altered easily.  Therefore the vector table used by FreeRTOS is defined in
	FreeRTOS_asm_vectors.S, which is part of this project.  Switch to use the
	FreeRTOS vector table. */
	vPortInstallFreeRTOSVectorTable();
}

 void BSP_turnonXLED(void) {
	 XGpio_DiscreteWrite(&Gpio, GPIO_CHANNEL_OUTPUT, 0x05);
 }

 void BSP_turnonBLED(void) {
	 XGpio_DiscreteWrite(&Gpio, GPIO_CHANNEL_OUTPUT, 0x03);
 }

 void BSP_turnonRLED(void) {
	 XGpio_DiscreteWrite(&Gpio, GPIO_CHANNEL_OUTPUT, 0x07);
 }

 void BSP_turnoff_LED(void) {
	 XGpio_DiscreteWrite(&Gpio, GPIO_CHANNEL_OUTPUT, 0x00);
 }

// This function both starts and then reset the one-shot timer
 void BSP_reset_oneshot_timer(void) {
	XTmrCtr_Start(&TmrCtrInstancePtr1, 0);
	XTmrCtr_Reset(&TmrCtrInstancePtr1, 0);
 }

 void GPIO_Config(void) {

	XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
	XGpio_SetDataDirection(&Gpio, GPIO_CHANNEL_OUTPUT, 0x00);
	XGpio_SetDataDirection(&Gpio, GPIO_CHANNEL_INPUT, 0xff);

	XScuGic_SetPriorityTriggerType( &xInterruptController, XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR, (configMAX_API_CALL_INTERRUPT_PRIORITY+1) << portPRIORITY_SHIFT , 0b11 );
	XScuGic_Connect(&xInterruptController,
					XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR,
					 (Xil_ExceptionHandler)GPIO_IRQHandler,
					 (void *)&Gpio);



	// Enable GPIO interrupts
	XGpio_InterruptEnable(&Gpio, XGPIO_IR_CH1_MASK);

	//Needs to enable Global Interrupt Enable to pass the interrupt to the
	//interrupt controller
	XGpio_InterruptGlobalEnable(&Gpio);

	/* Enable the interrupt in the GIC. */
	XScuGic_Enable( &xInterruptController, XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR );
 }

 void GPIO_IRQHandler(void *InstancePtr) {

	 u32 status = 0;
	 evt equ_evt;
	 static u8 AB_state = 0;


	// Disable further GPIO interrupts
	XGpio_InterruptDisable(&Gpio, XGPIO_IR_CH1_MASK);

	//	XGpio_DiscreteWrite(&Gpio, GPIO_CHANNEL_OUTPUT, 0x01);
	status = XGpio_InterruptGetStatus(&Gpio);

	status = XGpio_DiscreteRead(&Gpio, GPIO_CHANNEL_INPUT);

	if((status & 0x1) == 1) {
		equ_evt.sig = BUTTON_PRESS_SIG;
		xQueueSendToBackFromISR( rotaryQueue, &equ_evt, &xHigherPriorityTaskWoken);
	}

	// This small state machine detects the edge of the signals
	switch(AB_state) {

		case AB_IDLE:
			if(((status & 0x4) == 0) && ((status & 0x2) == 2)) {

					equ_evt.sig = CW_SIG;
					xQueueSendToBackFromISR( rotaryQueue, &equ_evt, &xHigherPriorityTaskWoken);
					AB_state= AB_NON_IDLE;
			}
			if(((status & 0x4) == 4) && ((status & 0x2) == 0)) {

					equ_evt.sig = CCW_SIG;
					xQueueSendToBackFromISR( rotaryQueue, &equ_evt, &xHigherPriorityTaskWoken);
					AB_state= AB_NON_IDLE;
			}

		case AB_NON_IDLE:
			if(((status & 0x4) == 4) && ((status & 0x2) == 2)) {

				AB_state= AB_IDLE;
			}
	}


    //clear the interrupt flag
    (void)XGpio_InterruptClear(&Gpio, XGPIO_IR_CH1_MASK);
    // Enable GPIO interrupts at the exit of the ISR
    XGpio_InterruptEnable(&Gpio, XGPIO_IR_CH1_MASK);
 }

int Timer_Config (void) {

	int Status = 0;

	// Initialize timer structure
	Status = XTmrCtr_Initialize(&TmrCtrInstancePtr1, XPAR_AXI_TIMER_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// Do a self-test on timer peripheral to insure it has been instantiated correctly
	Status = XTmrCtr_SelfTest(&TmrCtrInstancePtr1, 0);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	XScuGic_SetPriorityTriggerType( &xInterruptController, XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR, (configMAX_API_CALL_INTERRUPT_PRIORITY+1) << portPRIORITY_SHIFT , ucRisingEdge );

	Status = XScuGic_Connect(&xInterruptController,
							XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR,
							 (Xil_ExceptionHandler)Timer_sec_IRQHandler,
							 (void *)&TmrCtrInstancePtr1);
	if(Status != XST_SUCCESS) return XST_FAILURE;

	/* Enable the interrupt in the GIC. */
	XScuGic_Enable( &xInterruptController, XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR );

	// Set the timer mode to auto reload and enables the interrupts and set the mode to down counter
	XTmrCtr_SetOptions(&TmrCtrInstancePtr1, 0,
				XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION | XTC_DOWN_COUNT_OPTION);

	// Set the reset value for the timer
	XTmrCtr_SetResetValue(&TmrCtrInstancePtr1, 0, RESET_VALUE);

	return XST_SUCCESS;

}

void Timer_sec_IRQHandler(void *instancePtr) {

	XTmrCtr_ClearStats(&TmrCtrInstancePtr1);
	XTmrCtr_Stop(&TmrCtrInstancePtr1, 0);

	evt time_evt;
	time_evt.sig = ONESHOT_TIMER_SIG;
	xQueueSendToBackFromISR( rotaryQueue, &time_evt, &xHigherPriorityTaskWoken);
}
