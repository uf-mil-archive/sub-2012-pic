#ifndef TASK_UART_H
#define TASK_UART_H

#include "GenericTypeDefs.h"
#include "HardwareProfile.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

//#include "messages.h"
//#include "taskParser.h"
#include "mcp25XX640A.h"

#include <string.h>
#include <stdlib.h>

#define UART_QUEUE_SIZE     10
#define STACK_SIZE_UART     (configMINIMAL_STACK_SIZE * 4)

typedef struct
{
    UINT16 BaudDiv;        // The baud rate divisor
}UARTConfigData;

extern UARTConfigData gUARTConfig;

extern xQueueHandle hUARTTxQueue;
extern xTaskHandle hUARTTask;

void xUARTTaskInit(void);

void taskUART(void* pvParameter);

void COMSend(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree);
void COMSendFromISR(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree);
void SaveUARTConfig(UARTConfigData* uartCfg);

#endif
