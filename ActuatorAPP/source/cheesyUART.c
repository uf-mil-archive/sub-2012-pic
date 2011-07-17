#include "cheesyUART.h"
#include "p33FJ128MC802.h"

void UARTInit(void)
{
    U2MODEbits.UARTEN = 0; 	// Make sure the UART is disabled
    U2BRG = BAUDREG_115200;			// set baud rate
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
    COM_UxRXIFLAG = 0;  // Clear the interrupt flag
    COM_UxSTAbits.OERR = 0; // Clear the overrun flag just in case.

    // Check for parity or framing error.
    if((COM_UxSTA & 0xC) > 0) return;

    //Get Byte from buffer
    actuators = COM_UxRXREG;

    return;
}
