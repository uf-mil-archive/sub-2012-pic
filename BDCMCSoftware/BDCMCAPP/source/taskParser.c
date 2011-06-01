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
    CHAR8 received; // used to store the latest character

    while(rQueue->count > 0) // Handles if multiple chars on queue
    {
        // Check for overrun
        if(state->pktIndex >= MSG_MAX_LENGTH)
        {
            state->mode = PKT_SEARCH_HDR;
            state->pktIndex = 0;
        }
        
        // Dequeue the character
        SDequeue(rQueue, &received);
        
        switch(state->mode)
        {
            case PKT_ESCAPED:
                /* If the character has been escaped, copy the next byte
                 * to the data buffer, no matter what. Don't forget to XOR
                 * to retrieve the real value again.
                 */
                buffer[state->pktIndex++] = (received ^ MSG_ESCAPE_XOR);
                state->mode = PKT_INMSG;
                break;
            case PKT_INMSG:
                /* Here, everything is kept with 2 exceptions. If we hit the escape
                 * character, then delete the escape character from the queue and
                 * switch to escape mode.
                 */
                if(received == MSG_ESCAPE)
                {
                    // The character is already dequeued, just change mode
                    state->mode = PKT_ESCAPED;
                }
                else if(received == MSG_FLAG)
                {
                    // Frame could be misaligned. Push back into INMSG
                    if(state->pktIndex == 0)
                        state->mode = PKT_INMSG;
                    else	// End of packet. Change mode back to search for new one.
                    {
                    	state->mode = PKT_SEARCH_HDR;
                        ParseNewPacket((BYTE *)buffer, state->pktIndex, sender);
                    }
                    state->pktIndex = 0;
                }
                else
                    buffer[state->pktIndex++] = received; // Copy data to buffer
                break;
            default:
                // Default to looking for packet flag
                if(received == MSG_FLAG)
                {
                    // We found a new flag. Switch to keeping data.
                    state->mode = PKT_INMSG;
                    state->pktIndex = 0;
                }
                break;
        }
    }
}

