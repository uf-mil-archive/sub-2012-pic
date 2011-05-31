#ifndef MESSAGES_H
#define MESSAGES_H

/*
 * The message flag frames the valid data at the beginning and end.
 * The escape character is used when the MSG_FLAG or the MSG_ESCAPE
 * character is included in the payload. A message might look like
 *  ____ ____ ____ ____ ____ ____ ____ ____ ____
 * |    |    |    |    |    |    |    |    |    |
 * |0x7E|0xXX|0xXX|0xXX|0x7D|0x5E|CHS1|CHS2|0x7E|
 * |____|____|____|____|____|____|____|____|____|
 *
 * The first byte is the beginning frame flag, followed by data. An example
 * of transmitting a data value equivalent to the flag value is shown. To
 * insert an escaped character in a message, two things have to happen. First,
 * the escape is inserted in front of the escaped character. Second, the escaped
 * character is then XOR'D with the XOR_VALUE(in this example 0x20) and appended
 * to the data stream. The last three bytes are the CRC-16 checksum byte 1,
 * byte 2, and then the closing frame flag, respectively.
 */

#include "p33Fxxxx.h"
#include "GenericTypeDefs.h"
#include "motor.h"

#define MSG_FLAG        0x7E
#define MSG_ESCAPE      0x7D
#define MSG_ESCAPE_XOR  0x20

#define MSG_MAX_LENGTH  30      // The longest message is 30 bytes not including
                                // flags or escape characters.
#define MSG_NUM_OUTGOING_BUFFERS   5    // Number of outgoing buffers

#define MSG_SENDER_UART     0   
#define MSG_SENDER_TCPIP    1  

#define MSG_FEED_HEARTBEAT  100   // Heartbeat packet

// Brushed Open-Loop Message Defines
#define MSG_BEGIN_PUBLISH       1   // Start publishing data
#define MSG_STOP_PUBLISH        2   // Stop publishing data
#define MSG_SET_REFERENCE       3   // Set a new duty cycle


UINT16 CRC16Checksum(BYTE* data, INT16 numberOfBytes, UINT16 prevCRC);
void CRC16Init(void);

void ParseNewPacket(CHAR8 rawPkt[], UINT16 length, UINT16 sender);

INT16 BuildOutgoingBROLPacket(const MotorData* mData, INT16 tickCount, BYTE** pkt);

#endif // MESSAGES_H
