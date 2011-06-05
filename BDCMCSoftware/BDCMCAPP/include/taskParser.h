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

#define STACK_SIZE_PARSER       (configMINIMAL_STACK_SIZE * 3)

#define PARSER_QUEUE_SIZE       20

extern xTaskHandle hParserTask;
extern xQueueHandle hParserQueue;

void xParserTaskInit(void);
void taskParser(void* pvParameter);

#define PKT_SEARCH_HDR  0
#define PKT_ESCAPED     1
#define PKT_INMSG       2

#endif // TASK_PARSER_H
