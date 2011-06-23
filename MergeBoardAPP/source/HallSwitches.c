////////////////////////////////////////////////////////////////////////////////
// Hall Effect Switches (source)                     Authored by:   Paul Launier
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following code will initializing the Change notification inerupts on the
//  Hall sensor pins. The Behavior of the Hall effect switches will be defined
//  in the ISR
////////////////////////////////////////////////////////////////////////////////
#include "HallSwitches.h"
#include "p33Fxxxx.h"
#include "taskADC.h"



/************************Change Notification ISR*******************************/
// behaviors for the hall effect switches live here.
//

void __attribute__ ((__interrupt__, auto_psv)) _CNInterrupt(void)
{
    IFS1bits.CNIF = 0;      // Clear CN interrupt
    LED = ~ONOFFSW;
    BYTE currentState = 0;
    BYTE previousState = 0;
    
    previousState = gRailData.state & 7;
    
    //handle active low Hall Switches here
    currentState = ( ~(KILLSW<<2)&4 | ~(ONOFFSW<<1)&2 | (gRailData.state&1) )&7;

    //rail is currently on
    if ((gRailData.state & MERGE_FLAGMASK_CURRENT_RAILSTATE) > 0)
    {

        //rail is currently on
        if ((currentState>>1) == 2 && (previousState>>1) == 3)
            {
                //turn sub off
                RAIL16 = TURN_OFF;
                RAIL32 = TURN_OFF;
                //set rail flag = off
                currentState &= ~1 ;
            }
    }

    else        //rail is currently off
    {

        //rail is currently off
        if ((currentState>>1) == 3 && (previousState>>1) == 2)
            {
                //turn sub on
                RAIL16 = TURN_ON;
                RAIL32 = TURN_ON;
                //set rail flag = on
                currentState |= 1;
            }
    }

    //save states
    gRailData.state = currentState;
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

    gRailData.state = 0 ;
    gRailData.state = ( ~(KILLSW << 2)&4 | ~(ONOFFSW << 1)&2 )&7 ;
    
    INTCON1bits.NSTDIS = 1;     // disable Interupt nesting
    SRbits.IPL = 0;             //  CPU priority level is 8
    CORCONbits.IPL3 = 1;        // CPU interupt priority level is 8

    IPC4bits.CNIP = 7;          // Set Change Notice interrupt priority to 6
    IEC1bits.CNIE = 1;          // Enable CN interrupts
    IFS1bits.CNIF = 0;          // Reset CN interrupt

    return;
}
/*****************************************************************************/


