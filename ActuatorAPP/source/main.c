////////////////////////////////////////////////////////////////////////////////
// Actuator Board - Main
////////////////////////////////////////////////////////////////////////////////
#include "p33Fxxxx.h"
#include "HardwareProfile.h"
#include "cheesyUART.h"


#define OFF     0
#define ON      1
#define DISABLE 2

#define BALLDROPPER     CTRL1
#define SHOOTER_LEFT    CTRL2
#define SHOOTER_RIGHT   CTRL3
#define GRABBER_LEFT    CTRL4
#define GRABBER_RIGHT   CTRL5

#define BALLDROP_TIMEOUT 5      //in seconds
#define SHOOTER_TIMEOUT 5
#define GRABBER_TIMEOUT 5 

#define BALLDROP_DISABLE_TIMEOUT 5      //in seconds
#define SHOOTER_DISABLE_TIMEOUT 5      //in seconds
#define GRABBER_DISABLE_TIMEOUT 5      //in seconds

#define BALLDROPPER_MASK    (1<<0)
#define SHOOTER_LEFT_MASK   (1<<1)
#define SHOOTER_RIGHT_MASK  (1<<2)
#define GRABBER_LEFT_MASK   (1<<3)
#define GRABBER_RIGHT_MASK  (1<<4)

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
    timerInit();

    LED = LED_OFF;              // initial state of debug LED is off

    // Sates for Actuators
   
    BYTE ballDropState      = OFF;
    BYTE shooterLeftState   = OFF;
    BYTE shooterRightState  = OFF;
    BYTE grabberLeftState   = OFF;
    BYTE grabberRightState  = OFF;

    int ballDropOnTimer = 0;
    int ballDropDisableTimer = 0;
    int shooterLeftOnTimer = 0;
    int shooterLeftDisableTimer = 0;
    int shooterRightOnTimer = 0;
    int shooterRightDisableTimer = 0;
    int grabberLeftOnTimer = 0;
    int grabberLeftDisableTimer = 0;
    int grabberRightOnTimer = 0;
    int grabberRightDisableTimer = 0;

    /*LOOP*/
    for(;;){
     
    if (timerFlag) {
        timerFlag = 0;
        UARTSendChar((char)LIMITSW);

        //ball Droper timeout delays
        if (ballDropState == ON){
            ballDropOnTimer++;
        }else{
            ballDropOnTimer = 0;
        }

        if(ballDropState == DISABLE) {
            ballDropDisableTimer++;
        }else{
            ballDropDisableTimer = 0;
        }

        //shooter left timeout delays
        if (shooterLeftState == ON){
            shooterLeftOnTimer++;
        }else{
            shooterLeftOnTimer = 0;
        }

        if(shooterLeftState == DISABLE) {
            shooterLeftDisableTimer++;
        }else{
            shooterLeftDisableTimer = 0;
        }

        //shooter right timeout delays
        if (shooterRightState == ON){
            shooterRightOnTimer++;
        }else{
            shooterRightOnTimer = 0;
        }

        if(shooterRightState == DISABLE) {
            shooterRightDisableTimer++;
        }else{
            shooterRightDisableTimer = 0;
        }

       //grabber left timeout delays
        if (grabberLeftState == ON){
            grabberLeftOnTimer++;
        }else{
            grabberLeftOnTimer = 0;
        }

        if(grabberLeftState == DISABLE) {
            grabberLeftDisableTimer++;
        }else{
            grabberLeftDisableTimer = 0;
        }

        //grabber right timeout delays
        if (grabberRightState == ON){
            grabberRightOnTimer++;
        }else{
            grabberRightOnTimer = 0;
        }

        if(grabberRightState == DISABLE) {
            grabberRightDisableTimer++;
        }else{
            grabberRightDisableTimer = 0;
        }


    }//end timer routine

    //balldropper timeout logic
    if (ballDropState == ON && ballDropOnTimer == (50 * BALLDROP_TIMEOUT)){
        ballDropState = DISABLE;
        BALLDROPPER = OFF;
    }else if (ballDropState == DISABLE && ballDropDisableTimer == (50 * BALLDROP_DISABLE_TIMEOUT)){
        ballDropState = OFF;
        BALLDROPPER = OFF;
    }else if (ballDropState != DISABLE){
        ballDropState = ((actuators & BALLDROPPER_MASK) > 0) ? ON:OFF;
        BALLDROPPER = ((actuators & BALLDROPPER_MASK) > 0) ? ON:OFF;
    }
   
    //shooterleft timeout logic
    if (shooterLeftState == ON && shooterLeftOnTimer == (50 * SHOOTER_TIMEOUT)){
        shooterLeftState = DISABLE;
        SHOOTER_LEFT = OFF;
    }else if (shooterLeftState == DISABLE && shooterLeftDisableTimer == SHOOTER_DISABLE_TIMEOUT){
        shooterLeftState = OFF;
        SHOOTER_LEFT = OFF;
    }else if (shooterLeftState != DISABLE){
        shooterLeftState = ((actuators & SHOOTER_LEFT_MASK) > 0) ? ON:OFF;
        SHOOTER_LEFT = ((actuators & SHOOTER_LEFT_MASK) > 0) ? ON:OFF;
    }

    //shooterright timeout logic
    if (shooterRightState == ON && shooterRightOnTimer == (50 * SHOOTER_TIMEOUT)){
        shooterRightState = DISABLE;
        SHOOTER_RIGHT = OFF;
    }else if (shooterRightState == DISABLE && shooterRightDisableTimer == SHOOTER_DISABLE_TIMEOUT){
        shooterRightState = OFF;
        SHOOTER_RIGHT = OFF;
    }else if (shooterRightState != DISABLE){
        shooterRightState = ((actuators & SHOOTER_RIGHT_MASK) > 0) ? ON:OFF;
        SHOOTER_RIGHT = ((actuators & SHOOTER_RIGHT_MASK) > 0) ? ON:OFF;
    }


    //grabberleft timeout logic
    if (grabberLeftState == ON && grabberLeftOnTimer == (50 * GRABBER_TIMEOUT)){
        grabberLeftState = DISABLE;
        GRABBER_LEFT = OFF;
    }else if (grabberLeftState == DISABLE && grabberLeftDisableTimer == GRABBER_DISABLE_TIMEOUT){
        grabberLeftState = OFF;
        GRABBER_LEFT = OFF;
    }else if (grabberLeftState != DISABLE){
        grabberLeftState = ((actuators & GRABBER_LEFT_MASK) > 0) ? ON:OFF;
        GRABBER_LEFT = ((actuators & GRABBER_LEFT_MASK) > 0) ? ON:OFF;
    }

    //grabbberright timeout logic
    if (grabberRightState == ON && grabberRightOnTimer == (50 * GRABBER_TIMEOUT)){
        grabberRightState = DISABLE;
        GRABBER_RIGHT = OFF;
    }else if (grabberRightState == DISABLE && grabberRightDisableTimer == GRABBER_DISABLE_TIMEOUT){
        grabberRightState = OFF;
        GRABBER_RIGHT = OFF;
    }else if (grabberRightState != DISABLE){
        grabberRightState = ((actuators & GRABBER_RIGHT_MASK) > 0) ? ON:OFF;
        GRABBER_RIGHT = ((actuators & GRABBER_RIGHT_MASK) > 0) ? ON:OFF;
    }

    }//end main loop

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

    LED_TRIS = OUTPUT_PIN;
    CTRL1_TRIS = OUTPUT_PIN;
    CTRL2_TRIS = OUTPUT_PIN;
    CTRL3_TRIS = OUTPUT_PIN;
    CTRL4_TRIS = OUTPUT_PIN;
    CTRL5_TRIS = OUTPUT_PIN;
    LIMITSW_TRIS = INPUT_PIN;

    
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


