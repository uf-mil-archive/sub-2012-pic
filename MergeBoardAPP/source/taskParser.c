#include "taskParser.h"

xTaskHandle hParserTask;
xQueueHandle hParserQueue;


// Paul - you shouldn't need to add any changes here. This will get
// messages from the UDP or serial already, and invoke the ParseNewPacket
// in messages.c. You will need to edit that function

void xParserTaskInit(void)
{
    // Allocate the receive queue for the task
    hParserQueue = xQueueCreate(PARSER_QUEUE_SIZE, sizeof(RTOSMsg));

    xTaskCreate(taskParser, (CHAR*)"PARSER", STACK_SIZE_PARSER,
                NULL, tskIDLE_PRIORITY + 1, &hParserTask);

    return;
}

// @param pvParameter The
void taskParser(void* pvParameter)
{
    RTOSMsg msg;

    for(;;)
    {
        // Block here until a new message is ready to be sent
        xQueueReceive(hParserQueue, &msg, portMAX_DELAY);

        // To get here, a new message has shown up in the queue
        ParseNewPacket(msg.Buffer, msg.Length, msg.Sender);

        if(msg.Free)
            free(msg.Buffer);
    }

    /* Should the task implementation ever break out of the above loop
    then the task must be deleted before reaching the end of this function.
    The NULL parameter passed to the vTaskDelete() function indicates that
    the task to be deleted is the calling (this) task. */
    vTaskDelete( NULL );
}


