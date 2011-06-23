#include "buzzer.h"
#include "p33Fxxxx.h"


void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void)
{
	IFS1bits.T4IF = 0; // Clear Timer1 Interrupt Flag
	
	PR4 -= 200;
	if (PR4 == 0) PR4 = 39062;	

	BUZZER^=1;
}


void buzzerInit()
{
	T4CONbits.TON = 0; // Disable Timer
	T4CONbits.TCS = 0; // Select internal instruction cycle clock 
	T4CONbits.TGATE = 0; // Disable Gated Timer mode
	T4CONbits.TCKPS = 0b11; // Select 1:64 Prescaler
	TMR4 = 0x00; // Clear timer register
	PR4 = 39062; // Load the period value
	IPC6bits.T4IP = 0x01; // Set Timer4 Interrupt Priority Level
	IFS1bits.T4IF = 0; // Clear Timer4 Interrupt Flag
	IEC1bits.T4IE = 1; // Enable Timer1 interrupt
	T4CONbits.TON = 1; // Start Timer
}

