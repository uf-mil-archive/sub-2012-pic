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
#include "taskPublisher.h"

#define MSG_FLAG        0x7E
#define MSG_ESCAPE      0x7D
#define MSG_ESCAPE_XOR  0x20

#define MSG_MAX_LENGTH  30              // The longest message is 30 bytes not including
                                        // flags or escape characters.
#define MSG_NUM_OUTGOING_BUFFERS   5    // Number of outgoing buffers
#define MSG_NUM_INCOMING_BUFFERS   5    // Number of incoming buffers per device

#define MSG_SENDER_UART     1
#define MSG_SENDER_ETH      2

#define MSG_FEED_HEARTBEAT  100         // Heartbeat Packet
#define MSG_FEED_HEARTBEAT_LENGTH   7   // Length of the packet including 2 byte checksum

#define MSG_ESTOP           101     // ESTOP Packet
#define MSG_ESTOP_LENGTH    7       // Length of the packet including 2 byte checksum

// Brushed Open-Loop Message Defines
#define MSG_START_PUBLISH           1   // Start publishing data
#define MSG_START_PUBLISH_LENGTH    9   // Length of the packet including 2 byte checksum
#define MSG_STOP_PUBLISH            2   // Stop publishing data
#define MSG_STOP_PUBLISH_LENGTH     8   // Length of the packet including 2 byte checksum
#define MSG_SET_REFERENCE           3   // Set a new duty cycle
#define MSG_SET_REFERENCE_LENGTH    10  // Length of the packet including 2 byte checksum

#define MSG_CRC_POLY    0x1021      // The CRC-16 Polynomial CRC16-XMODEM

typedef struct tagCommonMessagingData
{
    BYTE Address;
    BYTE MultiCastAddress;
    BYTE ControllerAdd;   // Who's allowed to give input to me? And who do I send to?
    INT16 Endianess;    // 0 = Little Endian
}CommonMessagingData;

typedef struct tagOutgoingMessagingData
{
    CommonMessagingData *Common;
    INT16 PublishRate;
    INT16 OutgoingPacketCount;
    BYTE Buffers[MSG_NUM_OUTGOING_BUFFERS][(MSG_MAX_LENGTH*2 + 2)]; // The extra room is for escape characters
    INT16 CurrentBuffer;
    INT16 Subscribers;
    BYTE  scratchBuf[MSG_MAX_LENGTH];
} OutgoingMessagingData;

typedef volatile struct tagIncomingBuffers
{
    INT16 CurrentBuffer;
    BYTE Buffers[MSG_NUM_INCOMING_BUFFERS][(MSG_MAX_LENGTH + 2)];   // No escape characters are saved incoming
}IncomingBuffers;

extern CommonMessagingData  gCommonMsgData;

UINT16 CRC16Checksum(BYTE* data, INT16 numberOfBytes);
void CRC16Init(void);

void ParseNewPacket(BYTE buf[], INT16 length, INT16 transport);

INT16 BuildOutgoingPacket(OutgoingMessagingData *data, INT16 tickCount);

#endif // MESSAGES_H
