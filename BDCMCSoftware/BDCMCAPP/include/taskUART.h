#ifndef TASK_UART_H
#define TASK_UART_H

#include "GenericTypeDefs.h"
#include "HardwareProfile.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

#include "simplequeue.h"

#define UART_QUEUE_SIZE     10
#define UART_ENTRY_SIZE     40
#define STACK_SIZE_UART     (configMINIMAL_STACK_SIZE * 2)

#define UART_DONT_FREE_BUFFER   0
#define UART_FREE_BUFFER        1

// This is the message structure for transmitting via the UART
typedef struct
{
    portBASE_TYPE count;
    BYTE* buffer;
    portBASE_TYPE flags;    // bit 1 is the buffer free instruction
} UARTMsg;

extern xQueueHandle hUARTTxQueue;
extern xSemaphoreHandle hUARTRxSemaphore;
extern xSimpleQueueHandle hUARTRxQueue;

extern xTaskHandle hUARTTask;

void xUARTTaskInit(void);

void taskUART(void* pvParameter);

void COMPut(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree);
void COMPutFromISR(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree);

#endif
