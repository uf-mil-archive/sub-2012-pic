/**************************************************************
 * HTTPPrint.h
 * Provides callback headers and resolution for user's custom
 * HTTP Application.
 * 
 * This file is automatically generated by the MPFS Utility
 * ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS GENERATOR
 **************************************************************/

#ifndef __HTTPPRINT_H
#define __HTTPPRINT_H

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_HTTP2_SERVER)

extern HTTP_STUB httpStubs[MAX_HTTP_CONNECTIONS];
extern BYTE curHTTPID;

void HTTPPrint(DWORD callbackID);
void HTTPPrint_config_ip(void);
void HTTPPrint_config_mac(void);
void HTTPPrint_config_subnet(void);
void HTTPPrint_config_gw(void);
void HTTPPrint_config_dns1(void);
void HTTPPrint_config_dns2(void);
void HTTPPrint_config_mtrType(WORD);
void HTTPPrint_config_cntType(WORD);
void HTTPPrint_fcurve(WORD);
void HTTPPrint_rcurve(WORD);
void HTTPPrint_maxvolt(void);
void HTTPPrint_minvolt(void);
void HTTPPrint_maxcur(void);
void HTTPPrint_maxslew(void);
void HTTPPrint_motor_manufacturer(void);
void HTTPPrint_motor_current(void);
void HTTPPrint_motor_railvoltage(void);
void HTTPPrint_motor_direction(void);
void HTTPPrint_version(void);
void HTTPPrint_builddate(void);
void HTTPPrint_task_stack(WORD);
void HTTPPrint_config_udpport(void);
void HTTPPrint_config_hostname(void);
void HTTPPrint_config_controlip(void);
void HTTPPrint_config_endian(WORD);
void HTTPPrint_reboot(void);
void HTTPPrint_rebootaddr(void);

void HTTPPrint(DWORD callbackID)
{
	switch(callbackID)
	{
        case 0x00000001:
			HTTPPrint_config_ip();
			break;
        case 0x00000003:
			HTTPPrint_config_mac();
			break;
        case 0x00000004:
			HTTPPrint_config_subnet();
			break;
        case 0x00000005:
			HTTPPrint_config_gw();
			break;
        case 0x00000006:
			HTTPPrint_config_dns1();
			break;
        case 0x00000007:
			HTTPPrint_config_dns2();
			break;
        case 0x00000008:
			HTTPPrint_config_mtrType(0);
			break;
        case 0x00000009:
			HTTPPrint_config_mtrType(4);
			break;
        case 0x0000000a:
			HTTPPrint_config_cntType(0);
			break;
        case 0x0000000b:
			HTTPPrint_config_cntType(2);
			break;
        case 0x0000000c:
			HTTPPrint_fcurve(5);
			break;
        case 0x0000000d:
			HTTPPrint_fcurve(4);
			break;
        case 0x0000000e:
			HTTPPrint_fcurve(3);
			break;
        case 0x0000000f:
			HTTPPrint_fcurve(2);
			break;
        case 0x00000010:
			HTTPPrint_fcurve(1);
			break;
        case 0x00000011:
			HTTPPrint_fcurve(0);
			break;
        case 0x00000012:
			HTTPPrint_rcurve(5);
			break;
        case 0x00000013:
			HTTPPrint_rcurve(4);
			break;
        case 0x00000014:
			HTTPPrint_rcurve(3);
			break;
        case 0x00000015:
			HTTPPrint_rcurve(2);
			break;
        case 0x00000016:
			HTTPPrint_rcurve(1);
			break;
        case 0x00000017:
			HTTPPrint_rcurve(0);
			break;
        case 0x00000018:
			HTTPPrint_maxvolt();
			break;
        case 0x00000019:
			HTTPPrint_minvolt();
			break;
        case 0x0000001a:
			HTTPPrint_maxcur();
			break;
        case 0x0000001b:
			HTTPPrint_maxslew();
			break;
        case 0x0000001c:
			HTTPPrint_motor_manufacturer();
			break;
        case 0x0000001d:
			HTTPPrint_motor_current();
			break;
        case 0x0000001e:
			HTTPPrint_motor_railvoltage();
			break;
        case 0x0000001f:
			HTTPPrint_motor_direction();
			break;
        case 0x00000020:
			HTTPPrint_version();
			break;
        case 0x00000021:
			HTTPPrint_builddate();
			break;
        case 0x00000022:
			HTTPPrint_task_stack(0);
			break;
        case 0x00000023:
			HTTPPrint_task_stack(1);
			break;
        case 0x00000024:
			HTTPPrint_task_stack(2);
			break;
        case 0x00000025:
			HTTPPrint_task_stack(3);
			break;
        case 0x00000027:
			HTTPPrint_config_udpport();
			break;
        case 0x00000028:
			HTTPPrint_config_hostname();
			break;
        case 0x00000029:
			HTTPPrint_config_controlip();
			break;
        case 0x0000002a:
			HTTPIncFile((ROM BYTE*)"header.inc");
			break;
        case 0x0000002c:
			HTTPIncFile((ROM BYTE*)"footer.inc");
			break;
        case 0x0000002d:
			HTTPPrint_config_endian(0);
			break;
        case 0x0000002e:
			HTTPPrint_config_endian(1);
			break;
        case 0x0000002f:
			HTTPPrint_reboot();
			break;
        case 0x00000030:
			HTTPPrint_rebootaddr();
			break;
		default:
			// Output notification for undefined values
			TCPPutROMArray(sktHTTP, (ROM BYTE*)"!DEF", 4);
	}

	return;
}

void HTTPPrint_(void)
{
	TCPPut(sktHTTP, '~');
	return;
}

#endif

#endif