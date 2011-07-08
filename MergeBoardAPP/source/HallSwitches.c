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


/************************Change Notification ISR*******************************/
// behaviors for the hall effect switches live here.
//

void __attribute__ ((__interrupt__, auto_psv)) _CNInterrupt(void)
{
    IFS1bits.CNIF = 0;      // Clear CN interrupt
    BYTE currentState = 0;
    BYTE previousState = 0;
    
    previousState = gRailData.state & 15;

    //handle active low Hall Switches here
    currentState = ( ((KILLSW<<2)&4) | (~(ONOFFSW<<1)&2) | (gRailData.state&9) )&15;
    
    if ((gRailData.state & MERGE_STATE_MASK_RAIL16) > 0){	   //if rail is currently on

        //rail is currently on
        if (((currentState>>1)&3) == 2 && ((previousState>>1)&3) == 3){
            //turn sub off
            RailControl(CONTROL_RAIL_BOTH, TURN_OFF);
            FanFullOff(&i2cfan);
            currentState &= ~9 ;
        }//end rail on check
	
    }else{
        //rail is currently off
        if (((currentState>>1)&3) == 3 && ((previousState>>1)&3) == 2){
            //turn sub on
                
            // Find max Supply Voltages for 16 and 32 volt rail and store to a temp var
            Q6_10 temp16 = gRailData.VRail16[1];
            temp16 = (gRailData.VRail16[2] > temp16) ? gRailData.VRail16[2] : temp16;
            temp16 = (gRailData.VRail16[3] > temp16) ? gRailData.VRail16[3] : temp16;

            Q6_10 temp32 = gRailData.VRail32[1];
            temp32 = (gRailData.VRail32[2] > temp32) ? gRailData.VRail32[2] : temp32;
            temp32 = (gRailData.VRail32[3] > temp32) ? gRailData.VRail32[3] : temp32;

            //Turn on 16 volt rail if it is within Range
            if (temp16 >= gRailConfig.MinVoltage16 && temp16  <= gRailConfig.MaxVoltage16){
                RailControl(CONTROL_RAIL_16, TURN_ON);
                FanFullOn(&i2cfan);
                currentState |= 1;	//set rail16 flag = on
                //Turn on 32 volt rail if it is within Range
                if (temp32 >= gRailConfig.MinVoltage32 && temp32 <= gRailConfig.MaxVoltage32){
                    RailControl(CONTROL_RAIL_32, TURN_ON);
                    FanFullOn(&i2cfan);
                    currentState |= 8;	//set rail32 flag = on
                }else{
                    // 32volt rail has bad power
                    //  buzz(BADPOWER_SONG);
                }

            }else{
                buzz(BADPOWER_SONG);       //BUZZ For incorrect Power on 16V Rail
            }
        }//end rail off check    
    }//end Rail off routine

    //buzzer for Estop
    if (((currentState>>2)&1) == 1 && ((previousState>>2)&1) == 0)
        buzz(ESTOP_ON_SONG);
    else if (((currentState>>2)&1) == 0 && ((previousState>>2)&1) == 1)
        buzz(ESTOP_OFF_SONG);

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
    gRailData.state = ( ((KILLSW << 2)&4) | (~(ONOFFSW << 1)&2) )&15 ;
    
    INTCON1bits.NSTDIS = 1;     // disable Interupt nesting
    SRbits.IPL = 0;             //  CPU priority level is 8
    CORCONbits.IPL3 = 1;        // CPU interupt priority level is 8

    IPC4bits.CNIP = 7;          // Set Change Notice interrupt priority to 6
    IEC1bits.CNIE = 1;          // Enable CN interrupts
    IFS1bits.CNIF = 0;          // Reset CN interrupt

    return;
}
/*****************************************************************************/


