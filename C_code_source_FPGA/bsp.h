#ifndef BSP_H
#define BSP_H


#include "functions.h"
#include "intercom.h"
#include "xparameters.h"
#include "xtmrctr.h"
#include "FreeRTOS.h"
#include "FreeRTOSConfig.h"
#include "xscugic.h"

#include "xgpio.h"
#include "math.h"


#define GPIO_DEVICE_ID  XPAR_AXI_GPIO_0_DEVICE_ID	/* GPIO device that LEDs are connected to */
#define GPIO_CHANNEL_INPUT 1								/* GPIO port for LEDs */
#define GPIO_CHANNEL_OUTPUT 2								/* GPIO port for LEDs */


#define ucRisingEdge 0b11
// Corresponding to 250 ms
#define RESET_VALUE 0x017D7840

int BSP_init (void);

void GPIO_Config(void);
//
int Timer_Config(void);

void Timer_sec_IRQHandler(void *);

void prvSetupHardware( void );
void BSP_turnonBLED(void);
void BSP_reset_oneshot_timer(void);
void BSP_turnonRLED(void);
void BSP_turnonXLED(void);
void BSP_turnoff_LED();

void GPIO_IRQHandler(void *InstancePtr);


#endif
