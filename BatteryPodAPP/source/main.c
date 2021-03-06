////////////////////////////////////////////////////////////////////////////////
// BatteryPod Board Main
////////////////////////////////////////////////////////////////////////////////
#include "p33Fxxxx.h"
#include "HardwareProfile.h"

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"

#include "taskUART.h"
#include "taskParser.h"
#include "taskTCPIP.h"
#include "taskPublisher.h"
#include "messages.h"
//#include "mcp4821.h"
#include "HallSwitches.h"
#include "buzzer.h"
#include "I2C_FanControl.h"


// Configuration Bits
_FOSCSEL(IESO_OFF & FNOSC_FRC)
_FOSC(FCKSM_CSECMD & OSCIOFNC_OFF & POSCMD_EC)
_FWDT(FWDTEN_OFF)
_FICD(JTAGEN_OFF)
_FPOR(PWMPIN_ON & HPOL_ON & LPOL_ON & ALTI2C_OFF)

/*************************/
/*  FUNCTION PROTOTYPES  */
/*************************/
static void clockInit(void);

/**********************/
/*  Global Variables  */
/**********************/
//I2C_DRV i2cfan = I2C_FANDRV_DEFAULTS;


// C30 Exception Handlers
// If your code gets here, you either tried to read or write
// a NULL pointer, or your application overflowed the stack
// by having too many local variables or parameters declared.
void _ISR __attribute__((__no_auto_psv__)) _AddressError(void)
{
    Nop();
    Nop();
}

void _ISR __attribute__((__no_auto_psv__)) _StackError(void)
{
    Nop();
    Nop();
}

////////////////////////////////////////////////////////////////////////////////
//                                 MAIN
////////////////////////////////////////////////////////////////////////////////
int main(void)
{
    /* These should be the first two calls in main - always!*/
    clockInit();
    ioMap();
    hallSwInit() ;              // Initialize HALL SW interupts
    buzzerInit();
    I2Cinit(&i2cfan);

//    FanFullOn(&i2cfan);
    FanFullOff(&i2cfan);

//	DAC_SetOutput(2.5, DAC_RAIL_16);	
//	DAC_SetOutput(2.0, DAC_RAIL_32);
	

    BUZZER = BUZZER_OFF;        // initial state of buzzer is off
    LED = LED_OFF;              // initial state of debug LED is off

    LED_TRIS = OUTPUT_PIN;
    LED = LED_OFF;

//	EROM_Clear();  // Erases the entire EEPROM

    CRC16Init();    // Just get this ready for later. Doesn't hurt to be called here
    InitCommonMessageData();

    //// This task is started first(!) so the UART Queue exists and we can begin
    // printing boot messages, etc.
    xADCTaskInit();
    //xUARTTaskInit();
   // xTCPIPTaskInit();
   // xParserTaskInit();
   // xPublisherTaskInit();

    vTaskStartScheduler();

    return 1;
}
/*****************************************************************************
  Function:
        static void ioMap(void)
  Summary:

  Description:

 ***************************************************************************/
void ioMap(void)
{
    // Map the Analog pins
    AD1PCFGL = ANCONFIG;

    // set LED Pin as an output
    LED_TRIS = OUTPUT_PIN;

    // set Buzzer Pin as an output
    BUZZER_TRIS = OUTPUT_PIN;

    // Initialize the ADC CS pins and set them to fasle
    ADC16_CS_TRIS = OUTPUT_PIN;
    ADC16_CS_IO = AL_FALSE;

    ADC32_CS_TRIS = OUTPUT_PIN;
    ADC32_CS_IO = AL_FALSE;

    // Initialize the Highside Controler pins as ouputs and turn them off
    RAIL16_TRIS = OUTPUT_PIN;   //16V Rail Control
    RAIL16 = TURN_OFF;

    RAIL32_TRIS = OUTPUT_PIN ;   //32V Rail Control
    RAIL32 = TURN_OFF;

    /********** Initialize the open drain pins ***************/
    ODCA = ODCACONFIG;
    ODCB = ODCBCONFIG;
    ODCC = ODCCCONFIG;

    // Clear the IOLOCK bit
    __builtin_write_OSCCONL(OSCCON & 0xFFBF);


    /********** ENC SPI ***************/
/*
    // Inputs
    ENC_SDI_PINREG = ENC_SDI_PIN;
    // Outputs
    ENC_SCK_PIN = ENC_SPIxSCK_IO;
    #if defined ENC_SDO_PIN
        ENC_SDO_PIN = ENC_SPIxSDO_IO;
    #endif
*/

    /********** Multiple Devices SPI ***************/
    // Inputs
    EROM_SDI_PINREG = EROM_SDI_PIN;
    // Outputs
    EROM_SCK_PIN = EROM_SPIxSCK_IO;
    EROM_SDO_PIN = EROM_SPIxSDO_IO;

    /********** Communication UART ***************/
    // Inputs
    COM_URX_PINREG = COM_URX_PIN;
    // Outputs
    COM_UTX_PIN = COM_UxTX_IO;


    // Lock the IOLOCK bit so that the IO is not accidentally changed.
    __builtin_write_OSCCONL(OSCCON | 0x0040);
}//end ioMap()



void vApplicationStackOverflowHook( void )
{
    /* Look at pxCurrentTCB to see which task overflowed its stack. */
    while (1)
    {
        portNOP();
    }
}


/*****************************************************************************
  Function:
        static void clockInit(void)
  Summary:
        Changes to the pll clock source to achieve 40 mips
  Description:
        Call first after power on to switch from non-PLL EC.
        It changes the multiplier and two dividers to allow
        for 10MHz input to produce 80MHz (2*Fcy)
 ***************************************************************************/
static void clockInit(void)
{
    PLLFBD = 0x1E; // M=32
    CLKDIVbits.PLLPOST = 0; // N2 = 2
    CLKDIVbits.PLLPRE = 0; // N1 = 2
    __builtin_write_OSCCONH(0x03); // Select Pri/PLL clock
    __builtin_write_OSCCONL(0x01); // Request clock switch
    while (OSCCONbits.COSC != 0b011); // Wait for oscillator to switch
}
