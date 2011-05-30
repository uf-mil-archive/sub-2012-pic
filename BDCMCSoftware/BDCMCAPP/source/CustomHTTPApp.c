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

#include "TCPIP Stack/TCPIP.h"
#include "taskTCPIP.h"
#include "mcp25XX640A.h"
#include "motor.h"

/****************************************************************************
  Section:
	Function Prototypes and Memory Globalizers
  ***************************************************************************/
#if defined(HTTP_USE_POST)
    #if defined(STACK_USE_HTTP_APP_RECONFIG)
        extern APP_CONFIG AppConfig;
        static HTTP_IO_RESULT HTTPPostConfig(void);
    #endif
#endif

// RAM allocated for DDNS parameters
#if defined(STACK_USE_DYNAMICDNS_CLIENT)
	static BYTE DDNSData[100];
#endif

// Sticky status message variable.
// This is used to indicated whether or not the previous POST operation was 
// successful.  The application uses these to store status messages when a 
// POST operation redirects.  This lets the application provide status messages
// after a redirect, when connection instance data has already been lost.
static BOOL lastSuccess = FALSE;

// Stick status message variable.  See lastSuccess for details.
static BOOL lastFailure = FALSE;

/****************************************************************************
  Section:
	GET Form Handlers
  ***************************************************************************/
  
/*****************************************************************************
  Function:
	HTTP_IO_RESULT HTTPExecuteGet(void)
	
  Internal:
  	See documentation in the TCP/IP Stack API or HTTP2.h for details.
  ***************************************************************************/
HTTP_IO_RESULT HTTPExecuteGet(void)
{
    BYTE *ptr;
    BYTE filename[20];

    // Load the file name
    // Make sure BYTE filename[] above is large enough for your longest name
    MPFSGetFilename(curHTTP.file, filename, 20);

    // If its the forms.htm page
    if(!memcmppgm2ram(filename, "forms.htm", 9))
    {
//		// Seek out each of the four LED strings, and if it exists set the LED states
//		ptr = HTTPGetROMArg(curHTTP.data, (ROM BYTE *)"led4");
//		if(ptr)
//			LED4_IO = (*ptr == '1');
//
//		ptr = HTTPGetROMArg(curHTTP.data, (ROM BYTE *)"led3");
//		if(ptr)
//			LED3_IO = (*ptr == '1');
//
//		ptr = HTTPGetROMArg(curHTTP.data, (ROM BYTE *)"led2");
//		if(ptr)
//			LED2_IO = (*ptr == '1');
//
//		ptr = HTTPGetROMArg(curHTTP.data, (ROM BYTE *)"led1");
//		if(ptr)
//			LED1_IO = (*ptr == '1');
    }

    // If it's the LED updater file
    else if(!memcmppgm2ram(filename, "leds.cgi", 8))
    {
            // Determine which LED to toggle
            ptr = HTTPGetROMArg(curHTTP.data, (ROM BYTE *)"led");

//		// Toggle the specified LED
//		switch(*ptr) {
//			case '1':
//				LED1_IO ^= 1;
//				break;
//			case '2':
//				LED2_IO ^= 1;
//				break;
//			case '3':
//				LED3_IO ^= 1;
//				break;
//			case '4':
//				LED4_IO ^= 1;
//				break;
//			case '5':
//				LED5_IO ^= 1;
//				break;
//			case '6':
//				LED6_IO ^= 1;
//				break;
//			case '7':
//				LED7_IO ^= 1;
//				break;
//		}

    }

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


#if defined(STACK_USE_HTTP_APP_RECONFIG)
    if(!memcmppgm2ram(filename, "config.htm", 18))
            return HTTPPostConfig();
#endif

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
#if defined(STACK_USE_HTTP_APP_RECONFIG)
static HTTP_IO_RESULT HTTPPostConfig(void)
{
    APP_CONFIG newAppConfig;
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
            goto ConfigFailure;

    // Ensure that all data is waiting to be parsed.  If not, keep waiting for
    // all of it to arrive.
    if(TCPIsGetReady(sktHTTP) < curHTTP.byteCount)
            return HTTP_IO_NEED_DATA;


    // Use current config in non-volatile memory as defaults
    EROM_ReadBytes(ETH_EROM_BASE+1, sizeof(newAppConfig),(BYTE*)&newAppConfig);


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
                    goto ConfigFailure;

            // Read a form field value
            if(HTTPReadPostValue(curHTTP.data + 6, sizeof(curHTTP.data)-6-2) != HTTP_READ_OK)
                    goto ConfigFailure;

            // Parse the value that was read
            if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"ip"))
            {// Read new static IP Address
                    if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.MyIPAddr))
                            goto ConfigFailure;

                    newAppConfig.DefaultIPAddr.Val = newAppConfig.MyIPAddr.Val;
            }
            else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"gw"))
            {// Read new gateway address
                    if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.MyGateway))
                            goto ConfigFailure;
            }
            else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"sub"))
            {// Read new static subnet
                    if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.MyMask))
                            goto ConfigFailure;

                    newAppConfig.DefaultMask.Val = newAppConfig.MyMask.Val;
            }
            else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"dns1"))
            {// Read new primary DNS server
                    if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.PrimaryDNSServer))
                            goto ConfigFailure;
            }
            else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"dns2"))
            {// Read new secondary DNS server
                    if(!StringToIPAddress(curHTTP.data+6, &newAppConfig.SecondaryDNSServer))
                            goto ConfigFailure;
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
            else if(!strcmppgm2ram((char*)curHTTP.data, (ROM char*)"dhcp"))
            {// Read new DHCP Enabled flag
                    if(curHTTP.data[6] == '1')
                            newAppConfig.Flags.bIsDHCPEnabled = 1;
            }
    }


    // All parsing complete!  Save new settings and force a reboot
    SaveAppConfig(&newAppConfig);

    // Set the board to reboot and display reconnecting information
    strcpypgm2ram((char*)curHTTP.data, "/protect/reboot.htm?");
    memcpy((void*)(curHTTP.data+20), (void*)newAppConfig.NetBIOSName, 16);
    curHTTP.data[20+16] = 0x00;	// Force null termination
    for(i = 20; i < 20u+16u; i++)
    {
            if(curHTTP.data[i] == ' ')
                    curHTTP.data[i] = 0x00;
    }
    curHTTP.httpStatus = HTTP_REDIRECT;

    return HTTP_IO_DONE;


ConfigFailure:
    lastFailure = TRUE;
    strcpypgm2ram((char*)curHTTP.data, "/protect/config.htm");
    curHTTP.httpStatus = HTTP_REDIRECT;

    return HTTP_IO_DONE;
}


#endif	// #if defined(STACK_USE_HTTP_APP_RECONFIG)

/*****************************************************************************
  Function:
	static HTTP_IO_RESULT HTTPPostMD5(void)

  Summary:
	Processes the file upload form on upload.htm

  Description:
	This function demonstrates the processing of file uploads.  First, the
	function locates the file data, skipping over any headers that arrive.
	Second, it reads the file 64 bytes at a time and hashes that data.  Once
	all data has been received, the function calculates the MD5 sum and
	stores it in curHTTP.data.

	After the headers, the first line from the form will be the MIME 
	separator.  Following that is more headers about the file, which we 
	discard.  After another CRLFCRLF, the file data begins, and we read 
	it 16 bytes at a time and add that to the MD5 calculation.  The reading
	terminates when the separator string is encountered again on its own 
	line.  Notice that the actual file data is trashed in this process, 
	allowing us to accept files of arbitrary size, not limited by RAM.  
	Also notice that the data buffer is used as an arbitrary storage array 
	for the result.  The ~uploadedmd5~ callback reads this data later to 
	send back to the client.
	
  Precondition:
	None

  Parameters:
	None

  Return Values:
	HTTP_IO_DONE - all parameters have been processed
	HTTP_IO_WAITING - the function is pausing to continue later
	HTTP_IO_NEED_DATA - data needed by this function has not yet arrived
  ***************************************************************************/
#if defined(STACK_USE_HTTP_MD5_DEMO)
static HTTP_IO_RESULT HTTPPostMD5(void)
{
    WORD lenA, lenB;
    static HASH_SUM md5;			// Assume only one simultaneous MD5

    #define SM_MD5_READ_SEPARATOR	(0u)
    #define SM_MD5_SKIP_TO_DATA		(1u)
    #define SM_MD5_READ_DATA		(2u)
    #define SM_MD5_POST_COMPLETE	(3u)

    // Don't care about curHTTP.data at this point, so use that for buffer
    switch(curHTTP.smPost)
    {
            // Just started, so try to find the separator string
            case SM_MD5_READ_SEPARATOR:
                    // Reset the MD5 calculation
                    MD5Initialize(&md5);

                    // See if a CRLF is in the buffer
                    lenA = TCPFindROMArray(sktHTTP, (ROM BYTE*)"\r\n", 2, 0, FALSE);
                    if(lenA == 0xffff)
                    {//if not, ask for more data
                            return HTTP_IO_NEED_DATA;
                    }

                    // If so, figure out where the last byte of data is
                    // Data ends at CRLFseparator--CRLF, so 6+len bytes
                    curHTTP.byteCount -= lenA + 6;

                    // Read past the CRLF
                    curHTTP.byteCount -= TCPGetArray(sktHTTP, NULL, lenA+2);

                    // Save the next state (skip to CRLFCRLF)
                    curHTTP.smPost = SM_MD5_SKIP_TO_DATA;

                    // No break...continue reading the headers if possible

            // Skip the headers
            case SM_MD5_SKIP_TO_DATA:
                    // Look for the CRLFCRLF
                    lenA = TCPFindROMArray(sktHTTP, (ROM BYTE*)"\r\n\r\n", 4, 0, FALSE);

                    if(lenA != 0xffff)
                    {// Found it, so remove all data up to and including
                            lenA = TCPGetArray(sktHTTP, NULL, lenA+4);
                            curHTTP.byteCount -= lenA;
                            curHTTP.smPost = SM_MD5_READ_DATA;
                    }
                    else
                    {// Otherwise, remove as much as possible
                            lenA = TCPGetArray(sktHTTP, NULL, TCPIsGetReady(sktHTTP) - 4);
                            curHTTP.byteCount -= lenA;

                            // Return the need more data flag
                            return HTTP_IO_NEED_DATA;
                    }

                    // No break if we found the header terminator

            // Read and hash file data
            case SM_MD5_READ_DATA:
                    // Find out how many bytes are available to be read
                    lenA = TCPIsGetReady(sktHTTP);
                    if(lenA > curHTTP.byteCount)
                            lenA = curHTTP.byteCount;

                    while(lenA > 0u)
                    {// Add up to 64 bytes at a time to the sum
                            lenB = TCPGetArray(sktHTTP, curHTTP.data, (lenA < 64u)?lenA:64);
                            curHTTP.byteCount -= lenB;
                            lenA -= lenB;
                            MD5AddData(&md5, curHTTP.data, lenB);
                    }

                    // If we've read all the data
                    if(curHTTP.byteCount == 0u)
                    {// Calculate and copy result to curHTTP.data for printout
                            curHTTP.smPost = SM_MD5_POST_COMPLETE;
                            MD5Calculate(&md5, curHTTP.data);
                            return HTTP_IO_DONE;
                    }

                    // Ask for more data
                    return HTTP_IO_NEED_DATA;
    }

    return HTTP_IO_DONE;
}
#endif // #if defined(STACK_USE_HTTP_MD5_DEMO)

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

void HTTPPrint_hostname(void)
{
    TCPPutString(sktHTTP, AppConfig.NetBIOSName);
    return;
}

void HTTPPrint_config_dhcpchecked(void)
{
    if(AppConfig.Flags.bIsDHCPEnabled)
            TCPPutROMString(sktHTTP, (ROM BYTE*)"checked");
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

void HTTPPrint_motor_current(void)
{
    BYTE buf[7];

    MotorGetAmpsString(hMotorData, &buf[0]);

    TCPPutString(sktHTTP, buf);
}

void HTTPPrint_motor_railvoltage(void)
{
    BYTE buf[7];

    MotorGetAmpsString(hMotorData, &buf[0]);

    TCPPutString(sktHTTP, buf);
}

void HTTPPrint_motor_direction(void)
{
    if(hMotorData)
        TCPPut(sktHTTP, ((hMotorData->PresentDuty < 0) ? 'B':'F'));
    else
        TCPPut(sktHTTP, 'N');
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

#endif
