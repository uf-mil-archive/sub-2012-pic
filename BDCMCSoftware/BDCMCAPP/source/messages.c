#include "messages.h"

CommonMessagingData gCommonMsgData =
{
    .Address = 2,
    .ControllerAdd = 1,
};

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

void ParseNewPacket(BYTE rBuf[], INT16 length, INT16 transport)
{
    UINT16 checkSum = (data->Common->Endianess) ?
        ReadBEIntFromPacket(&rBuf[length - 2]) :
        ReadLEIntFromPacket(&rBuf[length - 2]);
        
    // First, validate the checksum
    if(CRC16Checksum(&rBuf[0], length - 2) != checkSum)
        return;

    /* It's a valid packet. Check to make sure we are the intended recipient. */
    if(data->Common->Address == data->Buffers[rBuf][1])
        data->IncomingPacketCount++;
    else if(data->Common->MultiCastAddress == data->Buffers[rBuf][1])
        data->MulticastPacketCount++;
    else // Not for us
        return;

    // The next two bytes are packet count of the transmitter

    // From now on it's motor specific. Ensure we have a motor instance
    if(!hMotorData)
        return;

    // Okay, they're talking to us. Is the message a heartbeat or ESTOP?
    if(data->Buffers[rBuf][4] == MSG_FEED_HEARTBEAT)
    {
        if(length == MSG_FEED_HEARTBEAT_LENGTH)
        {
            // Is the sender the guy in charge of me?
            if(data->Buffers[rBuf][0] == data->Common->ControllerAdd)
                FeedHeartbeat();
        }
        return;
    }
    else if(data->Buffers[rBuf][4] == MSG_ESTOP)
    {
        if(length == MSG_ESTOP_LENGTH)
        {
            // Handle estop
        }
        return;
    }

    // Do the motor types line up?
    if(((hMotorData->Flags & MTR_FLAGMASK_MOTORCODE) >> 1) != data->Buffers[rBuf][4])
        return;

    // They're either subscribing/unsubscribing or commanding a new
    // motor reference.
    switch(data->Buffers[rBuf][4])
    {
        case MSG_START_PUBLISH:
            if(length == MSG_START_PUBLISH_LENGTH)
            {
                BYTE rate = data->Buffers[rBuf][6];
                if(rate < PBL_MAX_RATE)
                {
                    SetNewPublishRate(rate);
                }
                SetSubscriber(data->Transport, TRUE);
            }
            break;
        case MSG_STOP_PUBLISH:
            if(length == MSG_STOP_PUBLISH_LENGTH)
                SetSubscriber(data->Transport, FALSE);
            break;
        case MSG_SET_REFERENCE:
            if(length == MSG_SET_REFERENCE_LENGTH)
            {
                // Is the sender the guy in charge of me?
                if(data->Buffers[rBuf][0] == data->Common->ControllerAdd)
                {
                        hMotorData->ReferenceInput = (data->Common->Endianess) ?
                            ReadBEIntFromPacket(&data->Buffers[rBuf][6]):
                            ReadLEIntFromPacket(&data->Buffers[rBuf][6]);
                        ReferenceChanged();
                }
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

INT16 BuildOutgoingPacket(OutgoingMessagingData *data, INT16 tickCount)
{
    INT16 tmplength = 0;
    INT16 temp = 0;

    // Handle buffer switching first
    data->CurrentBuffer =
            ((data->CurrentBuffer + 1) % MSG_NUM_OUTGOING_BUFFERS);
 
    // Increment the current packet number
    data->OutgoingPacketCount++;

    // Start with the source address - its never the escape character so add it directly
    data->scratchBuf[tmplength++] = data->Common->Address;    // I'm the source
    // Next add the destination address - its never the escape character so add it directly
    data->scratchBuf[tmplength++] = data->Common->ControllerAdd;


    if(data->Common->Endianess) // Big Endian
    {
        // Insert the packet number
        AddBEIntToPacket(&data->scratchBuf[tmplength],
                data->OutgoingPacketCount,
                &tmplength);

        // Insert TypeCode
        data->scratchBuf[tmplength++] = (BYTE)((hMotorData->Flags & MTR_FLAGMASK_MOTORCODE) >> 1);

        // Insert the tick count
        AddBEIntToPacket(&data->scratchBuf[tmplength], tickCount, &tmplength);

        // Insert flags - clear out anything private
        AddBEIntToPacket(&data->scratchBuf[tmplength], hMotorData->Flags, &tmplength);

        // Insert reference input
        AddBEIntToPacket(&data->scratchBuf[tmplength], hMotorData->ReferenceInput, &tmplength);

        // Insert present output
        AddBEIntToPacket(&data->scratchBuf[tmplength], hMotorData->PresentOutput, &tmplength);

        // Insert voltage rail
        AddBEIntToPacket(&data->scratchBuf[tmplength], hMotorData->VRail, &tmplength);

        // Insert motor current
        AddBEIntToPacket(&data->scratchBuf[tmplength], hMotorData->Current, &tmplength);
    }
    else    // Little Endian
    {
        // Insert the packet number
        AddLEIntToPacket(&data->scratchBuf[tmplength],
                data->OutgoingPacketCount,
                &tmplength);

        // Insert TypeCode
        data->scratchBuf[tmplength++] = (BYTE)((hMotorData->Flags & MTR_FLAGMASK_MOTORCODE) >> 1);

        // Insert the tick count
        AddLEIntToPacket(&data->scratchBuf[tmplength], tickCount, &tmplength);

        // Insert flags - clear out anything private
        AddLEIntToPacket(&data->scratchBuf[tmplength], hMotorData->Flags, &tmplength);

        // Insert reference input
        AddLEIntToPacket(&data->scratchBuf[tmplength], hMotorData->ReferenceInput, &tmplength);

        // Insert present output
        AddLEIntToPacket(&data->scratchBuf[tmplength], hMotorData->PresentOutput, &tmplength);

        // Insert voltage rail
        AddLEIntToPacket(&data->scratchBuf[tmplength], hMotorData->VRail, &tmplength);

        // Insert motor current
        AddLEIntToPacket(&data->scratchBuf[tmplength], hMotorData->Current, &tmplength);
    }

    // Calculate the checksum
    temp = CRC16Checksum(&data->scratchBuf[0],
            tmplength);

    if(data->Common->Endianess) // Big Endian
        AddBEIntToPacket(&data->scratchBuf[tmplength], temp, &tmplength);
    else
        AddLEIntToPacket(&data->scratchBuf[tmplength], temp, &tmplength);

    tmplength = BuildEscapedPacket(&data->scratchBuf[0],
            &(data->Buffers[data->CurrentBuffer][0]),
            tmplength);

    // This function returns the total count of bytes in the buffer
    return tmplength;
}



