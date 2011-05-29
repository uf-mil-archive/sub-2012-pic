#include "taskPublisher.h"

xTaskHandle hPublisherTask;
portBASE_TYPE gPublishPeriod;

void xPublisherTaskInit(void)
{
    // Read in publish rate from ROM and convert to ticks period
    INT16 rate = 0xFF;
    
    if(rate == 0xFF)        // Rate is empty
        rate = PBL_DEFAULT_RATE;

    gPublishPeriod = ((1000 / rate) / portTICK_RATE_MS);

    xTaskCreate(taskPublisher, (CHAR*)"UARTPUB", STACK_SIZE_PUBLISHER,
                NULL, tskIDLE_PRIORITY + 1, &hPublisherTask);

    return;
}

void taskPublisher(void* pvParameter)
{
    portTickType previousWakeTime;

    /*  Initialize the frequency counter. Using vTaskDelayUntil guarantees
        a constant publishing frequency */
    previousWakeTime = xTaskGetTickCount();

    for(;;)
    {
        // Block here until the timeout has passed
        vTaskDelayUntil(&previousWakeTime, gPublishPeriod);

        BYTE* pkt = NULL;

        if(!hMotorData) // Nothing to publish
            continue;

        INT16 length = BuildOutgoingBROLPacket(hMotorData, previousWakeTime, &pkt);

        // Publish to who?
        COMPut((CHAR8*)pkt, length, UART_DONT_FREE_BUFFER);
    }
}
