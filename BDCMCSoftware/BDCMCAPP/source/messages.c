#include "messages.h"

CHAR8 outBuffers[MSG_NUM_OUTGOING_BUFFERS][MSG_MAX_LENGTH*2];
volatile UINT16 currentOutBuffer = 0;
volatile UINT16 packetCount = 0;

inline INT16 ValidateType(CHAR8 type);
void ParseBROLPacket(CHAR8 buffer[], UINT16 sender);

void CRC16Init(void)
{
    CRCXOR = 0x8005;    // CRC16-IBM x^16+x^15+x^2+1
    CRCCON = 0xF;   // Polynomial is 16 bits long
}

UINT16 CRC16ChecksumWord(UINT16* data, UINT16 numberOfWords, UINT16 prevCRC)
{
    CRCWDAT = prevCRC; // Initialize the CRC result with the previous value
    CRCCONbits.CRCGO = 1 ;
    do
    {
        while(1 != CRCCONbits.CRCMPT);

        while((!CRCCONbits.CRCFUL) && (numberOfWords > 0))
        {
            CRCDAT= *data;
            data++;
            numberOfWords--;
        }
    }while (0 < numberOfWords);

   while(CRCCONbits.CRCFUL==1); // Wait until the register isn't full
   CRCDAT = 0x0000;	/* Do this to shift the last word out of the 	*/
			/* CRC shift register		        	*/

   while(!CRCCONbits.CRCMPT);
   CRCCONbits.CRCGO = 0;

   return CRCWDAT;
}

inline INT16 ValidateType(CHAR8 type)
{
    if(!hMotorData)
        return -1;

    if(MSG_FEED_HEARTBEAT == type)
        return 0;

    if((hMotorData->Flags.MotorType) != type)
        return -1;

    return 0;
}

void ParseNewPacket(CHAR8 rawPkt[], UINT16 length, UINT16 sender)
{
    if((length % 2) != 0)
        return;     // Because of CRC constraints packets must be multiples of
                    // 2 bytes
    // First, validate the checksum
    if(CRC16ChecksumWord(((UINT16 *)&rawPkt), ((length - 2)/2), 0)
            != (*((UINT16 *)(&rawPkt[length - 1]))))
        return;

    /* It's a valid packet. Read the Motor type code and make sure its
       the current motor type */

    if(ValidateType(rawPkt[0]))
        return;
    
    switch(rawPkt[0])
    {
        case MTR_TYPE_BROL: // Brushed open loop packet
            ParseBROLPacket(rawPkt, sender);
            break;
        case MTR_TYPE_BRCL: // Brushed closed loop packet

            break;
        case MTR_TYPE_BLOL: // Brushless open loop packet

            break;
        case MTR_TYPE_BLCL: // Brushless closed loop packet

            break;
        case MSG_FEED_HEARTBEAT:
            FeedHeartbeat();
        default:
            // unknown motor type, do nothing
            break;
    }
}

void ParseBROLPacket(CHAR8 buffer[], UINT16 sender)
{
    // What's the command code? At this point the buffer
    // still has the motor code; that was not removed. So, the command code
    // lives at the second byte.
    if(buffer[1] == MSG_BEGIN_PUBLISH)
    {
        // This command is to begin publishing packets

    }
    else if(buffer[1] == MSG_STOP_PUBLISH)
    {
        // This command is to stop publishing packets

    }
    else if(buffer[1] == MSG_SET_REFERENCE)
    {
        // Set a new duty cycle
        
    }

    return;
}

INT16 AddByteToPacket(BYTE* buf, BYTE data, INT16 currentCount)
{
    if(data == MSG_FLAG || data == MSG_ESCAPE)
    {
        *buf++ = MSG_ESCAPE;
        currentCount++;
        data ^= MSG_ESCAPE_XOR;
    }

    *buf++ = data;
    currentCount++;

    return currentCount;
}

INT16 BuildOutgoingBROLPacket(const MotorData* mData, INT16 tickCount, CHAR8** pkt)
{
    INT16 tmplength = 0;
    INT16 temp = 0;

    // Handle buffer switching first
    currentOutBuffer = ((currentOutBuffer + 1) % MSG_NUM_OUTGOING_BUFFERS);

    // Increment the current packet number
    packetCount++;

    // Start with the source address - its never the escape character so add it directly
    outBuffers[currentOutBuffer][tmplength++] = mData->Address;
    // Next add the destination address - its never the escape character so add it directly
    outBuffers[currentOutBuffer][tmplength++] = mData->Address;
    
    tmplength++;    // Skip over the packet length variable

/*
    if(!(mData->Flags.Endianess)) // Big Endian
    {
        // Insert the packet number
        tmplength = AddByteToPacket(&&(outBuffers[currentOutBuffer][tmplength]),
                (BYTE)((packetCount >> 8) & 0xFF), tmplength);
        buf[tmplength++] = (CHAR8)(packetCount & 0xFF);

        // Insert the tick count
        buf[tmplength++] = (CHAR8)((tickCount >> 8) & 0xFF);
        buf[tmplength++] = (CHAR8)(tickCount & 0xFF);

        // Insert flags - clear out anything private
        temp = (mData->Flags.All);
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);
        buf[tmplength++] = (CHAR8)(temp & 0xFF);

        temp = mData->ReferenceInput;    // Insert reference input
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);
        buf[tmplength++] = (CHAR8)(temp & 0xFF);

        temp = mData->VRail;    // Insert voltage rail
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);
        buf[tmplength++] = (CHAR8)(temp & 0xFF);

        temp = mData->Current;    // Insert motor current
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);
        buf[tmplength] = (CHAR8)(temp & 0xFF);
    }
    else    // Little Endian
    {
        // Insert the packet number
        buf[tmplength++] = (CHAR8)(packetCount & 0xFF);
        buf[tmplength++] = (CHAR8)((packetCount >> 8) & 0xFF);

        // Insert the tick count
        buf[tmplength++] = (CHAR8)(tickCount & 0xFF);
        buf[tmplength++] = (CHAR8)((tickCount >> 8) & 0xFF);

        // Insert flags - clear out anything private
        temp = (mData->Flags.All);
        buf[tmplength++] = (CHAR8)(temp & 0xFF);
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);

        temp = mData->ReferenceInput;    // Insert reference input
        buf[tmplength++] = (CHAR8)(temp & 0xFF);
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);

        temp = mData->VRail;    // Insert voltage rail
        buf[tmplength++] = (CHAR8)(temp & 0xFF);
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);

        temp = mData->Current;    // Insert motor current
        buf[tmplength++] = (CHAR8)(temp & 0xFF);
        buf[tmplength] = (CHAR8)((temp >> 8) & 0xFF);
    }

    // Insert tmplength into packet
    buf[1] = (CHAR8)(tmplength & 0xFF);

    // Calculate the checksum
    temp = CRC16ChecksumWord(((UINT16 *)&buf[0]), tmplength, 0);

    tmplength++; // Increment to where the checksum goes in.

    if(!(mData->Flags.Endianess)) // Big Endian
    {
        buf[tmplength++] = (CHAR8)((temp >> 8) & 0xFF);
        buf[tmplength] = (CHAR8)(temp & 0xFF);
    }
    else
    {
        buf[tmplength++] = (CHAR8)(temp & 0xFF);
        buf[tmplength] = (CHAR8)((temp >> 8) & 0xFF);
    }

    temp = BuildEscapedPacket(&buf[0],&(outBuffers[currentOutBuffer][0]), tmplength);

    *pkt = &(outBuffers[currentOutBuffer][0]);
*/

    return temp;
}



