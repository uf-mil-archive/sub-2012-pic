////////////////////////////////////////////////////////////////////////////////
// Hall Effect Switches (source)                     Authored by:   Paul Launier
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following code will initializing the Change notification inerupts on the
//  Hall sensor pins. The Behavior of the Hall effect switches will be defined
//  in the ISR
////////////////////////////////////////////////////////////////////////////////
#include "HallSwitches.h"
#include "p33FJ128MC804.h"

/************************Change Notification ISR*******************************/
// behaviors for the hall effect switches live here.
//

void __attribute__ ((__interrupt__, auto_psv)) _CNInterrupt(void)
{
    if (KILLSW == 0 || ONOFFSW == 0)
        LED = LED_OFF;
    else
        LED = LED_ON;

    IFS1bits.CNIF = 0;      // Clear CN interrupt
}

/******************************************************************************/

void hallSwInit(void)
{
    // set Kill and ON/Off switch as inputs and enable
    // the Change Notification interupt on thier pins
    KILLSW_TRIS = INPUT_PIN;
    KILLSW_CN   = CN_ENABLE;

    ONOFFSW_TRIS = INPUT_PIN;
    ONOFFSW_CN   = CN_ENABLE;

    INTCON1bits.NSTDIS = 1;     // disable Interupt nesting
    SRbits.IPL = 0;             //  CPU priority level is 8
    CORCONbits.IPL3 = 1;        // CPU interupt priority level is 8

    IPC4bits.CNIP = 7;          // Set Change Notice interrupt priority to 6
    IEC1bits.CNIE = 1;          // Enable CN interrupts
    IFS1bits.CNIF = 0;          // Reset CN interrupt

    return;
}
/*****************************************************************************/


