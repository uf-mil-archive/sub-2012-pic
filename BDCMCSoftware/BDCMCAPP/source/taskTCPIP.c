// Include all headers for any enabled TCPIP Stack functions
#include "taskTCPIP.h"
#include "taskUART.h"

#include "adc.h"
#include "mcp25XX640A.h"

// appconfig version number
#define APP_VERSION		0x60

// Declare AppConfig structure to store information on the tcpip configuration
APP_CONFIG AppConfig;
UDPConfigData gUDPConfig;

// The buffers used by the incoming UDP
volatile IncomingBuffers gUARTIncBuffers;
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
void taskTCPIP(void* pvParameter) {
    //COMPut("TCPIP: Task Started.\r\n", 22, UART_DONT_FREE_BUFFER);

    // Initialize the core stack layers. This makes calls
    // to the ENC28J60 driver which uses FreeRTOS. The scheduler
    // must be running to handle this.
    StackInit();

    ADCInit();
    
    for(;;)
    {
        vTaskDelay(5 / portTICK_RATE_MS);

        // perform normal stack tasks including checking for incoming
        // packets and calling appropriate handlers
        StackTask();

        // call the stack related applications (including HTTP server)
        StackApplications();

        // I don't like hacking in my functions into the stack files, so call
        // the UDP stuff(specific to us) here.
        UDPRXHandler();
        UDPTXHandler();
    }
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
    UINT16 d;

    p = (BYTE*)appCfg;
    d = ETH_EROM_BASE;
    BYTE appVers = APP_VERSION;

    // Write the app version
    EROM_WriteBytes(d++, 1, &appVers);

    // Copy out the AppConfig
    EROM_WriteBytes(d, sizeof(APP_CONFIG), p);
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

    p = (BYTE*)&AppConfig;
    d = ETH_EROM_BASE;

    // attempt to read in the config data from FLASH
    EROM_ReadBytes(d++, 1, &c);

    // read in the data structure from FLASH if it exists if not
    // just save our default configuration to FLASH
    if (c == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(APP_CONFIG), p);
    } 
    else
    {
        SaveAppConfig(&AppConfig);
    }
}

static void InitUDPConfig(void)
{
    BYTE c;
    BYTE *p;
    UINT16 d;

    gUDPConfig.RXSocket = INVALID_SOCKET;
    gUDPConfig.TXSocket = INVALID_SOCKET;

    gUDPConfig.TXDestNode.IPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 |
            MY_DEFAULT_IP_ADDR_BYTE2 << 8ul |
            MY_DEFAULT_IP_ADDR_BYTE3 << 16ul |
            MY_DEFAULT_IP_ADDR_BYTE4 << 24ul;

    memcpypgm2ram((void*) &gUDPConfig.TXDestNode.MACAddr, (ROM void*) SerializedMACAddress,
            sizeof (MAC_ADDR));

    gUDPConfig.RXPort = UDP_DEFAULT_RXPORT;
    gUDPConfig.TXRemotePort = UDP_DEFAULT_REMOTE_TXPORT;

    p = (BYTE*)&gUDPConfig;
    d = ((ETH_EROM_BASE + sizeof(APP_CONFIG)) % EROM_PAGE_SIZE) + EROM_PAGE_SIZE;

    // attempt to read in the config data from FLASH
    EROM_ReadBytes(d++, 1, &c);

    // read in the data structure from FLASH if it exists if not
    // just save our default configuration to FLASH
    if (c == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(UDPConfigData), p);
    }
    else
    {

    }
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
    if(!MACIsLinked())  // No ethernet, no laundry
        return;

    // If the socket isn't valid, try to reopen it
    if(rxSocket == INVALID_UDP_SOCKET)
    {

    }
}

static void UDPTXHandler(void)
{
    if(!MACIsLinked())  // No ethernet, no laundry
        return;

    if(txSocket == INVALID_UDP_SOCKET)
    {
        memset(&txRemote, 0xFF, sizeof(txRemote));

        txSocket = UDPOpen(0,&txRemote, 9);

        return; // This only skips 1 stack task call
    }

    // Check we can write to the socket
    if(!UDPIsPutReady(txSocket))
        return;

    UDPPutROMString("Hello, UDP!");

    // Send the packet
    UDPFlush();
}

// The COMPut functions expect the data buffer to exist
// AFTER they return. IE, malloc them when you make a msg
// and the taskUART function will free the used memory.
void UDPSend(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree)
{
    RTOSMsg msg;

    msg.Length = length;
    msg.Buffer = data;
    msg.Free = (shouldFree > 0) ? 1 : 0;

    // This memcpy's the message struct to the queue.
    xQueueSendToBack(hUDPTxQueue, &msg, 0);
}

void UDPSendFromISR(BYTE* data, portBASE_TYPE length, portBASE_TYPE shouldFree)
{
    RTOSMsg msg;

    msg.Length = length;
    msg.Buffer = data;
    msg.Free = (shouldFree > 0) ? 1 : 0;

    // This memcpy's the message struct to the queue.
    xQueueSendToBackFromISR(hUDPTxQueue, &msg, 0);
}