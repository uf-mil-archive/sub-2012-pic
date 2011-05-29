#ifndef SIMPLE_QUEUE_H
#define SIMPLE_QUEUE_H

#include "GenericTypeDefs.h"

#define BASE_TYPE           INT16
#define QUEUEDATATYPE       CHAR8
#define MAX_SQUEUE_SIZE     256

#define QUEUE_SUCCESS           0
#define QUEUE_FAILURE           1
#define QUEUE_OVERFLOW_ERROR    3
#define QUEUE_UNDERFLOW_ERROR   2

typedef struct simpleQueueDefinition
{
    BASE_TYPE count;
    BASE_TYPE front;
    BASE_TYPE rear;
    QUEUEDATATYPE data[MAX_SQUEUE_SIZE];
} xSimpleQueue;

typedef xSimpleQueue *xSimpleQueueHandle;

BASE_TYPE SEnqueue(xSimpleQueueHandle q, QUEUEDATATYPE data);
BASE_TYPE SDequeue(xSimpleQueueHandle q, QUEUEDATATYPE* data);
BASE_TYPE SFlush(xSimpleQueueHandle q);
BASE_TYPE SFlushN(xSimpleQueueHandle q, BASE_TYPE n);
BASE_TYPE SPeek(xSimpleQueueHandle q, QUEUEDATATYPE *data);
BASE_TYPE SPeekAtQueueIndex(xSimpleQueueHandle q, BASE_TYPE index,  QUEUEDATATYPE* data);
BASE_TYPE SQueueFull(xSimpleQueueHandle q);

#endif
