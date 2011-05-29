#include "simplequeue.h"


BASE_TYPE SEnqueue(xSimpleQueueHandle q, QUEUEDATATYPE data)
{
    // Increment the rear pointer and check for fullness
    BASE_TYPE temp = ( q->rear + 1 ) % MAX_SQUEUE_SIZE;

    // If the new rear is not the front, there is room left
    // in the queue for another data item.
    if(temp!= q->front)
    {
        q->rear = temp;
        q->data[temp] = data;
        q->count++;

        return QUEUE_SUCCESS;
    }

    return QUEUE_OVERFLOW_ERROR;
}

BASE_TYPE SDequeue(xSimpleQueueHandle q, QUEUEDATATYPE* data)
{
    if(q->front == q->rear)
        return QUEUE_UNDERFLOW_ERROR;

    q->front = ( q->front + 1 ) % MAX_SQUEUE_SIZE;
    *data = q->data[q->front];
    q->count--;

    return QUEUE_SUCCESS;
}

BASE_TYPE SFlushN(xSimpleQueueHandle q, BASE_TYPE n)
{
    if(n > q->count)
        return SFlush(q);

    q->front = (q->front + n) % MAX_SQUEUE_SIZE;
    q->count -= n;

    return QUEUE_SUCCESS;
}

BASE_TYPE SFlush(xSimpleQueueHandle q)
{
    q->front = 0;
    q->rear = 0;
    q->count = 0;

    return QUEUE_SUCCESS;
}

BASE_TYPE SPeekAtQueueIndex(xSimpleQueueHandle q, BASE_TYPE index, QUEUEDATATYPE* data)
{
    if((q->front == q->rear)|| (index > q->count))
        return QUEUE_FAILURE;

    *data = q->data[((q->front + index + 1) % MAX_SQUEUE_SIZE)];

    return QUEUE_SUCCESS;
}

BASE_TYPE SQModifyInPlace(xSimpleQueueHandle q, BASE_TYPE index, QUEUEDATATYPE data)
{
    if((q->front == q->rear)|| (index > q->count))
        return QUEUE_FAILURE;

    q->data[(( q->front + 1 ) % MAX_SQUEUE_SIZE)] = data;

    return QUEUE_SUCCESS;
}

BASE_TYPE SQueueFull(xSimpleQueueHandle q)
{
    return (q->count >= MAX_SQUEUE_SIZE);
}

