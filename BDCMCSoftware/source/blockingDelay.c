#include "blockingDelay.h"

void BlockingDelayms(INT16 ms)
{
    INT16 i = 0;
    T1CON = 0x0010; // Internal instruction clock, 1:8 prescale

    TMR1 = 0; T1CONbits.TON = 1;    // Clear the count and turn on the timer
    for(i = 0; i < ms; i++)
    {
        // Delays 10ms
        while(TMR1 < BDELAY_TICKS);
        TMR1 = 0;
    }

    T1CONbits.TON = 0;
}
