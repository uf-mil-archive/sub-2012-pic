////////////////////////////////////////////////////////////////////////////////
// Actuator Board - Main
////////////////////////////////////////////////////////////////////////////////
#include "p33Fxxxx.h"
#include "HardwareProfile.h"
#include "cheesyUART.h"

#define OFF     0
#define ON      1
#define DISABLE 2

#define SEND_RATE 50        //in Hertz


// Configuration Bits
_FOSCSEL(IESO_OFF & FNOSC_FRC)
_FOSC(FCKSM_CSECMD & OSCIOFNC_ON & POSCMD_EC)
_FWDT(FWDTEN_OFF)
_FICD(JTAGEN_OFF)
_FPOR(PWMPIN_ON & HPOL_ON & LPOL_ON & ALTI2C_OFF)

/*************************/
/*  FUNCTION PROTOTYPES  */
/*************************/
static void clockInit(void);
void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void);
void timerInit(void);


/**********************/
/*  Global Variables  */
/**********************/
BYTE actuators;
BYTE timerFlag;


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
    UARTInit();

    BYTE ballDropState      = OFF;
    BYTE shooterLeftState   = OFF;
    BYTE shooterRightState  = OFF;
    BYTE grabberLeftState   = OFF;
    BYTE grabberRightState  = OFF;
    BYTE states             = OFF;

    int ballDropOnTimer          = 0;
    int ballDropDisableTimer     = 0;
    int shooterLeftOnTimer       = 0;
    int shooterLeftDisableTimer  = 0;
    int shooterRightOnTimer      = 0;
    int shooterRightDisableTimer = 0;
    int grabberLeftOnTimer       = 0;
    int grabberLeftDisableTimer  = 0;
    int grabberRightOnTimer      = 0;
    int grabberRightDisableTimer = 0;

    /* MAIN LOOP*/
    for(;;){


    }//end main loop

    return 1;
}
/*****************************************************************************
  Function: static void ioMap(void)
 ***************************************************************************/
void ioMap(void)
{
    CTRL1_TRIS = OUTPUT_PIN;
    CTRL2_TRIS = OUTPUT_PIN;
    CTRL3_TRIS = OUTPUT_PIN;
    CTRL4_TRIS = OUTPUT_PIN;
    CTRL5_TRIS = OUTPUT_PIN;
    CTRL5_TRIS = OUTPUT_PIN;
    LIMITSW1_TRIS = INPUT_PIN;
    LIMITSW1_TRIS = INPUT_PIN;

    
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
void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void)
{
    IFS1bits.T4IF = 0;      // Clear Timer1 Interrupt Flag
    timerFlag = 1;

}
/*****************************************************************************/


/*****************************************************************************/
void timerInit(void){

    T4CONbits.TON = 0;      // Disable Timer
    T4CONbits.TCS = 0;      // Select internal instruction cycle clock
    T4CONbits.TGATE = 0;    // Disable Gated Timer mode
    T4CONbits.TCKPS = 0b11; // Select 1:256 Prescaler
    TMR4 = 0x00;            // Clear timer register
    PR4 = 3125;             // Load the period value (50 Hz)
    IPC6bits.T4IP = 0x01;   // Set Timer4 Interrupt Priority Level
    IFS1bits.T4IF = 0;      // Clear Timer4 Interrupt Flag
    IEC1bits.T4IE = 1;      // Enable Timer1 interrupt
    T4CONbits.TON = 1;      // Start/Stop Timer
   }
/*****************************************************************************/


