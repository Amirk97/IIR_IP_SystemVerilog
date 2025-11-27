#include "intercom.h"

xQueueHandle rotaryQueue;
xQueueHandle audioQueue;


BaseType_t xHigherPriorityTaskWoken = NULL ;


void INTERCOM_init(void) {
	
	evt rot_evt;
	
	rotaryQueue = xQueueCreate( 2*20, sizeof(rot_evt));
	audioQueue = xQueueCreate( 20, sizeof(rot_evt));
	
	rot_evt.sig = INIT_SIG;
	
	xQueueSendToBack( rotaryQueue, &rot_evt, portMAX_DELAY );
	
	
}
