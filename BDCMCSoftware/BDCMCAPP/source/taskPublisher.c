#include "taskPublisher.h"

xTaskHandle hPublisherTask;
portBASE_TYPE gPublishPeriod;

void xPublisherTaskInit(void)
{
    // Read in publish rate from ROM and convert to ticks period

    
    if(gMessagingData.PublishRate == 0x00)        // Rate is empty
        gMessagingData.PublishRate = PBL_DEFAULT_RATE;

    gPublishPeriod = ((1000 / gMessagingData.PublishRate) / portTICK_RATE_MS);

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
        
        length = BuildOutgoingPacket(previousWakeTime);

        // Publish to who?
        if(gMessagingData.Subscribers & MSG_SENDER_UART)
            COMPut(&gMessagingData.OutBuffers[gMessagingData.CurrentOutBuffer][0],
                    length, UART_DONT_FREE_BUFFER); // Send over UART

        if(gMessagingData.Subscribers & MSG_SENDER_ETH)
            continue; // Send over UDP
    }
}
