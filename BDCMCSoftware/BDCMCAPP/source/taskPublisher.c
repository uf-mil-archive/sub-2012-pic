#include "taskPublisher.h"

xTaskHandle hPublisherTask;
portBASE_TYPE gPublishPeriod;

void SetNewPublishRate(INT16 rate)
{
    if(rate < PBL_MAX_RATE)
    {
        gOutgoingMsgData.PublishRate = rate;
        gPublishPeriod = ((1000 / rate) / portTICK_RATE_MS);
    }
}

void SetSubscriber(INT16 transport, BOOL state)
{
    if(state == TRUE)
        gOutgoingMsgData.Subscribers |= transport;
    else
        gOutgoingMsgData.Subscribers &= (~transport);
}

void xPublisherTaskInit(void)
{
    // Read in publish rate from ROM and convert to ticks period

    
    if(gOutgoingMsgData.PublishRate == 0x00)        // Rate is empty
        gOutgoingMsgData.PublishRate = PBL_DEFAULT_RATE;

    gPublishPeriod = ((1000 / gOutgoingMsgData.PublishRate) / portTICK_RATE_MS);

    xTaskCreate(taskPublisher, (CHAR*)"PUBLISH", STACK_SIZE_PUBLISHER,
                NULL, tskIDLE_PRIORITY + 1, &hPublisherTask);

    return;
}

void taskPublisher(void* pvParameter)
{
    INT16 length;
    portTickType previousWakeTime;

    /*  Initialize the frequency counter. Using vTaskDelayUntil guarantees
        a constant publishing frequency */
    previousWakeTime = xTaskGetTickCount();

    for(;;)
    {
        // Block here until the timeout has passed
        vTaskDelayUntil(&previousWakeTime, gPublishPeriod);

        if(!hMotorData) // Nothing to publish - this is also necessary since
                        // the packet builders don't check if motor data is valid.
            continue;
        
        if((hMotorData->Flags & MTR_FLAGMASK_MOTORCODE) == MTR_CODE_NONE)
            continue;

        BYTE* packet;
        length = BuildOutgoingPacket(&packet, previousWakeTime);

        // Publish to who?
        if(gOutgoingMsgData.Subscribers & MSG_SENDER_UART)
            COMSend(packet, length, MSG_DONT_FREE_BUFFER); // Send over UART

        if(gOutgoingMsgData.Subscribers & MSG_SENDER_ETH)
            continue; // Send over UDP
    }

    /* Should the task implementation ever break out of the above loop
    then the task must be deleted before reaching the end of this function.
    The NULL parameter passed to the vTaskDelete() function indicates that
    the task to be deleted is the calling (this) task. */
    vTaskDelete( NULL );
}
