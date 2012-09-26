////////////////////////////////////////////////////////////////////////////////
// External Actuator Hardware Profile                                       2012
////////////////////////////////////////////////////////////////////////////////

#ifndef HARDWARE_PROFILE_H
#define HARDWARE_PROFILE_H

#ifndef __dsPIC33FJ128MC802__
#error "Hardware Profile for selected processor does not exist"
#endif // Allowable processors

#define GetSystemClock()        (80000000ul) //Hz
#define GetInstructionClock()   (GetSystemClock() / 2)
#define GetPeripheralClock()    (GetSystemClock())

//********************* Analog Pins ********************************/
#define ANCONFIG    0xFFFF  // Default Analog pin configuration
// set all to digital
//******************************************************************/

//****************************** Actuators ******************************/
#define CTRL1_TRIS  TRISAbits.TRISA0
#define CTRL1       LATAbits.LATA0
#define CTRL2_TRIS  TRISAbits.TRISA1
#define CTRL2       LATAbits.LATA1
#define CTRL3_TRIS  TRISBbits.TRISB0
#define CTRL3       LATBbits.LATB0
#define CTRL4_TRIS  TRISBbits.TRISB1
#define CTRL4       LATBbits.LATB1
#define CTRL5_TRIS  TRISAbits.TRISA3
#define CTRL5       LATAAbits.LATA3
#define CTRL6_TRIS  TRISBbits.TRISB4
#define CTRL6       LATBbits.LATB4

#define TURN_ON      1
#define TURN_OFF     0
//******************************************************************/

//***********************Limit Switches*****************************/
#define LIMITSW1_TRIS  TRISBbits.TRISB10
#define LIMITSW1       PORTBbits.RB10
#define LIMITSW2_TRIS  TRISBbits.TRISB11
#define LIMITSW2       PORTBbits.RB11
//******************************************************************/


//********************* I/O pin definitions ************************/
// Simple names for pins.
//
#define INPUT_PIN   1
#define OUTPUT_PIN  0
#define AL_FALSE    1
#define AL_TRUE     0
//******************************************************************/

// Generic UART Helper Defines
#define UARTREG2(a,b)     U##a##b
#define UARTREG(a,b)    UARTREG2(a,b)

//UART PPS Outputs
#define NULL_IO		0
#define U1TX_IO		3
#define U2TX_IO		5

//**************** Calculate Common Baud Rates *********************/
// These values are calculated using the formulas in the UART family
// data sheet. There is no error % checking because I only calculate
// the one's the UART table show's acceptable error.

#define BRG_DIV	4	// High speed baud rate generator divisor

#define BAUDREG_9600    (GetInstructionClock()/(BRG_DIV*9600) - 1)// 9600
#define BAUDREG_38400   (GetInstructionClock()/(BRG_DIV*38400) - 1)// 38400
#define BAUDREG_56000   (GetInstructionClock()/(BRG_DIV*56000) - 1)// 56000
// 115200 Has the worst error at .61%
#define BAUDREG_115200  (GetInstructionClock()/(BRG_DIV*115200) - 1)// 115200
#define BAUDREG_250000  (GetInstructionClock()/(BRG_DIV*250000) - 1)// 250000
//******************************************************************/

//********************* COM UART ***********************************/
#define COM_UARTNUM 2	// You must define this number and the proper
// RX PPS register below
#define COM_DEFAULT_BAUD	BAUDREG_115200

// Receiver Interrupt Info - These need to be changed if you change UART# !!!
#define COM_UxRXIE		IEC1bits.U2RXIE
#define COM_UxRXIFLAG           IFS1bits.U2RXIF
#define COM_UxRXIPRIORITY	IPC7bits.U2RXIP

// Transmitter Interrupt Info - These need to be changed if you change UART# !!!
#define COM_UxTXIE		IEC1bits.U2TXIE
#define COM_UxTXIFLAG           IFS1bits.U2TXIF
#define COM_UxTXIPRIORITY	IPC7bits.U2TXIP

// Define PPS UART pins
#define COM_UTX_PIN         RPOR4bits.RP8R 	    // COM UART TX pin RP8
#define COM_URX_PIN         9              	    // COM UART RX pin RP9
#define COM_URX_PINREG      RPINR19bits.U2RXR       // The register where the
                                                    // RX pin is assigned

// Map COM Registers
#define COM_UxMODE      UARTREG(COM_UARTNUM,MODE)
#define COM_UxBRG       UARTREG(COM_UARTNUM,BRG)
#define COM_UxSTA       UARTREG(COM_UARTNUM,STA)
#define COM_UxRXREG     UARTREG(COM_UARTNUM,RXREG)
#define COM_UxTXREG     UARTREG(COM_UARTNUM,TXREG)
#define COM_UxMODEbits  UARTREG(COM_UARTNUM,MODEbits)
#define COM_UxSTAbits   UARTREG(COM_UARTNUM,STAbits)
#define COM_UxTX_IO 	UARTREG(COM_UARTNUM,TX_IO)
//********************* ~COM UART ***********************************/


extern void ioMap();    // This function maps all of the PPS pins appropriately
                        // and it configures the open drain pins.

#endif
