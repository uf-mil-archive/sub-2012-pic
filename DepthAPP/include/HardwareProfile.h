#ifndef HARDWARE_PROFILE_H
#define HARDWARE_PROFILE_H

#ifndef __dsPIC33FJ128MC802__
#error "Hardware Profile for selected processor does not exist"
#endif // Allowable processors

// The version number of this application number
#define APP_VERSION		0x01

/*
 *  Timers 1,2,3, and 5 are used by FreeRTOS and the tcp/ip stack. Timer 1 is
 *  also used in the blocking delay routines
 */

#define GetSystemClock()        (80000000ul) //Hz
#define GetInstructionClock()   (GetSystemClock() / 2)
#define GetPeripheralClock()    (GetSystemClock())

//********************* Analog Pins ********************************/
#define ANCONFIG    0xFFFC  // Default Analog pin configuration
// set all to digital except:
//  - AN0 - VPres
//  - AN1 - VTemp

//******************************************************************/

//****************************** LED *******************************/

#define LED_TRIS    TRISBbits.TRISB2   // LED TRIS
#define LED         LATBbits.LATB2     // LED IO
#define LED_ON      1                   // The LED is configured
#define LED_OFF     0                   // to turn on with a high output

//******************************************************************/

//********************* I/O pin definitions ************************/

// Simple names for pins. I also like using these little ActiveHigh/Low
// to control chip selects and LEDs.
#define INPUT_PIN   1
#define OUTPUT_PIN  0
#define AL_FALSE    1
#define AL_TRUE     0

//******************************************************************/

// Generic SPI Helper Defines
#define SPIREG2(a,b)    SPI##a##b
#define SPIREG(a,b)     SPIREG2(a,b)

// SPI PPS Outputs
#define SPI1SCK_IO	8
#define SPI1SDO_IO	7
#define SPI2SCK_IO	11
#define SPI2SDO_IO	10

//********************* EEPROM SPI *****************************/
// The EEPROM and the DAC used to set a reference current
// share the same SPI bus.

// The EEPROM digital pins
#define EROM_CS_TRIS    TRISBbits.TRISB13    // The EEPROM Chip Select TRIS
#define EROM_CS_IO	LATBbits.LATB13      // The EEPROM Chip Select IO

#define EROM_WP_TRIS	TRISBbits.TRISB15    // The EEPROM Write Protect TRIS
#define EROM_WP_IO	LATBbits.LATB15      // The EEPROM Write Protect IO

#define EROM_SPINUM	1   // You must define this number and the proper
                            // SDI PPS register below

// Define PPS SPI Pins
#define EROM_SDO_PIN    RPOR5bits.RP11R    // EEPROM SPI Data Out pin RP11
#define EROM_SCK_PIN    RPOR6bits.RP12R     // EEPROM SPI Clock pin RP12
#define EROM_SDI_PIN	14                   // EEPROM SPI Data In pin RP14
#define EROM_SDI_PINREG RPINR20bits.SDI1R   // The register where SDI
                                            // pin is assigned

// Map SPI Registers
#define EROM_SPIxSTAT           SPIREG(EROM_SPINUM,STAT)
#define EROM_SPIxCON1		SPIREG(EROM_SPINUM,CON1)
#define EROM_SPIxCON2		SPIREG(EROM_SPINUM,CON2)
#define EROM_SPIxSTATbits	SPIREG(EROM_SPINUM,STATbits)
#define EROM_SPIxCON1bits  	SPIREG(EROM_SPINUM,CON1bits)
#define EROM_SPIxCON2bits  	SPIREG(EROM_SPINUM,CON2bits)
#define EROM_SPIxBUF     	SPIREG(EROM_SPINUM,BUF)
#define EROM_SPIxSCK_IO  	SPIREG(EROM_SPINUM,SCK_IO)
#define EROM_SPIxSDO_IO  	SPIREG(EROM_SPINUM,SDO_IO)

//********************* ~EEPROM SPI ***********************************/

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

#define BAUDREG_9600    (GetInstructionClock()/(BRG_DIV*9600u) - 1u)// 9600
#define BAUDREG_38400   (GetInstructionClock()/(BRG_DIV*38400u) - 1u)// 38400
#define BAUDREG_56000   (GetInstructionClock()/(BRG_DIV*56000u) - 1u)// 56000
// 115200 Has the worst error at .61%
#define BAUDREG_115200  (GetInstructionClock()/(BRG_DIV*115200u) - 1u)// 115200
#define BAUDREG_250000  (GetInstructionClock()/(BRG_DIV*250000u) - 1u)// 250000
//******************************************************************/

//********************* COM UART ***********************************/
#define COM_UARTNUM 2	// You must define this number and the proper
// RX PPS register below
#define COM_DEFAULT_BAUD	BAUDREG_115200

// Receiver Interrupt Info - These need to be changed if you change UART# !!!
#define COM_UxRXIE				IEC1bits.U2RXIE
#define COM_UxRXIFLAG           IFS1bits.U2RXIF
#define COM_UxRXIPRIORITY		IPC7bits.U2RXIP

// Transmitter Interrupt Info - These need to be changed if you change UART# !!!
#define COM_UxTXIE				IEC1bits.U2TXIE
#define COM_UxTXIFLAG           IFS1bits.U2TXIF
#define COM_UxTXIPRIORITY		IPC7bits.U2TXIP

// Define PPS UART pins
#define COM_UTX_PIN         RPOR3bits.RP7R	    // COM UART TX pin RP7
#define COM_URX_PIN         6              	    // COM UART RX pin RP6
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
