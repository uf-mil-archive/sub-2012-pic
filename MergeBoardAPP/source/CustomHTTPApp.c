/*********************************************************************
 *
 *  Application to Demo HTTP2 Server
 *  Support for HTTP2 module in Microchip TCP/IP Stack
 *	 -Implements the application 
 *	 -Reference: RFC 1002
 *
 *********************************************************************
 * FileName:        CustomHTTPApp.c
 * Dependencies:    TCP/IP stack
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F, PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *					Microchip C30 v3.12 or higher
 *					Microchip C18 v3.30 or higher
 *					HI-TECH PICC-18 PRO 9.63PL2 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2010 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and
 * distribute:
 * (i)  the Software when embedded on a Microchip microcontroller or
 *      digital signal controller product ("Device") which is
 *      integrated into Licensee's product; or
 * (ii) ONLY the Software driver source files ENC28J60.c, ENC28J60.h,
 *		ENCX24J600.c and ENCX24J600.h ported to a non-Microchip device
 *		used in conjunction with a Microchip ethernet controller for
 *		the sole purpose of interfacing with the ethernet controller.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date    Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Elliott Wood     	6/18/07	Original
 ********************************************************************/
#define __CUSTOMHTTPAPP_C

#include "TCPIPConfig.h"


#if defined(STACK_USE_HTTP2_SERVER)

#include "FreeRTOS.h"
#include "TCPIP Stack/TCPIP.h"
#include "taskTCPIP.h"

#include "mcp25XX640A.h"
#include "taskUART.h"
#include "taskParser.h"
#include "taskPublisher.h"

#include <math.h>

/****************************************************************************
  Section:
	Function Prototypes and Memory Globalizers
  ***************************************************************************/
extern APP_CONFIG AppConfig;
static HTTP_IO_RESULT HTTPNetConfig(void);
static HTTP_IO_RESULT HTTPSerialConfig(void);
// Sticky status message variable.
// This is used to indicated whether or not the previous POST operation was 
// successful.  The application uses these to store status messages when a 
// POST operation redirects.  This lets the application provide status messages
// after a redirect, when connection instance data has already been lost.
static BOOL lastSuccess = FALSE;

// Stick status message variable.  See lastSuccess for details.
static BOOL lastFailure = FALSE;


void HTTPPrintZero(TCP_SOCKET tcp)
{
    TCPPutROMString(sktHTTP, (ROM BYTE*)"0.0");
}

HTTP_IO_RESULT HTTPExecuteGet(void)
{
    return HTTP_IO_DONE;
}

/****************************************************************************
  Section:
	POST Form Handlers
  ***************************************************************************/
#if defined(HTTP_USE_POST)
/*****************************************************************************
  Function:
	HTTP_IO_RESULT HTTPExecutePost(void)
	
  Internal:
  	See documentation in the TCP/IP Stack API or HTTP2.h for details.
  ***************************************************************************/
HTTP_IO_RESULT HTTPExecutePost(void)
{
    // Resolve which function to use and pass along
    BYTE filename[20];

    // Load the file name
    // Make sure BYTE filename[] above is large enough for your longest name
    MPFSGetFilename(curHTTP.file, filename, sizeof(filename));

    if(!memcmppgm2ram(filename, "netconfig.htm", 13))
    {
        return HTTPNetConfig();
    }
    else if(!memcmppgm2ram(filename, "serconfig.htm", 13))
    {
        return HTTPSerialConfig();
    }

    return HTTP_IO_DONE;
}


/*****************************************************************************
  Function:
	static HTTP_IO_RESULT HTTPPostConfig(void)

  Summary:
	Processes the configuration form on config/index.htm

  Description:
	Accepts configuration parameters from the form, saves them to a
	temporary location in RAM, then eventually saves the data to EEPROM or
	external Flash.
	
	When complete, this function redirects to config/reboot.htm, which will
	display information on reconnecting to the board.

	This function creates a shadow copy of the AppConfig structure in 
	RAM and then overwrites incoming data there as it arrives.  For each 
	name/value pair, the name is first read to curHTTP.data[0:5].  Next, the 
	value is read to newAppConfig.  Once all data has been read, the new
	AppConfig is saved back to EEPROM and the browser is redirected to 
	reboot.htm.  That file includes an AJAX call to reboot.cgi, which 
	performs the actual reboot of the machine.
	
	If an IP address cannot be parsed, too much data is POSTed, or any other 
	parsing error occurs, the browser reloads config.htm and displays an error 
	message at the top.

  Precondition:
	None

  Parameters:
	None

  Return Values:
  	HTTP_IO_DONE - all parameters have been processed
  	HTTP_IO_NEED_DATA - data needed by this function has not yet arrived
  ***************************************************************************/
static HTTP_IO_RESULT HTTPNetConfig(void)
{
    APP_CONFIG newAppConfig;
    UDPConfigData newUDPConfig;
    CommonMessagingData newCommonData;

    BYTE *ptr;
    BYTE i;

    // Check to see if the browser is attempting to submit more data than we
    // can parse at once.  This function needs to receive all updated
    // parameters and validate them all before committing them to memory so that
    // orphaned configuration parameters do not get written (for example, if a
    // static IP address is given, but the subnet mask fails parsing, we
    // should not use the static IP address).  Everything needs to be processed
    // in a single transaction.  If this is impossible, fail and notify the user.
    // As a web devloper, if you add parameters to AppConfig and run into this
    // problem, you could fix this by to splitting your update web page into two
    // seperate web pages (causing two transactional writes).  Alternatively,
    // you could fix it by storing a static shadow copy of AppConfig someplace
    // in memory and using it instead of newAppConfig.  Lastly, you could
    // increase the TCP RX FIFO size for the HTTP server.  This will allow more
    // data to be POSTed by the web browser before hitting this limit.
    if(curHTTP.byteCount > TCPIsGetReady(sktHTTP) + TCPGetRxFIFOFree(sktHTTP))
            goto NetConfigFailure;

    // Ensure that all data is waiting to be parsed.  If not, keep waiting for
    // all of it to arrive.
    if(TCPIsGetReady(sktHTTP) < curHTTP.byteCount)
            return HTTP_IO_NEED_DATA;


    // Use current config in non-volatile memory as defaults
    EROM_ReadBytes(ETH_EROM_BASE+1, sizeof(APP_CONFIG),(BYTE*)&newAppConfig);


    // Start out assuming that DHCP is disabled.  This is necessary since the
    // browser doesn't submit this field if it is unchecked (meaning zero).
    // However, if it is checked, this will be overridden since it will be
    // submitted.
    newAppConfig.Flags.bIsDHCPEnabled = 0;

    // Read all browser POST data
    while(curHTTP.byteCount)
    {
        // Read a form field name
        if(HTTPReadPostName(curHTTP.data, 6) != HTTP_READ_OK)
                goto NetConfigFailure;

        // Read a form field value
        if(HTTPReadPostValue(curHTTP.data + 6, sizeof(curHTTP.data)-6-2) != HTTP_READ_OK)
                goto NetConfigFailure;

        // Parse the value that was read
        if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"ip"))
        {// Read new static IP Address
                if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.MyIPAddr))
                        goto NetConfigFailure;

                newAppConfig.DefaultIPAddr.Val = newAppConfig.MyIPAddr.Val;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"gw"))
        {// Read new gateway address
                if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.MyGateway))
                        goto NetConfigFailure;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"sub"))
        {// Read new static subnet
                if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.MyMask))
                        goto NetConfigFailure;

                newAppConfig.DefaultMask.Val = newAppConfig.MyMask.Val;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"dns1"))
        {// Read new primary DNS server
                if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.PrimaryDNSServer))
                        goto NetConfigFailure;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"dns2"))
        {// Read new secondary DNS server
                if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.SecondaryDNSServer))
                        goto NetConfigFailure;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"mac"))
        {
                // Read new MAC address
                WORD w;
                BYTE i;

                ptr = curHTTP.data+6;

                for(i = 0; i < 12u; i++)
                {// Read the MAC address

                        // Skip non-hex bytes
                        while( *ptr != 0x00u && !(*ptr >= '0' && *ptr <= '9') && !(*ptr >= 'A' && *ptr <= 'F') && !(*ptr >= 'a' && *ptr <= 'f') )
                                ptr++;

                        // MAC string is over, so zeroize the rest
                        if(*ptr == 0x00u)
                        {
                                for(; i < 12u; i++)
                                        curHTTP.data[i] = '0';
                                break;
                        }

                        // Save the MAC byte
                        curHTTP.data[i] = *ptr++;
                }

                // Read MAC Address, one byte at a time
                for(i = 0; i < 6u; i++)
                {
                        ((BYTE*)&w)[1] = curHTTP.data[i*2];
                        ((BYTE*)&w)[0] = curHTTP.data[i*2+1];
                        newAppConfig.MyMACAddr.v[i] = hexatob(*((WORD_VAL*)&w));
                }
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"host"))
        {// Read new hostname
                FormatNetBIOSName(&curHTTP.data[6]);
                memcpy((void*)newAppConfig.NetBIOSName, (void*)curHTTP.data+6, 16);
        }
        /* Additional parameters added are controlling devices IP, and the
         * UDP port that we listen to.
         */
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"cip"))
        {// The controlling devices IP
            if(!StringToIPAddress(curHTTP.data+6, &newUDPConfig.ControllerIP))
                goto NetConfigFailure;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"udp"))
        {// Which UDP port should I use?            
            unsigned long result = strtoul((char*)curHTTP.data+6, NULL, 10);
            if(result < 65535)
                newUDPConfig.Port = (UINT16)result;
            else
                goto NetConfigFailure;
        }
        else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"end"))
        {// Endianess setting
            if(!strcmppgm2ram((char*)curHTTP.data+6, (ROM char*)"lit"))
                newCommonData.Endianess = MSG_ENDIANESS_LITTLE;
            else if(!strcmppgm2ram((char*)curHTTP.data+6, (ROM char*)"big"))
                newCommonData.Endianess = MSG_ENDIANESS_BIG;
            else
                goto NetConfigFailure;
        }
    }


    // All parsing complete!  Save new settings and force a reboot
    SaveAppConfig(&newAppConfig);
    SaveUDPConfig(&newUDPConfig);

    // Strip out the relevant parts for controller/local address
    newCommonData.Address = newAppConfig.MyIPAddr.byte.MB;
    newCommonData.ControllerAdd = newUDPConfig.ControllerIP.byte.MB;
    newCommonData.MultiCastAddress = 255;
    
    SaveCommonMessageData(&newCommonData);

    // Set the board to reboot and display reconnecting information
    strcpypgm2ram((char*)curHTTP.data, "reboot.htm?");
    memcpy((void*)(curHTTP.data+20), (void*)newAppConfig.NetBIOSName, 16);
    curHTTP.data[20+16] = 0x00;	// Force null termination
    for(i = 20; i < 20u+16u; i++)
    {
            if(curHTTP.data[i] == ' ')
                    curHTTP.data[i] = 0x00;
    }
    curHTTP.httpStatus = HTTP_REDIRECT;

    return HTTP_IO_DONE;


NetConfigFailure:
    lastFailure = TRUE;
    strcpypgm2ram((char*)curHTTP.data, "netconfig.htm");
    curHTTP.httpStatus = HTTP_REDIRECT;
    return HTTP_IO_DONE;
}

static HTTP_IO_RESULT HTTPSerialConfig(void)
{
    INT16 i;

    // Like before, we do this in one shot
    if(curHTTP.byteCount > TCPIsGetReady(sktHTTP) + TCPGetRxFIFOFree(sktHTTP))
            goto SerConfigFailure;

    // Ensure that all data is waiting to be parsed.  If not, keep waiting for
    // all of it to arrive.
    if(TCPIsGetReady(sktHTTP) < curHTTP.byteCount)
            return HTTP_IO_NEED_DATA;

    // Read all browser POST data
    while(curHTTP.byteCount)
    {
        // Read a form field name
        if(HTTPReadPostName(curHTTP.data, 7) != HTTP_READ_OK)
                goto SerConfigFailure;

        // Read a form field value
        if(HTTPReadPostValue(curHTTP.data + 7, sizeof(curHTTP.data)-7-2) != HTTP_READ_OK)
                goto SerConfigFailure;

        // Parse the value that was read
        if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"baud"))
        {// New baud setting
            if(!strcmppgm2ram((char*)curHTTP.data+7, (ROM char*)"b9k"))
                gUARTConfig.BaudDiv = BAUDREG_9600;
            else if(!strcmppgm2ram((char*)curHTTP.data+7, (ROM char*)"b38k"))
                gUARTConfig.BaudDiv = BAUDREG_38400;
            else if(!strcmppgm2ram((char*)curHTTP.data+7, (ROM char*)"b56k"))
                gUARTConfig.BaudDiv = BAUDREG_56000;
            else if(!strcmppgm2ram((char*)curHTTP.data+7, (ROM char*)"b115k"))
                gUARTConfig.BaudDiv = BAUDREG_115200;
            else if(!strcmppgm2ram((char*)curHTTP.data+7, (ROM char*)"b250k"))
                gUARTConfig.BaudDiv = BAUDREG_250000;
            else
                goto SerConfigFailure;
        }
    }

    SaveUARTConfig(&gUARTConfig);

    // Set the board to reboot and display reconnecting information
    strcpypgm2ram((char*)curHTTP.data, "reboot.htm?");
    memcpy((void*)(curHTTP.data+20), (void*)AppConfig.NetBIOSName, 16);
    curHTTP.data[20+16] = 0x00;	// Force null termination
    for(i = 20; i < 20u+16u; i++)
    {
            if(curHTTP.data[i] == ' ')
                    curHTTP.data[i] = 0x00;
    }
    curHTTP.httpStatus = HTTP_REDIRECT;

    return HTTP_IO_DONE;

SerConfigFailure:
    lastFailure = TRUE;
    strcpypgm2ram((char*)curHTTP.data, "serconfig.htm");
    curHTTP.httpStatus = HTTP_REDIRECT;
    return HTTP_IO_DONE;
}

#endif //(use_post)


/****************************************************************************
  Section:
	Dynamic Variable Callback Functions
  ***************************************************************************/

/*****************************************************************************
  Function:
	void HTTPPrint_varname(void)
	
  Internal:
  	See documentation in the TCP/IP Stack API or HTTP2.h for details.
  ***************************************************************************/

void HTTPPrint_builddate(void)
{
    curHTTP.callbackPos = 0x01;
    if(TCPIsPutReady(sktHTTP) < strlenpgm((ROM char*)__DATE__" "__TIME__))
            return;

    curHTTP.callbackPos = 0x00;
    TCPPutROMString(sktHTTP, (ROM void*)__DATE__" "__TIME__);
}

void HTTPPrint_version(void)
{
    TCPPutROMString(sktHTTP, (ROM void*)TCPIP_STACK_VERSION);
}

extern APP_CONFIG AppConfig;

void HTTPPrintIP(IP_ADDR ip)
{
    BYTE digits[4];
    BYTE i;

    for(i = 0; i < 4u; i++)
    {
            if(i)
                    TCPPut(sktHTTP, '.');
            uitoa(ip.v[i], digits);
            TCPPutString(sktHTTP, digits);
    }
}

void HTTPPrint_config_hostname(void)
{
    TCPPutString(sktHTTP, AppConfig.NetBIOSName);
    return;
}

void HTTPPrint_config_ip(void)
{
    HTTPPrintIP(AppConfig.MyIPAddr);
    return;
}

void HTTPPrint_config_gw(void)
{
    HTTPPrintIP(AppConfig.MyGateway);
    return;
}

void HTTPPrint_config_subnet(void)
{
    HTTPPrintIP(AppConfig.MyMask);
    return;
}

void HTTPPrint_config_dns1(void)
{
    HTTPPrintIP(AppConfig.PrimaryDNSServer);
    return;
}

void HTTPPrint_config_dns2(void)
{
    HTTPPrintIP(AppConfig.SecondaryDNSServer);
    return;
}

void HTTPPrint_config_mac(void)
{
    BYTE i;

    if(TCPIsPutReady(sktHTTP) < 18u)
    {//need 17 bytes to write a MAC
            curHTTP.callbackPos = 0x01;
            return;
    }

    // Write each byte
    for(i = 0; i < 6u; i++)
    {
            if(i)
                TCPPut(sktHTTP, ':');
            TCPPut(sktHTTP, btohexa_high(AppConfig.MyMACAddr.v[i]));
            TCPPut(sktHTTP, btohexa_low(AppConfig.MyMACAddr.v[i]));
    }

    // Indicate that we're done
    curHTTP.callbackPos = 0x00;
    return;
}

void HTTPPrint_config_udpport(void)
{
    BYTE digits[8];

    uitoa(gUDPConfig.Port, digits);
    TCPPutString(sktHTTP, digits);

    return;
}

void HTTPPrint_config_controlip(void)
{
    HTTPPrintIP(gUDPConfig.ControllerIP);
    return;
}

void HTTPPrint_reboot(void)
{
    // This is not so much a print function, but causes the board to reboot
    // when the configuration is changed.  If called via an AJAX call, this
    // will gracefully reset the board and bring it back online immediately
    Reset();
}

void HTTPPrint_rebootaddr(void)
{
    // This is the expected address of the board upon rebooting
    TCPPutString(sktHTTP, curHTTP.data);
}

void HTTPPrint_status_ok(void)
{
    if(lastSuccess)
            TCPPutROMString(sktHTTP, (ROM BYTE*)"block");
    else
            TCPPutROMString(sktHTTP, (ROM BYTE*)"none");
    lastSuccess = FALSE;
}

void HTTPPrint_status_fail(void)
{
    if(lastFailure)
            TCPPutROMString(sktHTTP, (ROM BYTE*)"block");
    else
            TCPPutROMString(sktHTTP, (ROM BYTE*)"none");
    lastFailure = FALSE;
}

void HTTPPrint_task_stack(WORD num)
{
    BYTE used[8];
    BYTE max[8];

    switch(num)
    {
        case 0:
            uitoa(uxTaskGetStackHighWaterMark(hTCPIPTask)*sizeof(portSTACK_TYPE), used);
            TCPPutString(sktHTTP, used);
            TCPPut(sktHTTP, '/');
            uitoa(STACK_SIZE_TCPIP*sizeof(portSTACK_TYPE), max);
            TCPPutString(sktHTTP, max);
            break;
        case 1:
            uitoa(uxTaskGetStackHighWaterMark(hUARTTask)*sizeof(portSTACK_TYPE), used);
            TCPPutString(sktHTTP, used);
            TCPPut(sktHTTP, '/');
            uitoa(STACK_SIZE_UART*sizeof(portSTACK_TYPE), max);
            TCPPutString(sktHTTP, max);
            break;
        case 2:
            uitoa(uxTaskGetStackHighWaterMark(hPublisherTask)*sizeof(portSTACK_TYPE), used);
            TCPPutString(sktHTTP, used);
            TCPPut(sktHTTP, '/');
            uitoa(STACK_SIZE_PUBLISHER*sizeof(portSTACK_TYPE), max);
            TCPPutString(sktHTTP, max);
            break;
        case 3:
            uitoa(uxTaskGetStackHighWaterMark(hParserTask)*sizeof(portSTACK_TYPE), used);
            TCPPutString(sktHTTP, used);
            TCPPut(sktHTTP, '/');
            uitoa(STACK_SIZE_PARSER*sizeof(portSTACK_TYPE), max);
            TCPPutString(sktHTTP, max);
            break;
        default:
            break;
    }
}

void HTTPPrint_config_endian(WORD val)
{
    if(val == gCommonMsgData.Endianess)    // Little endian check
        TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
}

void HTTPPrint_config_serbaud(WORD val)
{
    switch(val)
    {
        case 0:
            if(gUARTConfig.BaudDiv == BAUDREG_9600)
                TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
            break;
        case 1:
            if(gUARTConfig.BaudDiv == BAUDREG_38400)
                TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
            break;
        case 2:
            if(gUARTConfig.BaudDiv == BAUDREG_56000)
                TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
            break;
        case 3:
            if(gUARTConfig.BaudDiv == BAUDREG_115200)
                TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
            break;
        case 4:
            if(gUARTConfig.BaudDiv == BAUDREG_250000)
                TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
            break;
        default:    // Unrecognized
            break;
    }
}

#endif
