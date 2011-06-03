#include "messages.h"

MessagingData gMessagingData;

// Adds little endian int to a packet
inline void AddLEIntToPacket(BYTE* buf, INT16 data, INT16* currentCount)
{
    *buf++ = (BYTE)(data & 0xFF);
    *buf++ = (BYTE)((data >> 8) & 0xFF);
    (*currentCount) += 2 ;
}

// Adds big endian int to a packet
inline void AddBEIntToPacket(BYTE* buf, INT16 data, INT16* currentCount)
{
    *buf++ = (BYTE)((data >> 8) & 0xFF);
    *buf++ = (BYTE)(data & 0xFF);
    (*currentCount) += 2 ;
}

inline INT16 ReadLEIntFromPacket(BYTE* buf)
{
    // The pic is little endian
    return (((INT16)(*(buf+1)) << 8) | (*(buf)));
}

inline INT16 ReadBEIntFromPacket(BYTE* buf)
{
    return (((INT16)(*(buf)) << 8) | (*(buf+1)));
}

void CRC16Init(void)
{
    CRCXOR = MSG_CRC_POLY;    
    CRCCON = 0xf;   // Polynomial is 16 bits long
}

UINT16 CRC16Checksum(BYTE* data, INT16 numberOfBytes)
{
    INT16 i=0, Carry;

    BYTE Flag;
    BYTE *ptr=(BYTE *)&CRCDAT;

    CRCWDAT = 0x0000;  // start new calculation
    Flag=0x00;

    while(numberOfBytes!=0)
    {
        while(CRCCONbits.CRCFUL==1)//check if FIFO is full
        CRCCONbits.CRCGO=1; //start CRC engine
        *ptr=*data++;
        numberOfBytes--;
        Flag=Flag^0x01;
    }
    if(CRCCONbits.CRCGO!=1)
        CRCCONbits.CRCGO=1; //start CRC engine

    while(CRCCONbits.CRCFUL==1);//check if FIFO is full
    if(Flag==0)
        CRCDAT = 0x0000; //appending PLEN+1 zeros (multiply by 2^16)
    else
        *ptr=0x00;  //append (PLEN+1)/2 zeros

    while(CRCCONbits.CRCMPT!=1);//check if FIFO is empty
    CRCCONbits.CRCGO=0; //stop CRC engine

    Nop();
    Nop();
    
    if(Flag==1)
    {
        for(i = 0; i < 8; i ++) //compute CRC in software by
        {
            //appending (PLEN+1)/2 zeros
            Carry =( CRCWDAT & 0x8000);
            CRCWDAT <<= 1;
            if(Carry)
                CRCWDAT ^= MSG_CRC_POLY;
        }
    }
    Nop();

    return CRCWDAT;
}

void ParseNewPacket(BYTE rawPkt[], INT16 length, INT16 transport)
{
    UINT16 checkSum = (gMessagingData.Endianess) ?
        ReadBEIntFromPacket(&rawPkt[length - 2]) :
        ReadLEIntFromPacket(&rawPkt[length - 2]);
        
    // First, validate the checksum
    if(CRC16Checksum(&rawPkt[0], length - 2) != checkSum)
        return;

    /* It's a valid packet. Check to make sure we are the intended recipient. */
    if(gMessagingData.Address == rawPkt[1])
        gMessagingData.IncomingPacketCount++;
    else if(gMessagingData.MultiCastAddress == rawPkt[1])
        gMessagingData.MulticastPacketCount++;
    else // Not for us
        return;

    // The next two bytes are packet count of the transmitter

    // From now on it's motor specific. Ensure we have a motor instance
    if(!hMotorData)
        return;
        
    // Do the motor types line up?
    if((hMotorData->Flags & MTR_FLAGMASK_MOTORCODE) != rawPkt[4])
        return;

    // Okay, they're talking to us and its a validated motor type. Is the message
    // a heartbeat or ESTOP?
    if(rawPkt[4] == MSG_FEED_HEARTBEAT)
    {
        // Is the sender the guy in charge of me?
        if(rawPkt[0] == gMessagingData.ControllerAdd)
            FeedHeartbeat();
        return;
    }
    else if(rawPkt[4] == MSG_ESTOP)
    {
        // Stop!
        return;
    }

    // Nope, they're either subscribing/unsubscribing or commanding a new
    // motor reference.
    switch(rawPkt[5])
    {
        case MSG_START_PUBLISH:
            gMessagingData.Subscribers |= transport;
            break;
        case MSG_STOP_PUBLISH:
            gMessagingData.Subscribers &= (~transport);
            break;
        case MSG_SET_REFERENCE:
            // Is the sender the guy in charge of me?
            if(rawPkt[0] == gMessagingData.ControllerAdd)
            {
                    hMotorData->ReferenceInput = (gMessagingData.Endianess) ?
                        ReadBEIntFromPacket(&rawPkt[6]):
                        ReadLEIntFromPacket(&rawPkt[6]);
            }
            break;
        default:
            break; // Unrecognized
    }
}

inline INT16 BuildEscapedPacket(BYTE* src, BYTE* dest, INT16 inCount)
{
    INT16 i = 0;
    INT16 escCount = inCount + 2;

    // Add in the beginning flag
    *dest++ = MSG_FLAG;

    for(i = 0; i < inCount; i++)
    {
        BYTE temp = *src++;
        if(temp == MSG_FLAG || temp == MSG_ESCAPE)
        {
            temp = (MSG_ESCAPE_XOR ^ temp);
            *dest++ = MSG_ESCAPE;
            escCount++;
        }
        *dest++ = temp;
    }

    // End message flag
    *dest++ = MSG_FLAG;

    return escCount;
}

INT16 BuildOutgoingPacket(INT16 tickCount)
{
    INT16 tmplength = 0;
    INT16 temp = 0;

    // Handle buffer switching first
    gMessagingData.CurrentOutBuffer = 
            ((gMessagingData.CurrentOutBuffer + 1) % MSG_NUM_OUTGOING_BUFFERS);
 
    // Increment the current packet number
    gMessagingData.OutgoingPacketCount++;

    // Start with the source address - its never the escape character so add it directly
    gMessagingData.scratchBuf[tmplength++] = gMessagingData.Address;    // I'm the source
    // Next add the destination address - its never the escape character so add it directly
    gMessagingData.scratchBuf[tmplength++] = gMessagingData.ControllerAdd;
    
    tmplength++;    // Skip over the packet length variable

    if(gMessagingData.Endianess) // Big Endian
    {
        // Insert the packet number
        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength],
                gMessagingData.OutgoingPacketCount,
                &tmplength);

        // Insert the tick count
        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength], tickCount, &tmplength);

        // Insert flags - clear out anything private
//        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->Flags.All, &tmplength);

        // Insert reference input
        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->ReferenceInput, &tmplength);

        // Insert voltage rail
        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->VRail, &tmplength);

        // Insert motor current
        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->Current, &tmplength);
    }
    else    // Little Endian
    {
        // Insert the packet number
        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength],
                gMessagingData.OutgoingPacketCount,
                &tmplength);

        // Insert the tick count
        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength], tickCount, &tmplength);

        // Insert flags - clear out anything private
//        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->Flags.All, &tmplength);

        // Insert reference input
        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->ReferenceInput, &tmplength);

        // Insert voltage rail
        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->VRail, &tmplength);

        // Insert motor current
        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength], hMotorData->Current, &tmplength);
    }

    // Insert tmplength into packet
    gMessagingData.scratchBuf[2] = (BYTE)(tmplength & 0xFF);

    // Calculate the checksum
    temp = CRC16Checksum(&gMessagingData.scratchBuf[0],
            tmplength);

    if(gMessagingData.Endianess) // Big Endian
        AddBEIntToPacket(&gMessagingData.scratchBuf[tmplength], temp, &tmplength);
    else
        AddLEIntToPacket(&gMessagingData.scratchBuf[tmplength], temp, &tmplength);

    tmplength = BuildEscapedPacket(&gMessagingData.scratchBuf[0],
            &(gMessagingData.OutBuffers[gMessagingData.CurrentOutBuffer][0]),
            tmplength);

    // This function returns the total count of bytes in the buffer
    return tmplength;
}



