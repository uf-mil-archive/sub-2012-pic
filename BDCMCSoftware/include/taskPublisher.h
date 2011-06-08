#ifndef TASK_PUBLISHER_H
#define TASK_PUBLISHER_H

#include "GenericTypeDefs.h"
#include "HardwareProfile.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"

#include "taskUART.h"
#include "messages.h"

#define STACK_SIZE_PUBLISHER    (configMINIMAL_STACK_SIZE * 2)
#define PBL_DEFAULT_RATE    20
#define PBL_MAX_RATE        200

extern xTaskHandle hPublisherTask;
extern portBASE_TYPE gPublishPeriod;   // Publishing period in ms

void xPublisherTaskInit(void);

void taskPublisher(void* pvParameter);

void SetNewPublishRate(INT16 rate);
void SetSubscriber(INT16 transport, BOOL state);

#endif
