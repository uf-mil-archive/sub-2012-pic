#ifndef TASK_PARSER_H
#define TASK_PARSER_H

#include "GenericTypeDefs.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

#include "taskUART.h"
#include "messages.h"

#define STACK_SIZE_PARSER     (configMINIMAL_STACK_SIZE * 3)

extern xTaskHandle hUARTParserTask;

void xParserTaskInit(void);
void taskParser(void* pvParameter);

typedef struct xParserParameterDefinition
{
    xSemaphoreHandle hRxSemaphore;      // The semaphore that is given by the ISR
                                        // to notify the queue has new bytes
    xSimpleQueueHandle hRxQueue;        // The queue the bytes are coming from
    CHAR8 msgBuffer[MSG_MAX_LENGTH];    // The buffer the parsed message goes in
    UINT16 sender;                      // Who sent the message?
} xParserParameter;

typedef xParserParameter *xParserParameterHandle;

typedef struct xParserStateDefinition
{
    INT16 mode;
    INT16 pktIndex;
} xParserState;

#define PKT_SEARCH_HDR  0
#define PKT_ESCAPED     1
#define PKT_INMSG       2

#endif // TASK_PARSER_H
