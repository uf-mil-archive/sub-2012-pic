#include "taskADC.h"
#include "mcp4821.h"

static volatile BOOL adcMAVGsInited = FALSE;
static portBASE_TYPE gADCPeriod;

xSemaphoreHandle hCommonSPIMutex;
xTaskHandle hADCTask;
RailData gRailData;
RailConfig gRailConfig;

// Paul - concrete instances of your MAVG's. These can be arrays if you match
// the index number to a rail number. I was thinking something like batteries
// are 0,1,2, and 3 is the rail out, but you know your schematic so it's up to
// you.
static MAVGFilter vrail32MAVG[4];
static MAVGFilter vrail16MAVG[4];
static MAVGFilter current16MAVG;
static MAVGFilter current32MAVG;

static void InitRailConfig(void);

// Paul - read basically this whole file I left the ISR I used commented on the
// bottom so you can see some fixed point math examples.

void xADCTaskInit(void)
{
    // Allocate the mutex used for SPI access control
    hCommonSPIMutex = xSemaphoreCreateMutex();

    // This will pull in EEPROM settings if valid one's exist, otherwise, it writes
    // default configuration.
    InitRailConfig();   
    
    // Set your DAC voltages here, you can also do it in the initrailconfig. I
    // did it in the BDCMC equivalent of init rail config, but this looks cleaner here
    //DAC_SetOutput(rail1, ((float)gRailConfig.MaxCurrent16*gain / pow(2,10)) or something like that.
    
    // Setup any SPI specific stuff you need here for the A/D's
    // InitADC();

    // Fill the MAVG's now. You still have exclusive access to spi here since
    // the scheduler isn't running yet

    // First, poll ADC's to get ADC_MAVG_QUEUE_LENGTH measurements
    // Next, call MAVG_Init(&vrail16MAVG[0], dataYouGotFor16VRail0, ADC_MAVG_QUEUE_LENGTH)
    // for every filter.

    // Setup the period value for the task
    gADCPeriod = ((1000 / ADC_RATE) / portTICK_RATE_MS);
	
    xTaskCreate(taskADC, (CHAR*)"ADC", STACK_SIZE_ADC,
                NULL, tskIDLE_PRIORITY + 1, &hADCTask);

    return;
}

void taskADC(void* pvParameter)
{
    portTickType previousWakeTime;

    /*  Initialize the frequency counter. Using vTaskDelayUntil guarantees
        a constant publishing frequency */
    previousWakeTime = xTaskGetTickCount();

    for(;;)
    {
        // Block here until the timeout has passed - automatically updates
        // previous wake time. This throttles your loop
        vTaskDelayUntil(&previousWakeTime, gADCPeriod);

        // Pull in the latest ADC sample and call continue. Get the spi exclusively first
        xSemaphoreTake(hCommonSPIMutex, portMAX_DELAY); // This blocks until the semaphore is free
        {
            // ADCRead...
        }
        xSemaphoreGive(hCommonSPIMutex);

        //When you get about 50 or 100 samples, call update on the MAVG filters
       // if(counter++ % 100 != 99)
         //   continue;

        // Otherwise we update the filters
        //MAVG_Update(&vrail16MAVG[0], datayoupulledin, numberofsamples);
        // vrail16MAVG[0].CurrentAvg will now have the latest filtered data
        // you would put into gRailData, and then publish through your packet.
        // Rinse and repeat
    }

    /* Should the task implementation ever break out of the above loop
    then the task must be deleted before reaching the end of this function.
    The NULL parameter passed to the vTaskDelete() function indicates that
    the task to be deleted is the calling (this) task. */
    vTaskDelete( NULL );
}

static void InitRailConfig(void)
{
    BYTE c;
    BYTE *p;
    UINT16 d;
    RailConfig tmpConfig;    // Shadow copy to use when checking for valid EROM

    // First try to read in a valid RailConfig struct. If it doesn't exist,
    // or the checksum is invalid(power failure while programming), we build
    // and save the default template.

    p = (BYTE*)&tmpConfig;
    d = RAIL_EROM_BASE;

    // attempt to read in the config data from FLASH
    EROM_ReadBytes(d++, 1, &c);

    // read in the data structure from FLASH if it exists if not
    // just save our default configuration to FLASH
    if (c == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(RailConfig), p);

        // The two bytes after the structure are the checksum
        INT16 savedChk = EROM_ReadInt16(d + sizeof(RailConfig));

        if(CRC16Checksum(p, sizeof(RailConfig)) != savedChk)
            goto CONFIG_DEFAULT_RAIL;

        // it's a valid UDPConfigData struct - copy the shadow to the real one
        memcpy((void *)&gRailConfig, (void *)&tmpConfig, sizeof(RailConfig));

        return;
    }

    // Paul - when you edit the contents of the config structs, make sure you
    // add acceptable defaults after a label like this. It's ok to operate directly
    // on the global here, no matter what the internet might say. You shouldn't
    // have to edit the above import from EEPROM code, it should work fine.
CONFIG_DEFAULT_RAIL:
    gRailConfig.MaxCurrent16 = DEFAULT_MAX_CURRENT16;
    gRailConfig.MaxVoltage16 = DEFAULT_MAX_VOLTAGE16;
    gRailConfig.MinVoltage16 = DEFAULT_MIN_VOLTAGE16;

    // Save these settings into the EEPROM
    SaveRailConfig(&gRailConfig);
}

// Paul - this function will automatically append the app_version byte
// and checksum to the saved railconfig struct. You shouldn't need to edit this
// when you change the struct contents, it will figure it out.
void SaveRailConfig(RailConfig* railCfg)
{
    BYTE *p;
    UINT16 d, chk;
    BYTE appVers = APP_VERSION;

    p = (BYTE*)railCfg;
    // The base address + the app_config + app_config checksum size
    d = RAIL_EROM_BASE;

    // Calculate the checksum
    chk = CRC16Checksum(p, sizeof(RailConfig));

    // Write the app version
    EROM_WriteBytes(d++, 1, &appVers);

    // Copy out the RailConfig
    EROM_WriteBytes(d, sizeof(RailConfig), p);

    // Write the checksum
    EROM_WriteInt16((d + sizeof(RailConfig)), chk);
}

/*
void __attribute__((interrupt, no_auto_psv)) _DMA5Interrupt(void)
{
    LED = LED_ON;

    // The first time through is an initialization run really
    if(!adcMAVGsInited)
    {
        if(ADCCurrentDMABuffer == 0)
        {
            MAVG_Init(&vrailMAVG, &ADCBufferA.ADC1CH0[0], ADC_MAVG_QUEUE_LENGTH);
            MAVG_Init(&currentMAVG, &ADCBufferA.ADC1CH1[0], ADC_MAVG_QUEUE_LENGTH);
        }
        else
        {
            MAVG_Init(&vrailMAVG, &ADCBufferB.ADC1CH0[0], ADC_MAVG_QUEUE_LENGTH);
            MAVG_Init(&currentMAVG, &ADCBufferB.ADC1CH1[0], ADC_MAVG_QUEUE_LENGTH);
        }
        adcMAVGsInited = TRUE;
        goto ADC_DONE;
    }

    // Update the moving average
    if(ADCCurrentDMABuffer == 0)
    {
        MAVG_Update(&vrailMAVG, &ADCBufferA.ADC1CH0[0], ADC_DMA_BUFFER_SIZE);
        MAVG_Update(&currentMAVG, &ADCBufferA.ADC1CH1[0], ADC_DMA_BUFFER_SIZE);
    }
    else
    {
        MAVG_Update(&vrailMAVG, &ADCBufferB.ADC1CH0[0], ADC_DMA_BUFFER_SIZE);
        MAVG_Update(&currentMAVG, &ADCBufferB.ADC1CH1[0], ADC_DMA_BUFFER_SIZE);
    }    

    if(hMotorData)
    {
        // Q12_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q6_10 in the motor
        // struct, so shift to generate final result
        hMotorData->VRail = (Q6_10)((vrailMAVG.CurrentAvg*ADC_VRAIL_BPV) >> 5);
        // Q12_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q4_12 in the motor
        // struct, so shift to generate final result
        hMotorData->Current = (Q4_12)((currentMAVG.CurrentAvg*ADC_CURRENT_BPA) >> 3);
    }

ADC_DONE:
    ADCCurrentDMABuffer ^= 1; // Toggle to other buffer
    IFS3bits.DMA5IF = 0;    // Clear the DMA0 interrupt flag

    LED = LED_OFF;
}
*/
