#include "taskParser.h"

xTaskHandle hUARTParserTask;
xParserParameter uartParserParameter;

void SearchForPacket(xParserState *state, CHAR8 buffer[], xSimpleQueueHandle rQueue, UINT16 sender);

void xParserTaskInit(void)
{
    uartParserParameter.hRxSemaphore = hUARTRxSemaphore;
    uartParserParameter.hRxQueue = hUARTRxQueue;
    uartParserParameter.sender = MSG_SENDER_UART;

    xTaskCreate(taskParser, (CHAR*)"UARTPARS", STACK_SIZE_PARSER,
                &uartParserParameter, tskIDLE_PRIORITY + 1, &hUARTParserTask);

    return;
}

// @param pvParameter The
void taskParser(void* pvParameter)
{
    xParserParameterHandle passedIn =(xParserParameterHandle)pvParameter;

    // This is the timeout variable. It defaults to infinite blocking
    portTickType delayTime = portMAX_DELAY;

    xParserState state = {.mode = PKT_SEARCH_HDR, .pktIndex = 0};

    // This preliminary take ensures the semaphore is clear
    // before the infinite loop is entered.
    xSemaphoreTake(passedIn->hRxSemaphore, 0);

    for(;;)
    {
        // Now wait until the character received event happens.
        xSemaphoreTake(passedIn->hRxSemaphore, delayTime);

        // To get here, atleast 1 character has shown up in the
        // rxQueue.
        SearchForPacket(&state, passedIn->msgBuffer, passedIn->hRxQueue, passedIn->sender);
    }

    /* Should the task implementation ever break out of the above loop
    then the task must be deleted before reaching the end of this function.
    The NULL parameter passed to the vTaskDelete() function indicates that
    the task to be deleted is the calling (this) task. */
    vTaskDelete( NULL );
}

void SearchForPacket(xParserState *state, CHAR8 buffer[], xSimpleQueueHandle rQueue, UINT16 sender)
{
    
}

