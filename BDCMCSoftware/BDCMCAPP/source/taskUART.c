#include "taskUART.h"
#include "messages.h"
#include "taskParser.h"

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

xQueueHandle hUARTTxQueue;
xTaskHandle hUARTTask;

volatile IncomingBuffers gUARTIncBuffers;

void COMInit(void);
void COMReadBaudFromEE(void);
void COMSetBaud(UINT16 baud);

void xUARTTaskInit(void)
{
    // Allocate the send and receive queues for the task
    hUARTTxQueue = xQueueCreate(UART_QUEUE_SIZE, sizeof(RTOSMsg));

    // Initialize the UART
    COMInit();
	
    xTaskCreate(taskUART, (CHAR*)"UART", STACK_SIZE_UART,
                NULL, tskIDLE_PRIORITY + 1, &hUARTTask);

    return;
}

void taskUART(void* pvParameter)
{
    RTOSMsg msg;
    const BYTE* pByte;

    for(;;)
    {
        // Block here until a new message is ready to be sent
        xQueueReceive(hUARTTxQueue, &msg, portMAX_DELAY);

        pByte = msg.Buffer;
        while(msg.Length > 0)
        {
            // Write the bytes to the FIFO. This will at most write 5 bytes in a shot.
            if(COM_UxSTAbits.UTXBF != 1)
            {
                msg.Length--;
                COM_UxTXREG = *pByte++;
            }
            else
                taskYIELD();
        }

        if(msg.Free)
            free(msg.Buffer);
    }
}

void COMInit(void)
{
    COM_UxMODEbits.UARTEN = 0; 	// Make sure the UART is disabled
    COMReadBaudFromEE();		// Set BAUD to the saved value
    COM_UxMODE = 0x8808;
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

    COM_UxSTA = 0x8400;
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

    // Set the priority level of the receive interrupt equal to or less than
    // the kernel interrupt!!!
    COM_UxRXIPRIORITY = configKERNEL_INTERRUPT_PRIORITY;

    COM_UxRXIFLAG = 0;	// Clear the RX interrupt flag
    COM_UxRXIE = 1;		// Enable the RX interrupt

    return;
}

void COMSetBaud(UINT16 baud)
{
    UINT16 temp = COM_UxMODE & 0x8000; // Save the UARTEN flag state
    COM_UxMODEbits.UARTEN = 0; 	        // Disable while changing baud rate
    COM_UxBRG = baud;			        // Write the new divisor
    COM_UxMODE |= temp;			        // Reset the UARTEN flag back to its
    // original value

    return;
}

void COMReadBaudFromEE(void)
{
    UINT16 baud = 0xFFFF;           //DataEERead(COM_BAUD_EEADD);
    if(baud == 0xFFFF)
        baud = COM_DEFAULT_BAUD;	// No baud divisor saved,
    // just write the default one.
    COMSetBaud(baud);

    return;
}

// The COMPut functions expect the data buffer to exist
// AFTER they return. IE, malloc them when you make a msg
// and the taskUART function will free the used memory.
void COMSend(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree)
{
    RTOSMsg msg;

    msg.Length = length;
    msg.Buffer = data;
    msg.Free = (shouldFree > 0) ? 1 : 0;

    // This memcpy's the message struct to the queue.
    xQueueSendToBack(hUARTTxQueue, &msg, 0);
}

void COMSendFromISR(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree)
{
    RTOSMsg msg;

    msg.Length = length;
    msg.Buffer = data;
    msg.Free = (shouldFree > 0) ? 1 : 0;

    // This memcpy's the message struct to the queue.
    xQueueSendToBackFromISR(hUARTTxQueue, &msg, 0);
}

void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt(void)
{
    static INT16 pktIndex = 0;
    static INT16 mode = PKT_SEARCH_HDR;

    RTOSMsg msg;
    portBASE_TYPE xTaskWoken = pdFALSE;
    volatile BYTE received;
    INT16 curBuf = gUARTIncBuffers.CurrentBuffer;

    COM_UxSTAbits.OERR = 0; // Clear the overrun flag just in case.

    // Check for parity or framing error.
    if((COM_UxSTA & 0xC) > 0)
    {
        // Clear the errors
        received = COM_UxRXREG;

        goto DONE;
    }

    // Read the new bytes from the rx fifo and unescape them
    while(COM_UxSTAbits.URXDA)
    {
        received = COM_UxRXREG;

        // Check for overrun
        if(pktIndex >= MSG_MAX_LENGTH)
        {
            mode = PKT_SEARCH_HDR;
            pktIndex = 0;
        }

        switch(mode)
        {
            case PKT_ESCAPED:
                /* If the character has been escaped, copy the next byte
                 * to the data buffer, no matter what. Don't forget to XOR
                 * to retrieve the real value again.
                 */
                gUARTIncBuffers.Buffers[curBuf][pktIndex++] = (received ^ MSG_ESCAPE_XOR);
                mode = PKT_INMSG;
                break;
            case PKT_INMSG:
                /* Here, everything is kept with 2 exceptions. If we hit the escape
                 * character, then delete the escape character from the queue and
                 * switch to escape mode.
                 */
                if(received == MSG_ESCAPE)
                {
                    // The character is already dequeued, just change mode
                    mode = PKT_ESCAPED;
                }
                else if(received == MSG_FLAG)
                {
                    // Frame could be misaligned. Push back into INMSG
                    if(pktIndex == 0)
                        mode = PKT_INMSG;
                    else	// End of packet. Change mode back to search for new one.
                    {
                    	mode = PKT_SEARCH_HDR;

                        // Copy the packet to the parser queue
                        msg.Sender = MSG_SENDER_UART;
                        msg.Length = pktIndex;
                        msg.Buffer = &gUARTIncBuffers.Buffers[gUARTIncBuffers.CurrentBuffer][0];
                        msg.Free = 0;
                        gUARTIncBuffers.CurrentBuffer =
                                (gUARTIncBuffers.CurrentBuffer + 1) % MSG_NUM_INCOMING_BUFFERS;

                        // This memcpy's the message struct to the queue.
                        xQueueSendToBackFromISR(hParserQueue, &msg, 0);
                    }
                    pktIndex = 0;
                }
                else
                    gUARTIncBuffers.Buffers[curBuf][pktIndex++] = received; // Copy data to buffer
                break;
            default:
                // Default to looking for packet flag
                if(received == MSG_FLAG)
                {
                    // We found a new flag. Switch to keeping data.
                    mode = PKT_INMSG;
                    pktIndex = 0;
                }
                break;
        }
    }



 DONE:
      COM_UxRXIFLAG = 0;  // Clear the interrupt flag
    // Force a context switch if a higher priority task is woken
    // THIS MUST BE THE LAST CALL IN THE ISR!!!!
      if(xTaskWoken)
        taskYIELD();
}

