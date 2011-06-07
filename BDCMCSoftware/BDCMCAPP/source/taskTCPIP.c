// Include all headers for any enabled TCPIP Stack functions
#include "taskTCPIP.h"

// Declare AppConfig structure to store information on the tcpip configuration
APP_CONFIG AppConfig;
UDPConfigData gUDPConfig;
UDPData gUDPData;

// The buffers used by the incoming UDP
volatile IncomingBuffers gUDPIncBuffers;
xQueueHandle hUDPTxQueue;

///////////////////////////////////////////////////////////////////
// private helper functions
static void InitAppConfig(void);
static void InitUDPConfig(void);
static void UDPRXHandler(void);
static void UDPTXHandler(void);

// semaphore to regulate access to the FLASH, the touchscreen
// task will access it initially and then hand over control to
// the TCPIP task
extern xSemaphoreHandle FLASHSemaphore;

// handle to the task
xTaskHandle hTCPIPTask;

void xTCPIPTaskInit(void)
{
    // Initialize the MPFS2 file system
    MPFSInit();

    // Initialize the basic application configuration
    InitAppConfig();

    // Initialize the UDP settings
    InitUDPConfig();

    // Allocate the send and receive queues for the task
    hUDPTxQueue = xQueueCreate(UDP_QUEUE_SIZE, sizeof(RTOSMsg));

    // create the task to handle all TCPIP functions (namely HTTP Server)
    xTaskCreate(taskTCPIP, (signed char*) "TCPIP", STACK_SIZE_TCPIP,
		NULL, tskIDLE_PRIORITY + 2, &hTCPIPTask);
}

/*********************************************************************
 * Function:        void taskTCPIP(void* pvParameter)
 *
 * PreCondition:    None
 *
 * Input:           Pointer to optional parameter
 *                  
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        TCPIP task that runs the webserver and all
 *					of the other Ethernet activities
 *
 * Note:            
 ********************************************************************/
void taskTCPIP(void* pvParameter)
{
	portTickType previousWakeTime;
	previousWakeTime = xTaskGetTickCount();

    // Initialize the core stack layers. This makes calls
    // to the ENC28J60 driver which uses FreeRTOS. The scheduler
    // must be running to handle this.
    StackInit();

    ADCInit();
    
    for(;;)
    {
        // Block here until the timeout has passed
        vTaskDelayUntil(&previousWakeTime, 5 / portTICK_RATE_MS);

        // perform normal stack tasks including checking for incoming
        // packets and calling appropriate handlers
        StackTask();

        // call the stack related applications (including HTTP server)
        StackApplications();

        // I don't like hacking in my functions into the stack files, so call
        // the UDP stuff(specific to us) here.
        if(!MACIsLinked())  // No ethernet, no laundry
            continue;
        
       // UDPRXHandler();
        UDPTXHandler();
    }

	/* Should the task implementation ever break out of the above loop
    then the task must be deleted before reaching the end of this function.
    The NULL parameter passed to the vTaskDelete() function indicates that
    the task to be deleted is the calling (this) task. */
    vTaskDelete( NULL );
}

/*********************************************************************
 * Function:        void SaveAppConfig(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *                  
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Save the TCPIP configuration
 *
 * Note:            
 ********************************************************************/
void SaveAppConfig(APP_CONFIG* appCfg)
{
    BYTE *p;
    UINT16 d, chk;
    BYTE appVers = APP_VERSION;

    p = (BYTE*)appCfg;
    // The base address + the app_config + app_config checksum size
    d = ETH_EROM_BASE;

    // Calculate the checksum
    chk = CRC16Checksum(p, sizeof(APP_CONFIG));

    // Write the app version
    EROM_WriteBytes(d++, 1, &appVers);

    // Copy out the struct
    EROM_WriteBytes(d, sizeof(APP_CONFIG), p);

    // Write the checksum
    EROM_WriteInt16((d + sizeof(APP_CONFIG)), chk);
}

/*********************************************************************
 * Function:        void InitAppConfig(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *                  
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Initialize the TCPIP data structures, we assume
 *		    application configuration is being stored in EEPROM
 *
 * Note:            
 ********************************************************************/
static ROM BYTE SerializedMACAddress[6] = {
    MY_DEFAULT_MAC_BYTE1, MY_DEFAULT_MAC_BYTE2,
    MY_DEFAULT_MAC_BYTE3, MY_DEFAULT_MAC_BYTE4,
    MY_DEFAULT_MAC_BYTE5, MY_DEFAULT_MAC_BYTE6
};

static void InitAppConfig(void)
{
    BYTE c;
    BYTE *p;
    UINT16 d;
    APP_CONFIG tmpConfig;

    // First try to read in a valid APP_CONFIG struct. If it doesn't exist,
    // or the checksum is invalid(power failure while programming), we build
    // and save the default template.

    p = (BYTE*)&tmpConfig;
    d = ETH_EROM_BASE;

    // attempt to read in the config data from FLASH
    EROM_ReadBytes(d++, 1, &c);

    // read in the data structure from FLASH if it exists if not
    // just save our default configuration to FLASH
    if (c == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(APP_CONFIG), p);

        // The two bytes after the structure are the checksum
        INT16 savedChk = EROM_ReadInt16(d + sizeof(APP_CONFIG));

        if(CRC16Checksum(p, sizeof(APP_CONFIG)) != savedChk)
            goto CONFIG_DEFAULT_APP_CONFIG;

        // it's a valid UDPConfigData struct - copy the shadow to the real one
        memcpy((void *)&AppConfig, (void *)&tmpConfig, sizeof(APP_CONFIG));

        return;
    }

CONFIG_DEFAULT_APP_CONFIG:
    AppConfig.Flags.bIsDHCPEnabled = TRUE;
    AppConfig.Flags.bInConfigMode = TRUE;
    memcpypgm2ram((void*) &AppConfig.MyMACAddr, (ROM void*) SerializedMACAddress,
            sizeof (AppConfig.MyMACAddr));

    AppConfig.MyIPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 |
            MY_DEFAULT_IP_ADDR_BYTE2 << 8ul |
            MY_DEFAULT_IP_ADDR_BYTE3 << 16ul |
            MY_DEFAULT_IP_ADDR_BYTE4 << 24ul;
    AppConfig.DefaultIPAddr.Val = AppConfig.MyIPAddr.Val;
    AppConfig.MyMask.Val = MY_DEFAULT_MASK_BYTE1 |
            MY_DEFAULT_MASK_BYTE2 << 8ul |
            MY_DEFAULT_MASK_BYTE3 << 16ul |
            MY_DEFAULT_MASK_BYTE4 << 24ul;
    AppConfig.DefaultMask.Val = AppConfig.MyMask.Val;
    AppConfig.MyGateway.Val = MY_DEFAULT_GATE_BYTE1 |
            MY_DEFAULT_GATE_BYTE2 << 8ul |
            MY_DEFAULT_GATE_BYTE3 << 16ul |
            MY_DEFAULT_GATE_BYTE4 << 24ul;
    AppConfig.PrimaryDNSServer.Val = MY_DEFAULT_PRIMARY_DNS_BYTE1 |
            MY_DEFAULT_PRIMARY_DNS_BYTE2 << 8ul |
            MY_DEFAULT_PRIMARY_DNS_BYTE3 << 16ul |
            MY_DEFAULT_PRIMARY_DNS_BYTE4 << 24ul;
    AppConfig.SecondaryDNSServer.Val = MY_DEFAULT_SECONDARY_DNS_BYTE1 |
            MY_DEFAULT_SECONDARY_DNS_BYTE2 << 8ul |
            MY_DEFAULT_SECONDARY_DNS_BYTE3 << 16ul |
            MY_DEFAULT_SECONDARY_DNS_BYTE4 << 24ul;

    // Load the default NetBIOS Host Name
    memcpypgm2ram(AppConfig.NetBIOSName, (ROM void*) MY_DEFAULT_HOST_NAME, 16);
    FormatNetBIOSName(AppConfig.NetBIOSName);

    SaveAppConfig(&AppConfig);
}

/*********************************************************************
 * Function:        void SaveAppConfig(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Save the TCPIP configuration
 *
 * Note:
 ********************************************************************/
void SaveUDPConfig(UDPConfigData* udpCfg)
{
    BYTE *p;
    UINT16 d, chk;
    BYTE appVers = APP_VERSION;

    p = (BYTE*)udpCfg;
    // The base address + the app_config + app_config checksum size
    d = ETH_EROM_BASE + sizeof(APP_CONFIG) + sizeof(INT16);
    
    // Calculate the checksum
    chk = CRC16Checksum(p, sizeof(UDPConfigData));

    // Write the app version
    EROM_WriteBytes(d++, 1, &appVers);

    // Copy out the UDPConfig
    EROM_WriteBytes(d, sizeof(UDPConfigData), p);

    // Write the checksum
    EROM_WriteInt16((d + sizeof(UDPConfigData)), chk);
}

static void InitUDPConfig(void)
{
    BYTE c;
    BYTE *p;
    UINT16 d;
    UDPConfigData tmpConfig;    // Shadow copy to use when checking for valid EROM

    // First try to read in a valid UDPConfig struct. If it doesn't exist,
    // or the checksum is invalid(power failure while programming), we build
    // and save the default template.

    p = (BYTE*)&tmpConfig;
    d = (ETH_EROM_BASE + sizeof(APP_CONFIG) + sizeof(INT16));

    // attempt to read in the config data from FLASH
    EROM_ReadBytes(d++, 1, &c);

    // read in the data structure from FLASH if it exists if not
    // just save our default configuration to FLASH
    if (c == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(UDPConfigData), p);

        // The two bytes after the structure are the checksum
        INT16 savedChk = EROM_ReadInt16(d + sizeof(UDPConfigData));

        if(CRC16Checksum(p, sizeof(UDPConfigData)) != savedChk)
            goto CONFIG_DEFAULT_UDP;

        // it's a valid UDPConfigData struct - copy the shadow to the real one
        memcpy((void *)&gUDPConfig, (void *)&tmpConfig, sizeof(UDPConfigData));

        return;
    }

CONFIG_DEFAULT_UDP:
    gUDPConfig.Port = UDP_DEFAULT_PORT;

    SaveUDPConfig(&gUDPConfig);
}

/*********************************************************************
 * Function:  void  DelayMs(WORD time)
 *
 * PreCondition: none
 *
 * Input: time - delay in ms
 *
 * Output: none
 *
 * Side Effects: none
 *
 * Overview: delays execution on time specified in ms
 *
 * Note: delay is defined for 16MIPS
 *
 ********************************************************************/
void DelayMs(WORD time) {
    vTaskDelay(time / portTICK_RATE_MS);
}

static void UDPRXHandler(void)
{
    static INT16 pktIndex = 0;
    static INT16 mode = PKT_SEARCH_HDR;

    RTOSMsg msg;
    BYTE received;
    INT16 curBuf = gUDPIncBuffers.CurrentBuffer;
    INT16 length = 0;
    
    // Always make sure at least one socket is open
    if(gUDPData.Socket == INVALID_UDP_SOCKET)
    {
        gUDPData.Socket = UDPOpen(gUDPConfig.Port, NULL, gUDPConfig.Port);

        return; // This only skips 1 stack task call
    }

    // Check for data on the socket
    length = UDPIsGetReady(gUDPData.Socket);

    if(length <= 0) // No data packet
        return;

    if(UDPSocketInfo[gUDPData.Socket].remoteNode.IPAddr.v[4] == gCommonMsgData.ControllerAdd)
    {
        // The controller is talking to us. Save his IP info.
         memcpy((void *)&gUDPData.Controller,
                (void *)&UDPSocketInfo[gUDPData.Socket].remoteNode,
                sizeof(NODE_INFO));
    }

    // A packet is there, clear the state machine
    pktIndex = 0;
    mode = PKT_SEARCH_HDR;

    // Read the new bytes from the rx packet and unescape them
    while(length)
    {
        length--;

        UDPGet(&received);

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
                gUDPIncBuffers.Buffers[curBuf][pktIndex++] = (received ^ MSG_ESCAPE_XOR);
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
                        msg.Sender = MSG_SENDER_ETH;
                        msg.Length = pktIndex;
                        msg.Buffer = &gUDPIncBuffers.Buffers[gUDPIncBuffers.CurrentBuffer][0];
                        msg.Free = 0;
                        gUDPIncBuffers.CurrentBuffer =
                                (gUDPIncBuffers.CurrentBuffer + 1) % MSG_NUM_INCOMING_BUFFERS;

                        // This memcpy's the message struct to the queue.
                        xQueueSendToBackFromISR(hParserQueue, &msg, 0);
                    }
                    pktIndex = 0;
                }
                else
                    gUDPIncBuffers.Buffers[curBuf][pktIndex++] = received; // Copy data to buffer
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
}

static void UDPTXHandler(void)
{
    static RTOSMsg msg;
    static RTOSMsg *pMsg;

    // Always make sure at least one socket is open
    if(gUDPData.Socket == INVALID_UDP_SOCKET)
    {
        // We only every communicate on 1 port
        gUDPData.Socket = UDPOpen(gUDPConfig.Port, NULL, gUDPConfig.Port);

        return; // This only skips 1 stack task call
    }

    while(1)    // Loop to send all queue entries
    {
        // Is msg holding a valid msg? This is true if we
        // dequeued previously, but UDPIsPutReady returned
        // saying not enough bytes available.
        if(!pMsg)
        {
            if(uxQueueMessagesWaiting(hUDPTxQueue))
            {
                pMsg = &msg;
                // DON'T BLOCK IN THE TCP/IP TASK OR YOU'LL NEVER RECEIVE ANYTHING!!!
                xQueueReceive(hUDPTxQueue, pMsg, 0);
            }
            else    // No more messages on queue, exit
                return;
        }

        // Ensure the remote port hasn't been overwritten
        UDPSocketInfo[gUDPData.Socket].remotePort = gUDPConfig.Port;

        // Check we can write to the appropriate socket
        // The UDP Socket remembers who it was last talking to - don't forget!
        // This means we have to check every time, since the RX task might change
        // Remote node info if multiple clients are talking on the same port
        if(msg.Sender == MSG_SENDER_BROADCAST)
        {
            //Broadcast outgoing - set the remote data to broadcast
            memset((void*)&UDPSocketInfo[gUDPData.Socket].remoteNode,
                    0xFF, sizeof(NODE_INFO));
        }
        else
        {
            // Outgoing to the controlling device
            memcpy((void*)&UDPSocketInfo[gUDPData.Socket].remoteNode,
                   (void*)&gUDPData.Controller, sizeof(NODE_INFO));
        }

        // Normal outgoing, check that socket info
        if(!UDPIsPutReady(gUDPData.Socket) >= msg.Length)
            return; // Not enough room in the buffer to write, exit

        UDPPutArray(msg.Buffer, msg.Length);

        // Send the packet
        UDPFlush();

        if(msg.Free)
            free(msg.Buffer);

        pMsg = 0;   // Done with this message, clear and loop again
    }
}

// The COMPut functions expect the data buffer to exist
// AFTER they return. IE, malloc them when you make a msg
// and the taskUART function will free the used memory.
void UDPSend(BYTE* data, portBASE_TYPE length, portBASE_TYPE sender, portBASE_TYPE shouldFree)
{
    RTOSMsg msg;

    msg.Length = length;
    msg.Buffer = data;
    msg.Free = (shouldFree > 0) ? 1 : 0;
    msg.Sender = sender;

    // This memcpy's the message struct to the queue.
    xQueueSendToBack(hUDPTxQueue, &msg, 0);
}

void UDPSendFromISR(BYTE* data, portBASE_TYPE length,  portBASE_TYPE sender, portBASE_TYPE shouldFree)
{
    RTOSMsg msg;

    msg.Length = length;
    msg.Buffer = data;
    msg.Free = (shouldFree > 0) ? 1 : 0;
    msg.Sender = sender;
    
    // This memcpy's the message struct to the queue.
    xQueueSendToBackFromISR(hUDPTxQueue, &msg, 0);
}


