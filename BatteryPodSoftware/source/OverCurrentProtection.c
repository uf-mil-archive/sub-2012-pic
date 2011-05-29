////////////////////////////////////////////////////////////////////////////////
// Overcurrent Protection (source)                   Authored by:   Paul Launier
//
// Created: 05/01/2011                       Last Modified: 05/01/2011  10:53 PM
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following is code to initialize the interputs (INT0, INT1) for the
//  overcurrent protection.
//
//  TODO: Define behaviors in ISR
//
////////////////////////////////////////////////////////////////////////////////
#include "OverCurrentProtection.h"
#include "p33FJ128MC804.h"

void overCurrent_Init(void)
{
    

    INTCON1bits.NSTDIS = 1;     // disable Interupt nesting

    INTCON2 = 0x0003;       //Setup INT0 and INT1 pins to interupt
                            //on falling edge

    IFS0bits.INT0IF = 0;    //Reset INT0 interrupt flag
    IEC0bits.INT0IE = 1;    //Enable INT0 Interrupt Service Routine
    IPC0bits.INT0IP = 7;    //set priority to 7

    IFS1bits.INT1IF = 0;    //Reset INT1 interrupt flag
    IEC1bits.INT1IE = 1;    //Enable INT1 Interrupt Service Routine
    IPC5bits.INT1IP = 7;    //set priority to 7

}


void __attribute__((__interrupt__, auto_psv)) _INT0Interrupt(void)
{
    IFS0bits.INT0IF = 0;    //Clear the INT0 interrupt flag

    // Turn off 16V Rail

}

void __attribute__((__interrupt__, auto_psv)) _INT1Interrupt(void)
{
    IFS1bits.INT1IF = 0;    //Clear the INT1 interrupt flag

    //Turn off 32V Rail

}
