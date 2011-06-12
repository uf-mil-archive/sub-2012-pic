#include "p33Fxxxx.h"
#include "HardwareProfile.h"

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"

#include "taskUART.h"
#include "taskParser.h"
#include "taskPublisher.h"
#include "messages.h"
#include "adc.h"

// Configuration Bits
_FOSCSEL(IESO_OFF & FNOSC_FRC)
_FOSC(FCKSM_CSECMD & OSCIOFNC_OFF & POSCMD_EC)
_FWDT(FWDTEN_OFF)
_FICD(ICS_PGD3 & JTAGEN_OFF)
_FPOR(PWMPIN_ON & HPOL_ON & LPOL_ON & ALTI2C_OFF)

// Function declarations
static void clockInit(void);

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

int main(void)
{
    /* These should be the first two calls in main - always!*/
    clockInit();
    ioMap();

    LED_TRIS = OUTPUT_PIN;
    LED = LED_OFF;

//	EROM_Clear();  // Erases the entire EEPROM

    CRC16Init();    // Just get this ready for later. Doesn't hurt to be called here
    InitCommonMessageData();
	ADCInit();

    //// This task is started first(!) so the UART Queue exists and we can begin
    // printing boot messages, etc.
    xUARTTaskInit();
    xParserTaskInit();
    xPublisherTaskInit();

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

    // Clear the IOLOCK bit
    __builtin_write_OSCCONL(OSCCON & 0xFFBF);

    /********** EROM SPI ***************/

    // Inputs
    EROM_SDI_PINREG = EROM_SDI_PIN;
    // Outputs
    EROM_SCK_PIN = EROM_SPIxSCK_IO;
#if defined EROM_SDO_PIN
    EROM_SDO_PIN = EROM_SPIxSDO_IO;
#endif

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