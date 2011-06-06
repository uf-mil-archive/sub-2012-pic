#ifndef TASK_UART_H
#define TASK_UART_H

#include "GenericTypeDefs.h"
#include "HardwareProfile.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

#include "messages.h"
#include "taskParser.h"

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

#define UART_QUEUE_SIZE     10
#define STACK_SIZE_UART     (configMINIMAL_STACK_SIZE * 2)

extern xQueueHandle hUARTTxQueue;
extern xTaskHandle hUARTTask;

void xUARTTaskInit(void);

void taskUART(void* pvParameter);

void COMSend(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree);
void COMSendFromISR(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree);

#endif
