////////////////////////////////////////////////////////////////////////////////
// Battery POD Hardware Profile                      Authored by:   Paul Launier
//
// Created: 05/29/2011                       Last Modified: 05/29/2011   8:01 AM
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following code was explicetly written for the Battery POD Control Board
//  and subjugator 7.
//
//  dsPIC used is the: dsPIC33FJ128MC804
//
//  TODO:
//
////////////////////////////////////////////////////////////////////////////////
#ifndef HARDWARE_PROFILE_H
#define HARDWARE_PROFILE_H

#ifndef __dsPIC33FJ128MC804__
#error "Hardware Profile for selected processor does not exist"
#endif // Allowable processors

#define GetSystemClock()        (80000000ul) //Hz
#define GetInstructionClock()   (GetSystemClock() / 2)
#define GetPeripheralClock()    (GetSystemClock())

//********************* Analog Pins ********************************/
#define ANCONFIG    0xFFFF  // Default Analog pin configuration
// set all to digital

//******************************************************************/


//******************* Open Drain Pins ******************************/
#define ODCACONFIG    0x0000  // Default Open Drain pin configuration
#define ODCBCONFIG    0x0300  // Default Open Drain pin configuration
#define ODCCCONFIG    0x0000  // Default Open Drain pin configuration

//  All Port A pins are configured normal

//  All port B pins are configured normal except:
//  RB8 : I2C_CLK
//  RB9 : I2C_DAT

//  All port C pins are configured normal

//******************************************************************/

//************************* HighSide Drivers ***********************/

#define RAIL16_TRIS    TRISBbits.TRISB7   // 16V Rail Control TRIS
#define RAIL16         LATBbits.LATB7     // 16V Rail IO

#define RAIL32_TRIS    TRISAbits.TRISA9   // 32V Rail TRIS
#define RAIL32         LATAbits.LATA9    // 32V Rail IO

#define TURN_ON      1                   // Turn on the highside drivers with
#define TURN_OFF     0                   // a high output

//************************ ~HighSide Drivers ***********************/


//****************************** LED *******************************/

#define LED_TRIS    TRISBbits.TRISB2   // LED TRIS
#define LED         LATBbits.LATB2     // LED IO
#define LED_ON      1                   // The LED is configured
#define LED_OFF     0                   // to turn on with a high output

//******************************************************************/


//**************************HALL SWITCHES***************************/
//
//  Note:   Hall effect switches are pulled up on the Merge Board.
//          For this reason the SW will register as a '1' when the
//          hall effect is not plugged in. To prevent a startup without
//          a kill SW connected, a '1' on the SW pin should be considered
//          the 'KILL' state. Likewise, a '1' on the ON/OFF SW pin should be
//          considered the 'OFF' state.

#define KILLSW_TRIS     TRISBbits.TRISB15     // Kill Switch TRIS
#define KILLSW          PORTBbits.RB15        // Kill Switch IO
#define KILLSW_CN       CNEN1bits.CN11IE      // KillSW Change notification
#define CN_ENABLE   1                         // value to enable CN interupt


#define ONOFFSW_TRIS    TRISBbits.TRISB14   // On/Off Switch TRIS
#define ONOFFSW         PORTBbits.RB14      // ON/Off Switch IO
#define ONOFFSW_CN      CNEN1bits.CN12IE    // On/Off Change noticacation

//******************************************************************/


//*************************** BUZZER *******************************/

#define BUZZER_TRIS    TRISBbits.TRISB13   // Buzzer TRIS
#define BUZZER         LATBbits.LATB13     // Buzzer IO
#define BUZZER_ON      1                   // The Buzzer is configured
#define BUZZER_OFF     0                   // to turn on with a high output

//******************************************************************/

//*************************** Overcurrent **************************/
//  Fault16 is on INT0
//  Fault32 is on INT1

#define FAULT16_TRIS    TRISBbits.TRISB7    // Fault16 TRIS
#define FAULT16         PORTBbits.RB7       // Fault16 IO

#define FAULT32_TRIS    TRISBbits.TRISB11   // Fault16 TRIS
#define FAULT32         PORTBbits.RB11      // Fault16 IO

// Define PPS INT1 Pin for Fault32
#define FAULT32_PIN	11			//
#define FAULT32_PINREG	RPINR0bits.INT1R	// The register where INT1
						// pin is assigned

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

// SPI PPS Outputs (Do not change)
#define SPI1SCK_IO	8
#define SPI1SDO_IO	7
#define SPI2SCK_IO	11
#define SPI2SDO_IO	10

//********************* EEPROM SPI *****************************/
// The EEPROM and the DAC used to set a reference current
// share the same SPI bus along with the ADC.

// The EEPROM digital pins
#define EROM_CS_TRIS    TRISBbits.TRISB10    // The EEPROM Chip Select TRIS
#define EROM_CS_IO	LATBbits.LATB10      // The EEPROM Chip Select IO

#define EROM_SPINUM	1   // You must define this number and the proper
                            // SDI PPS register below

// Define PPS SPI Pins
#define EROM_SDO_PIN    RPOR10bits.RP21R    // EEPROM SPI MOSI Data pin RP21
#define EROM_SCK_PIN    RPOR10bits.RP20R     // EEPROM SPI Clock pin RP20
#define EROM_SDI_PIN	19                  // EEPROM SPI MISO Data pin RP19
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

//********************* DAC SPI *****************************/
// The EEPROM and the DAC used to set a reference current
// share the same SPI bus.

// The DAC digital pins
#define DAC16_CS_TRIS   TRISBbits.TRISB6    // The DAC16 Chip Select TRIS
#define DAC16_CS_IO     LATBbits.LATB6      //The DAC16 Chip Select IO

#define DAC32_CS_TRIS   TRISAbits.TRISA4    // The DAC32 Chip Select TRIS
#define DAC32_CS_IO     LATAbits.LATA4      //The DAC32 Chip Select IO

#define DAC_SPINUM	1   // You must define this number and the proper
                            // SDI PPS register below

// Define PPS SPI Pins
#define DAC_SDO_PIN     RPOR10bits.RP21R    // DAC SPI MOSI Data pin RP21
#define DAC_SCK_PIN     RPOR10bits.RP20R    // DAC SPI Clock pin RP20
#define DAC_SDI_PIN     19                  // DAC SPI MISO Data pin RP19
#define DAC_SDI_PINREG  RPINR20bits.SDI1R   // The register where SDI
                                            // pin is assigned

// Map SPI Registers
#define DAC_SPIxSTAT            SPIREG(DAC_SPINUM,STAT)
#define DAC_SPIxCON1		SPIREG(DAC_SPINUM,CON1)
#define DAC_SPIxCON2		SPIREG(DAC_SPINUM,CON2)
#define DAC_SPIxSTATbits	SPIREG(DAC_SPINUM,STATbits)
#define DAC_SPIxCON1bits  	SPIREG(DAC_SPINUM,CON1bits)
#define DAC_SPIxCON2bits  	SPIREG(DAC_SPINUM,CON2bits)
#define DAC_SPIxBUF     	SPIREG(DAC_SPINUM,BUF)
#define DAC_SPIxSCK_IO  	SPIREG(DAC_SPINUM,SCK_IO)
#define DAC_SPIxSDO_IO  	SPIREG(DAC_SPINUM,SDO_IO)

//********************* ~DAC SPI ***********************************/

//********************* ADC SPI *****************************/

// The ADC digital pins
#define ADC16_CS_TRIS   TRISCbits.TRISC9    // The ADC16 Chip Select TRIS
#define ADC16_CS_IO     LATCbits.LATC9      //The ADC16 Chip Select IO

#define ADC32_CS_TRIS   TRISBbits.TRISB5  // The ADC32 Chip Select TRIS
#define ADC32_CS_IO     LATBbits.LATB5      //The ADC32 Chip Select IO

#define ADC_SPINUM	1   // You must define this number and the proper
                            // SDI PPS register below

// Define PPS SPI Pins
#define ADC_SDO_PIN     RPOR10bits.RP21R    // ADC SPI SDO (MOSI) Data pin RP21
#define ADC_SCK_PIN     RPOR10bits.RP20R    // ADC SPI Clock pin RP20
#define ADC_SDI_PIN     19                  // ADC SPI SDI (MISO) Data pin RP19
#define ADC_SDI_PINREG  RPINR20bits.SDI1R   // The register where SDI
                                            // pin is assigned

// Map SPI Registers
#define ADC_SPIxSTAT            SPIREG(ADC_SPINUM,STAT)
#define ADC_SPIxCON1		SPIREG(ADC_SPINUM,CON1)
#define ADC_SPIxCON2		SPIREG(ADC_SPINUM,CON2)
#define ADC_SPIxSTATbits	SPIREG(ADC_SPINUM,STATbits)
#define ADC_SPIxCON1bits  	SPIREG(ADC_SPINUM,CON1bits)
#define ADC_SPIxCON2bits  	SPIREG(ADC_SPINUM,CON2bits)
#define ADC_SPIxBUF     	SPIREG(ADC_SPINUM,BUF)
#define ADC_SPIxSCK_IO  	SPIREG(ADC_SPINUM,SCK_IO)
#define ADC_SPIxSDO_IO  	SPIREG(ADC_SPINUM,SDO_IO)

//********************* ~ADC SPI ***********************************/


//********************* ENC28J60 SPI ***********************************/

// Digital Pins
#define ENC_CS_IO		LATBbits.LATB9
#define ENC_CS_TRIS		TRISBbits.TRISB9
#define ENC_RST_IO		LATBbits.LATB8
#define ENC_RST_TRIS            TRISBbits.TRISB8
#define ENC_SPI_IF		IFS2bits.SPI2IF 

#define ENC_SPINUM	2	// You must define this number and the proper
				// SDI PPS register below

// Define PPS SPI Pins
#define ENC_SDO_PIN	RPOR11bits.RP23R	// ENC SPI Data Out pin RP23
#define ENC_SCK_PIN	RPOR11bits.RP22R	// ENC SPI Clock pin RP22
#define ENC_SDI_PIN	24			// ENC SPI Data In pin RP24
#define ENC_SDI_PINREG	RPINR22bits.SDI2R	// The register where SDI
						// pin is assigned

// Map SPI Registers
#define ENC_SPISTAT         SPIREG(ENC_SPINUM,STAT)
#define ENC_SPICON1         SPIREG(ENC_SPINUM,CON1)
#define ENC_SPICON2         SPIREG(ENC_SPINUM,CON2)
#define ENC_SPISTATbits     SPIREG(ENC_SPINUM,STATbits)
#define ENC_SPICON1bits     SPIREG(ENC_SPINUM,CON1bits)
#define ENC_SPICON2bits     SPIREG(ENC_SPINUM,CON2bits)
#define ENC_SSPBUF          SPIREG(ENC_SPINUM,BUF)
#define ENC_SPIBRG          SPIREG(ENC_SPINUM,BRG)
#define ENC_SPIxSCK_IO      SPIREG(ENC_SPINUM,SCK_IO)
#define ENC_SPIxSDO_IO      SPIREG(ENC_SPINUM,SDO_IO)

//********************* ~ENC28J60 SPI ********************************/

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
#define COM_UTX_PIN         RPOR11bits.RP23R 	    // COM UART TX pin RP22
#define COM_URX_PIN         22              	    // COM UART RX pin RP23
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
