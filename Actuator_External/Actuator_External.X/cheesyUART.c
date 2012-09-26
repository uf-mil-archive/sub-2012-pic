////////////////////////////////////////////////////////////////////////////////
// PIC UART 	                                                      PJL - 2012
////////////////////////////////////////////////////////////////////////////////
//  Recieve Packet:
//  command = bit7 and bit6
//      00 ReadSwitches
//              BIT0 = SW1
//              BIT1 = SW2
//      01 Ping
//      10 Set Actuators
//              Bit0 = ACT1
//              bit1 = ACT2
//              bit2 = ACT3
//              bit3 = ACT4
//              bit4 = ACT5
//              bit5 = ACT6
//      11 Reserved
//
//  Every Byte is followed by a checksum byte which is the byte xor 0xFF
//
//  For every recieved packet an acknowledgment is sent which is an echo of the
//  recieved byte.
//
//  0b10V5V4V3V2V1V0 - Set valve. Acknowledgement 0b10V5V4V3V2V1V0
//  0x00000000 - Read switches. Acknowledgement 0b000000S1S0
//  0x01000000 - Ping. Acknowledgement 0x01000000
//
//	0xFF sent when a checksum error occurs (bad checksum or a timeout)
//
//  Commands timeout after 10ms if no checksum is received.
////////////////////////////////////////////////////////////////////////////////

#include "cheesyUART.h"
#include "p33FJ128MC802.h"

void UARTInit(void)
{
    U2MODEbits.UARTEN = 0; 	// Make sure the UART is disabled
    U2BRG = BAUDREG_115200;	// set baud rate
    U2MODE = 0x8808;
    // Bit15 - 1 Enable UART (must be set before UxTXEN)
    // Bit14 - 0 Continue op in debug mode
    // Bit13 - 0 Continue op in idle mode
    // Bit12 - 0 IrDA disabled
    // Bit11 - 1 UxRTS in Simplex
    // Bit10 - 0 Use main Ux pins
    // Bits9-8 - 00 Use TX,RX pins others assigned to ports
    // Bit7 - 0 Wake up disabled
    // Bit6 - 0 No loopback
    // Bit5 - 0 Turn autobaud measurement off
    // Bit4 - 0 Normal RX polarity
    // Bit3 - 1 High Speed Baud Rates
    // Bit2-1 - 0 8 bit data, no parity
    // Bit0 - 0 1 stop bit

    U2STA = 0x8400;
    // Bit15,13 - 10 Interrupt flag set when FIFO is empty, and last byte is transmitting
    // Bit14 - 0 Normal TX Polarity
    // Bit12 - 0 Unimplemented
    // Bit11 - 0 Sync Break Transmission is off
    // Bit10 - 1 UxTX pin is controlled by UART
    // Bit9 - 0 read only
    // Bit8 - 0 read only
    // Bit7-6 - 00 Interrupt flag set when character received
    // Bit5 - 0 Address detect mode disabled
    // Bit4-2 - 000 read only
    // Bit1 - 0 Clear Overflow flag
    // Bit0 - 0 read only

    COM_UxRXIPRIORITY = 6;

    COM_UxRXIFLAG = 0;      // Clear the RX interrupt flag
    COM_UxRXIE = 1;         // Enable the RX interrupt

    return;
}

void UARTAcknowledge(char ch)
{
    UARTSendChar(ch);       //Send BYTE
    UARTSendChar(ch^0xFF);  //Send Checksum (BYTE XOR 0xFF)
    return;
}


void UARTSendChar(char ch)
{
    while(!U2STAbits.TRMT);    //wait for empty shift register
    U2TXREG = ch;
    return;
}

void UARTSendString(char* s)
{
    volatile int i = 0;

    while (s[i] != NULL)
    {
        UARTSendChar(s[i++]);
    }
    return;
}

void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt(void)
{
    volatile BYTE received;
    static BYTE command;
    static BYTE checksum;


    COM_UxRXIFLAG = 0;  // Clear the interrupt flag
    COM_UxSTAbits.OERR = 0; // Clear the overrun flag just in case.

    // Check for parity or framing error.
    if((COM_UxSTA & 0xC) > 0)
    {        
         // Clear the errors
        received = COM_UxRXREG;
        ;return;
    }

    //Get Byte from buffer
    //received = COM_UxRXREG;

    if (UART_state==0){
        command = COM_UxRXREG;
        UART_state = 1;
        T4CONbits.TON = 1;      // Start Timer (10ms delay to reset state)
    }else{
        T4CONbits.TON = 0;      // Stop Timer
        TMR4 = 0x00;            // Clear timer register
        UART_state = 0;
        checksum = COM_UxRXREG;
        if (checksum == (command ^ 0xFF) ){           

            switch( (command & 0xC0) >> 6) {
                    case 0 :    UARTAcknowledge(READ_SW + (SW2<<1) + SW1);
                                break;
                    case 1 :    UARTAcknowledge(PING);
                                break;
                    case 2 :    CTRL1 = ( command & CTRL1_MASK ) >> 0;
                                CTRL2 = ( command & CTRL2_MASK ) >> 1;
                                CTRL3 = ( command & CTRL3_MASK ) >> 2;
                                CTRL4 = ( command & CTRL4_MASK ) >> 3;
                                CTRL5 = ( command & CTRL5_MASK ) >> 4;
                                CTRL6 = ( command & CTRL6_MASK ) >> 5;
                                UARTAcknowledge(SET_ACT + (CTRL6<<5) + (CTRL5<<4) + (CTRL4<<3) + (CTRL3<<2) + (CTRL2<<1) + (CTRL1) );
                                break;
                    case 3  :   break;      //reserved command
                default :   break;
            }//end switch
        }else{
            command = ERROR;
            UARTAcknowledge(ERROR);
        }
        
    }//end state 1
            
 
    return;
}
