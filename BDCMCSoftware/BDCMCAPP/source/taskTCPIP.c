/*****************************************************************************
 * Microchip RTOS and Stacks Demo
 *****************************************************************************
 * FileName:        taskTCPIP.c
 * Dependencies:    
 * Processor:       PIC24, PIC32
 * Compiler:       	MPLAB C30 V3.00, MPLAB C32
 * Linker:          MPLAB LINK30, MPLAB LINK32
 * Company:         Microchip Technology Incorporated
 *
 * Software License Agreement
 *
 * Copyright � 2008 Microchip Technology Inc.  All rights reserved.
 * Microchip licenses to you the right to use, modify, copy and distribute
 * Software only when embedded on a Microchip microcontroller or digital
 * signal controller, which is integrated into your product or third party
 * product (pursuant to the sublicense terms in the accompanying license
 * agreement).  
 *
 * You should refer to the license agreement accompanying this Software
 * for additional information regarding your rights and obligations.
 *
 * SOFTWARE AND DOCUMENTATION ARE PROVIDED �AS IS� WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY
 * OF MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR
 * PURPOSE. IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR
 * OBLIGATED UNDER CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION,
 * BREACH OF WARRANTY, OR OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT
 * DAMAGES OR EXPENSES INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL,
 * INDIRECT, PUNITIVE OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA,
 * COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY
 * CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
 * OR OTHER SIMILAR COSTS.
 *
 * Version  Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 1.0      D.Wenn               09/29/08    Initial version 
 * 1.1		D.Wenn				 07/02/09	 Modified to use flash on gfx
 *											 board for data storage  
 *****************************************************************************/

// Include all headers for any enabled TCPIP Stack functions
#include "taskTCPIP.h"
#include "taskUART.h"

#include "adc.h"
#include "mcp25XX640A.h"

// appconfig version number
#define APP_VERSION		0x60

// Declare AppConfig structure to store information on the tcpip configuration
APP_CONFIG AppConfig;
static DWORD dwLastIP = 0;

///////////////////////////////////////////////////////////////////
// private helper functions
static void InitAppConfig(void);
static void DisplayIPValue(IP_ADDR IPVal);

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

    // initialize the basic application configuration
    InitAppConfig();

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

        // if the DHCP lease has changed then display the new value
        // on the UART and display
        if (dwLastIP != AppConfig.MyIPAddr.Val) {
            dwLastIP = AppConfig.MyIPAddr.Val;
            DisplayIPValue(AppConfig.MyIPAddr);
        }
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

/*********************************************************************
 * Function:        static void DisplayIPValue(IP_ADDR IPVal)
 *
 * PreCondition:    None
 *
 * Input:           4 byte IP address
 *                  
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Print the IP address on the UART
 *
 * Note:            
 ********************************************************************/
static void DisplayIPValue(IP_ADDR IPVal) 
{

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
