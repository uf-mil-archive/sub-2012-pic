////////////////////////////////////////////////////////////////////////////////
// External Actuator Board - Main                                     PJL - 2012
////////////////////////////////////////////////////////////////////////////////
#include "p33Fxxxx.h"
#include "HardwareProfile.h"
#include "cheesyUART.h"

/************/
/*  MACROS  */
/************/
#define EVER ;;
// Pin 21 used for a test pin
#define TEST_PIN_TRIS  TRISBbits.TRISB13
#define TEST_PIN       LATBbits.LATB13


/*****************/
/*  CONFIG BITS  */
/*****************/
_FOSCSEL(IESO_OFF & FNOSC_FRC)
_FOSC(FCKSM_CSECMD & OSCIOFNC_ON & POSCMD_EC)
_FWDT(FWDTEN_OFF)
_FICD(JTAGEN_OFF)
_FPOR(PWMPIN_ON & HPOL_ON & LPOL_ON & ALTI2C_OFF)

/****************/
/*  PROTOTYPES  */
/****************/
static void clockInit(void);
void timerInit(void);
void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void);

/**********************/
/*  GLOBAL VARIABLES  */
/**********************/
BYTE actuators = 0;
BYTE UART_state = 0;

/****************************/
/*  C30 Exception Handlers  */
/****************************/
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
    timerInit();
    UARTInit();

    CTRL1 = TURN_OFF;
    CTRL2 = TURN_OFF;
    CTRL3 = TURN_OFF;
    CTRL4 = TURN_OFF;
    CTRL5 = TURN_OFF;
    CTRL6 = TURN_OFF;

    /*************/
    /* MAIN LOOP */
    /*************/
    for(EVER);
    return 1;
}

////////////////////////////////////////////////////////////////////////////////
//                            FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

/*****************************************************************************
  Function: static void ioMap(void)
 ***************************************************************************/
void ioMap(void)
{
    // Map the Analog pins
    AD1PCFGL = ANCONFIG;

    // Set I/O Directions
    CTRL1_TRIS = OUTPUT_PIN;
    CTRL2_TRIS = OUTPUT_PIN;
    CTRL3_TRIS = OUTPUT_PIN;
    CTRL4_TRIS = OUTPUT_PIN;
    CTRL5_TRIS = OUTPUT_PIN;
    CTRL5_TRIS = OUTPUT_PIN;
    SW1_TRIS = INPUT_PIN;
    SW2_TRIS = INPUT_PIN;

     // Clear the IOLOCK bit
    __builtin_write_OSCCONL(OSCCON & 0xFFBF);

    // Inputs
    COM_URX_PINREG = COM_URX_PIN;
    // Outputs
    COM_UTX_PIN = COM_UxTX_IO;

     // Lock the IOLOCK bit so that the IO is not accidentally changed.
    __builtin_write_OSCCONL(OSCCON | 0x0040);

}//end ioMap()


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
/*****************************************************************************/
/*****************************************************************************/
void timerInit(void){

    T4CONbits.TON = 0;      // Disable Timer
    T4CONbits.TCS = 0;      // Select internal instruction cycle clock
    T4CONbits.TGATE = 0;    // Disable Gated Timer mode
    T4CONbits.TCKPS = 0b11; // Select 1:256 Prescaler
    TMR4 = 0x00;            // Clear timer register
    PR4 = 1563;             // Load the period value (50 Hz)
    IPC6bits.T4IP = 0x01;   // Set Timer4 Interrupt Priority Level
    IFS1bits.T4IF = 0;      // Clear Timer4 Interrupt Flag
    IEC1bits.T4IE = 1;      // Enable Timer4 interrupt
    T4CONbits.TON = 1;      // Start/Stop Timer
   }
/*****************************************************************************/
/*****************************************************************************/
void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void)
{
    IFS1bits.T4IF = 0;      // Clear Timer1 Interrupt Flag
    UART_state = 0;         // Reset UART State.
    T4CONbits.TON = 0;      // Start/Stop Timer
    TMR4 = 0x00;            // Clear timer register
    UARTAcknowledge(ERROR);
}
/*****************************************************************************/
