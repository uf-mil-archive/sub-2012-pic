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


////////////////////////////////////////////////////////////////////////////////
//START ADC DRIVER CODE
////////////////////////////////////////////////////////////////////////////////



#if defined(ADC16_CS_IO) || defined(ADC32_CS_IO)

UINT16 ADC16Val [NUM_ADCS][NUM_ADC_SAMPLES];     //array for ADC16 values
UINT16 ADC32Val [NUM_ADCS][NUM_ADC_SAMPLES];     //array for ADC32 values

INT16 ADC_IsInited = 0;

struct SavedSPI
{
    UINT16 CON1;
    UINT16 CON2;
    UINT16 STAT;
}ADC_savedSPI;

/******************************************************************************/

void ADC_saveSPI()
{
    ADC_savedSPI.CON1 = ADC_SPIxCON1;
    ADC_savedSPI.CON2 = ADC_SPIxCON2;
    ADC_savedSPI.STAT = ADC_SPIxSTAT;
}
/******************************************************************************/

void ADC_restoreSPI()
{
    // Disable the SPI
    ADC_SPIxSTATbits.SPIEN = 0;

    // Write back the saved configuration
    ADC_SPIxCON1 = ADC_savedSPI.CON1;
    ADC_SPIxCON2 = ADC_savedSPI.CON2;
    ADC_SPIxSTAT = ADC_savedSPI.STAT;
}
/******************************************************************************/

void ADC_configSPI(void)
{
    // Make sure the ADC pins have been initialized correctly
    if(!ADC_IsInited)
    {
        ADC16_CS_TRIS = OUTPUT_PIN;
        ADC16_CS_IO = AL_FALSE;

        ADC32_CS_TRIS = OUTPUT_PIN;
        ADC32_CS_IO = AL_FALSE;

        ADC_IsInited = TRUE;
    }

    // Disable the SPI to reconfigure for the ADC
    ADC_SPIxSTATbits.SPIEN = 0;

    ADC_saveSPI();

    // This assumes a 40Mhz instruction clock to get Divided SPI Clock
    //ADC_SPIxCON1 = 0x0522;   //... 0010 0010   1.25MHz
    ADC_SPIxCON1 = 0x0532;   //... 0011 0010   2.5MHz
    // Bits 15-13 = 000  Unimplemented
    // Bit 12 = 0        SCK pin is controlled by SPI
    // Bit 11 = 0        SDO pin is controlled by SPI
    // Bit 10 = 1        16 bit data mode(16 clks per write)
    // Bit 9 = 0         Sample in middle of output time
    // Bit 8 = 1         Output data changes at falling edge
    // Bit 7 = 0         Not used in master mode
    // Bit 6 = 0         SCK is active high
    // Bit 5 = 1         SPI is in master mode
    // Bits 4-2 = 100    Secondary clock prescalar 4:1 for 2.5MHz
    // Bits 4-2 = 000    Secondary clock prescalar 8:1 for 1.25 MHz
    // Bits 1-0 = 10     Primary clock prescalar 4:1

    ADC_SPIxCON2 = 0x0000;  // Framing is not used, keep this register cleared
                            // for it to stay disabled

    // Reenable the SPI, clearing any overflow flags.
    ADC_SPIxSTAT = 0x8000;
}
/******************************************************************************/

void ADC_ScatterGatherData(int adcSel, UINT16* buff)
{
   

    ADC_configSPI();

    volatile UINT16 adcADDR;      // shifted address to send to ADC
    volatile UINT16 nextAddr;     // counter for pre-shifted address

    while(ADC_SPIxSTATbits.SPITBF);    // Make sure the buffer is ready

    if (adcSel == 0 ){   // IF it is a 0 then check 16volt rail else 32
                                        // prepare to send by lowering CS
        ADC16_CS_IO = AL_TRUE;
    } else {
        ADC32_CS_IO = AL_TRUE;
    }

    for (nextAddr = 1; nextAddr <= 5; nextAddr++)
    {
        adcADDR = (nextAddr % 5) << 11;
        // Send out the adc address to read next (0-7 in bits 12,11,10)
        // and fill buffer with current address
        ADC_SPIxBUF = adcADDR;

        while(!ADC_SPIxSTATbits.SPIRBF);    // Wait for transmission to complete

        // copy the ADC value from the buffer and trim off trailing zeroes
        *(buff+((nextAddr-1)*NUM_ADC_SAMPLES)) = (ADC_SPIxBUF >> 2);
    }

    if (adcSel == 0) {       // ADC array now has fresh data
        ADC16_CS_IO = AL_FALSE;
    }else{
       ADC32_CS_IO = AL_FALSE;
    }

    // Put the SPI back how it was
 	
	   
    ADC_restoreSPI();

}

/******************************************************************************/

#endif


void xADCTaskInit(void)
{
	UINT16 i = 0;

    // Allocate the mutex used for SPI access control
    hCommonSPIMutex = xSemaphoreCreateMutex();

    // This will pull in EEPROM settings if valid one's exist, otherwise, it writes
    // default configuration.
    InitRailConfig();   
    
    // Set your DAC voltages here, you can also do it in the initrailconfig. I
    // did it in the BDCMC equivalent of init rail config, but this looks cleaner here
    //DAC_SetOutput(rail1, ((float)gRailConfig.MaxCurrent16*gain / pow(2,10)) or something like that.

    // Fill the MAVG's now. You still have exclusive access to spi here since
    // the scheduler isn't running yet

    // First, poll ADC's to get ADC_MAVG_QUEUE_LENGTH measurements
    // Next, call MAVG_Init(&vrail16MAVG[0], dataYouGotFor16VRail0, ADC_MAVG_QUEUE_LENGTH)
    // for every filter.
     for (i=0; i < NUM_ADC_SAMPLES; i++)
     {
         ADC_ScatterGatherData(ADC_RAIL_16, &ADC16Val[0][i]);
         ADC_ScatterGatherData(ADC_RAIL_32, &ADC32Val[0][i]);
     }

	MAVG_Init(&current16MAVG, &ADC16Val[0][0], ADC_MAVG_QUEUE_LENGTH);
    MAVG_Init(&current32MAVG, &ADC32Val[0][0], ADC_MAVG_QUEUE_LENGTH);
   
   // Otherwise we update the filters
   for (i=1; i < NUM_ADCS ; i++)
   {
       // Update the adc's moving average filter
       MAVG_Init(&vrail16MAVG[i-1], &ADC16Val[i][0], ADC_MAVG_QUEUE_LENGTH);
       MAVG_Init(&vrail32MAVG[i-1], &ADC32Val[i][0], ADC_MAVG_QUEUE_LENGTH);   
   }

    // Setup the period value for the task
    gADCPeriod = ((1000 / ADC_RATE) / portTICK_RATE_MS);
	
    xTaskCreate(taskADC, (CHAR*)"ADC", STACK_SIZE_ADC,
                NULL, tskIDLE_PRIORITY + 1, &hADCTask);

    return;
}

void taskADC(void* pvParameter)
{
    portTickType previousWakeTime;
    int i = 0;
	Q6_10 highestVoltage16, highestVoltage32;
	UINT16 warningBuzzerDelay = 0;
	UINT16 overCurrentDelayCntr_Rail16 = 0;
	UINT16 overCurrentDelayCntr_Rail32 = 0;

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
            for (i=0; i < NUM_ADC_SAMPLES; i++)
            {
                ADC_ScatterGatherData(ADC_RAIL_16, &ADC16Val[0][i]);
                ADC_ScatterGatherData(ADC_RAIL_32, &ADC32Val[0][i]);
            }
        }
        xSemaphoreGive(hCommonSPIMutex);

         MAVG_Update(&current16MAVG, &ADC16Val[0][0], NUM_ADC_SAMPLES);
         gRailData.Current16 = (Q7_9)((current16MAVG.CurrentAvg*ADC_CURRENT16_APB) >> 6);

         MAVG_Update(&current32MAVG, &ADC32Val[0][0], NUM_ADC_SAMPLES);
         gRailData.Current32 = (Q6_10)((current32MAVG.CurrentAvg*ADC_CURRENT32_APB) >> 5);

        // Otherwise we update the filters
        for (i=1; i < NUM_ADCS ; i++)
        {
            // Update the adc's moving average filter
            MAVG_Update(&vrail16MAVG[i-1], &ADC16Val[i][0], NUM_ADC_SAMPLES);

            // Copy the latest average to the message data struct
            // Q10_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q6_10 in the rail
            // struct, so shift to generate final result
            gRailData.VRail16[i-1] = (Q6_10)((vrail16MAVG[i-1].CurrentAvg*ADC_VRAIL16_BPV) >> 5);


            MAVG_Update(&vrail32MAVG[i-1], &ADC32Val[i][0], NUM_ADC_SAMPLES);
            gRailData.VRail32[i-1] = (Q6_10)((vrail32MAVG[i-1].CurrentAvg*ADC_VRAIL32_BPV) >> 5);
        }

            /***************************/
            /** Check for low voltage **/
	    /***************************/
		
            // Find max Supply Voltages for 16 and 32 volt rail and store to a temp var
            highestVoltage16 = gRailData.VRail16[1];
            highestVoltage16 = (gRailData.VRail16[2] > highestVoltage16) ? gRailData.VRail16[2] : highestVoltage16;
            highestVoltage16 = (gRailData.VRail16[3] > highestVoltage16) ? gRailData.VRail16[3] : highestVoltage16;

            highestVoltage32 = gRailData.VRail32[1];
            highestVoltage32 = (gRailData.VRail32[2] > highestVoltage32) ? gRailData.VRail32[2] : highestVoltage32;
            highestVoltage32 = (gRailData.VRail32[3] > highestVoltage32) ? gRailData.VRail32[3] : highestVoltage32;

            if ( (gRailData.state&1 == 1) && (highestVoltage16 <= gRailConfig.MinVoltage16) ){
                RailControl(CONTROL_RAIL_BOTH, TURN_OFF);
                warningBuzzerDelay=0;
            }
            else if ((gRailData.state&8 == 8) && (highestVoltage32 <= gRailConfig.MinVoltage32)){
                RailControl(CONTROL_RAIL_32, TURN_OFF);
            
			}else{
                if ( ((gRailData.state&1 == 1) && (highestVoltage16 <= gRailConfig.WarnVoltage16 )) ||
                     ((gRailData.state&8 == 8) && (highestVoltage32 <= gRailConfig.WarnVoltage32 )) ){

                if (warningBuzzerDelay >= 250){
                        buzz(LOWPOWER_SONG);
                        warningBuzzerDelay = 0;
                    }else warningBuzzerDelay++;
                }else warningBuzzerDelay = 0;
            }


	/****************************/
	/** Check for over-current **/
	/****************************/
      
            if (gRailData.Current16 > gRailConfig.MaxCurrent16)
            {
                if (overCurrentDelayCntr_Rail16 >= OVER_CURRENT_DELAY) {
                    RailControl(CONTROL_RAIL_BOTH, TURN_OFF);
                }else{
                    overCurrentDelayCntr_Rail16++;
                }
            }else{
                    overCurrentDelayCntr_Rail16 = 0;
            }

            if (gRailData.Current32 > gRailConfig.MaxCurrent32){
                if (overCurrentDelayCntr_Rail32 >= OVER_CURRENT_DELAY) {
                    RailControl(CONTROL_RAIL_32, TURN_OFF);

                }else{
                    overCurrentDelayCntr_Rail32++;
                }
            }else{
                overCurrentDelayCntr_Rail32 = 0;
                if ( ((gRailData.state & MERGE_STATE_MASK_RAIL16) == TURN_ON) &&
                     ((gRailData.state & MERGE_STATE_MASK_RAIL32) == TURN_OFF) )
                    RailControl(CONTROL_RAIL_32, TURN_ON);
            }


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
    gRailConfig.WarnVoltage16 = DEFAULT_WARN_VOLTAGE16;
    gRailConfig.MaxCurrent32 = DEFAULT_MAX_CURRENT32;
    gRailConfig.MaxVoltage32 = DEFAULT_MAX_VOLTAGE32;
    gRailConfig.MinVoltage32 = DEFAULT_MIN_VOLTAGE32;
    gRailConfig.WarnVoltage32 = DEFAULT_WARN_VOLTAGE32;


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


void RailControl(UINT8 rail, UINT8 action){
    // rail = 0 is 16V Rail but turns off both
    // rail = 1 is 32V Rail
    // rail = 2 is BOTH Rails

    // action = 0 is off
    // action = 1 is on

    switch (rail)
    {
        case 0:
                RAIL16 = action;        //turn on/off 16 Volt Rail

                if (action == 0){
                    gRailData.state &= ~9 ;	//change the rail16 and rail32 state flag to off
                    buzz(OFF_SONG);
                }else{
                    gRailData.state |= 9 ;     //chage the rail16 and rail32 state flag to on
                    buzz(ON_SONG);
                }
                break;
        case 1:
                RAIL32 = action;
                if (action == 0){
                    gRailData.state &= ~8 ;	//change the rail32 state flag to off
                    buzz(OFF_SONG);
                }else{
                    gRailData.state |= 8 ;     //chage the rail32 state flag to on
                    buzz(ON_SONG);
                }
                break;

        case 2:
                RAIL32 = action;
                RAIL16 = action;

                 if (action == 0){
                    gRailData.state &= ~9 ;	//change the rail16 and rail32 state flag to off
                    buzz(OFF_SONG);
                }else{
                    gRailData.state |= 9 ;     //chage the rail16 and rail32 state flag to on
                    buzz(ON_SONG);
                }
                break;
    }//end Switch

}//end function


