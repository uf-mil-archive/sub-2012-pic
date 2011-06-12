#include "messages.h"

CommonMessagingData gCommonMsgData;

IncomingMessagingData gIncomingMsgData;
OutgoingMessagingData gOutgoingMsgData;
OutgoingBuffers gOutgoingBuffers;

void InitCommonMessageData(void)
{
    BYTE c;
    BYTE *p;
    UINT16 d;
    CommonMessagingData tmpData;    // Shadow copy to use when checking for valid EROM

    // First try to read in a valid CommonMessagingData struct. If it doesn't
    // exist, or the checksum is invalid(power failure while programming), we
    // build and save the default template.

    p = (BYTE*)&tmpData;
    d = COMMON_EROM_BASE;

    // attempt to read in the config data from FLASH
    EROM_ReadBytes(d++, 1, &c);

    // read in the data structure from FLASH if it exists if not
    // just save our default configuration to FLASH
    if (c == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(CommonMessagingData), p);

        // The two bytes after the structure are the checksum
        INT16 savedChk = EROM_ReadInt16(d + sizeof(CommonMessagingData));

        if(CRC16Checksum(p, sizeof(CommonMessagingData)) != savedChk)
            goto CONFIG_DEFAULT_COMMON;

        // it's a valid struct - copy the shadow to the real one
        memcpy((void *)&gCommonMsgData, (void *)&tmpData, sizeof(CommonMessagingData));

        return;
    }

CONFIG_DEFAULT_COMMON:
    gCommonMsgData.Address = DEFAULT_LOCAL_ADDRESS;
    gCommonMsgData.ControllerAdd = DEFAULT_CONTROLLER_ADDRESS;
    gCommonMsgData.Endianess = DEFAULT_ENDIANESS;

    SaveCommonMessageData(&gCommonMsgData);
}

void SaveCommonMessageData(CommonMessagingData *cmnData)
{
    BYTE *p;
    UINT16 d, chk;
    BYTE appVers = APP_VERSION;

    p = (BYTE*)cmnData;

    d = COMMON_EROM_BASE;

    // Calculate the checksum
    chk = CRC16Checksum(p, sizeof(CommonMessagingData));

    // Write the app version
    EROM_WriteBytes(d++, 1, &appVers);

    // Copy out the struct
    EROM_WriteBytes(d, sizeof(CommonMessagingData), p);

    // Write the checksum
    EROM_WriteInt16((d + sizeof(CommonMessagingData)), chk);
}

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
    UINT16 checkSum = (gCommonMsgData.Endianess == MSG_ENDIANESS_BIG) ?
        ReadBEIntFromPacket(&rBuf[length - 2]) :
        ReadLEIntFromPacket(&rBuf[length - 2]);
        
    // First, validate the checksum
    if(CRC16Checksum(&rBuf[0], length - 2) != checkSum)
        return;

    /* It's a valid packet. Check to make sure we are the intended recipient. */
    if(gCommonMsgData.Address == rBuf[1])   // To us
        gIncomingMsgData.MessageCount++;
    else if(gCommonMsgData.MultiCastAddress == rBuf[1]) // To our multicast
        gIncomingMsgData.MulticastCount++;
    else // Not for us
        return;

    // The next two bytes are packet count of the transmitter

    // Okay, they're talking to us. Is the message a heartbeat or ESTOP?
    if(rBuf[4] == MSG_FEED_HEARTBEAT)
    {
        if(length == MSG_FEED_HEARTBEAT_LENGTH)
        {
            // Is the sender the guy in charge of me?
            if(rBuf[0] == gCommonMsgData.ControllerAdd)
                Nop();//FeedHeartbeat();
        }
        return;
    }
	// The depth board doesn't care about e-stops

    // Does the packet type agree?
    if(DEPTH_TYPE_CODE != rBuf[4])
          return;

    // They're subscribing/unsubscribing
    switch(rBuf[5])
    {
        case MSG_START_PUBLISH:
            if(length == MSG_START_PUBLISH_LENGTH)
            {
                BYTE rate = rBuf[6];

                SetNewPublishRate(rate);
                SetSubscriber(transport, TRUE);
            }
            break;
        case MSG_STOP_PUBLISH:
            if(length == MSG_STOP_PUBLISH_LENGTH)
                SetSubscriber(transport, FALSE);
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

INT16 BuildOutgoingPacket(BYTE** pkt, INT16 tickCount)
{
    INT16 tmplength = 0;
    INT16 temp = 0;

    // Handle buffer switching first
    gOutgoingBuffers.CurrentBuffer =
            ((gOutgoingBuffers.CurrentBuffer + 1) % MSG_NUM_OUTGOING_BUFFERS);
 
    // Increment the current packet number
    gOutgoingMsgData.OutgoingCount++;

    // Start with the source address - its never the escape character so add it directly
    gOutgoingBuffers.scratchBuf[tmplength++] = gCommonMsgData.Address;    // I'm the source
    // Next add the destination address - its never the escape character so add it directly
    gOutgoingBuffers.scratchBuf[tmplength++] = gCommonMsgData.ControllerAdd;


    if(gCommonMsgData.Endianess == MSG_ENDIANESS_BIG) // Big Endian
    {
        // Insert the packet number
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength],
                gOutgoingMsgData.OutgoingCount,
                &tmplength);

        // Insert TypeCode
        gOutgoingBuffers.scratchBuf[tmplength++] = (BYTE)DEPTH_TYPE_CODE;

        // Insert the tick count
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], tickCount, &tmplength);

        // Insert the depth
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.Depth, &tmplength);

        // Insert the thermistor temperature
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.ThermTemp, &tmplength);

        // Insert the humidity
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.Humidity, &tmplength);

        // Insert the humidity sensor temp reading
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.HumTemp, &tmplength);
    }
    else    // Little Endian
    {
        // Insert the packet number
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength],
                gOutgoingMsgData.OutgoingCount,
                &tmplength);

        // Insert TypeCode
        gOutgoingBuffers.scratchBuf[tmplength++] = (BYTE)DEPTH_TYPE_CODE;

        // Insert the tick count
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], tickCount, &tmplength);

        // Insert the depth
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.Depth, &tmplength);

        // Insert the thermistor temperature
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.ThermTemp, &tmplength);

        // Insert the humidity
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.Humidity, &tmplength);

        // Insert the humidity sensor temp reading
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], gSensorData.HumTemp, &tmplength);
    }

    // Calculate the checksum
    temp = CRC16Checksum(&gOutgoingBuffers.scratchBuf[0],
            tmplength);

    if(gCommonMsgData.Endianess == MSG_ENDIANESS_BIG) // Big Endian
        AddBEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], temp, &tmplength);
    else
        AddLEIntToPacket(&gOutgoingBuffers.scratchBuf[tmplength], temp, &tmplength);

    tmplength = BuildEscapedPacket(&gOutgoingBuffers.scratchBuf[0],
            &(gOutgoingBuffers.Buffers[gOutgoingBuffers.CurrentBuffer][0]),
            tmplength);

    // Point to the newly escaped packet
    *pkt = &(gOutgoingBuffers.Buffers[gOutgoingBuffers.CurrentBuffer][0]);

    // This function returns the total count of bytes in the buffer
    return tmplength;
}



