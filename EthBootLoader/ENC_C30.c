//////////////////////////////////////////////////////////////////////////
//	Main File for the Ethernet Bootloader
//	MCHP C30 Specific file for the PIC24/dsPIC series
//	Loads an encrypted image into the PIC via the Ethernet Interface	
//	Uses Microchip ENC28J60 Ethernet controller
//
//		Copyright (c) 2006 - 2010, Andrew Smallridge
//
// 	Revision History
//		16/11/10 MACFlush() work around added for ENC28J60 R6 silicon bug
//		04/03/10 Bug Fix - PGM_Write 
//		06/07/09 Added State.RstVector setting in NewCode()
//		21/03/08 init_pic modified to support selectively init ports A to C
//				 generate_MAC modified to support PICs with less than 6 timers
//				 fixed missing data from 0x0004 to 0x0007 on initial
//				 data record when record also contains rest vector
//		30/11/08 ported from SD_24F_NO_XEE and EBLPX bootloaders
///////////////////////////////////////////////////////////////////////////
// Customizing the Bootloader
// Define target hardware platform in the platform.h file
//
// When defining a new processor the processor must be selected in the IDE
// Under Configure / Select Device
// The appropriate linker script, modified for the bootloader,
// and appropriate processor must replace the previous linker script in the project
// Sample linker scripts are included with the bootloader package
//
//  Project File Information:
//    EBLE_C30.c	ENJ28J60 Ethernet bootloader main module
//    platform.h	Hardware platform specific configuration and debug settings
//	  system.h		bootloader and hardware platform specific configuration	
//	  DataTypes.h	data types used by the bootloader
//    ip.h			IP header definitions
//    enc28j60.h	ENC28J60 MAC driver
//	  p24FJ128GA010_ENC_LDR.gld  customized processor specific linker file
//	  p24FJ256GA108_ENC_LDR.gld  customized processor specific linker file
//	  p24HJ256GA610_ENC_LDR.gld  customized processor specific linker file
//	  p33FJ256GP710_ENC_LDR.gld  customized processor specific linker file
//
// The user's application must be compiled with a linker that reserves
// the program memory uesd by the bootloader. Sample application scripts
// are supplied with the bootloader sofware package
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// 	Key Peripheral Usage
// 	Timer 1		Used for the general purpose 1ms system timer
// 	Timer 2		1ms clock for bootloader wait for capture timeout
// 	USARTx		Serial interface used for debugging
// 	SPI			SPI Mode: ENC28J60 Ethernet controller
//
// Timer 1 
//		General purpose 1ms system timer
// 		A 100ms system clock, TMR_100ms, is derived from the 1ms tick.
//
//  	Variable Timers TMR_Short and TMR_Long are derived from Timer 0 
// 		and are avaiable for application specific timer functions. Each
// 		count value corresponding to 1ms. These timers are implemented
// 		as countdown timers.
// 		TMR_Short (8 bit) provides rollover in the range of 1 to 256ms (+1ms to -0ms)
// 		TMR_Long (16 bit) provides rollover in the range of 1 to 65536ms (+1ms to -0ms)
//
// Timer 2
//		Used for the interrupt driven software RTC fuction.
//		Timer 2 causes an interrupt every 1ms. The interrupt handler is used to derive
//		rtc.hour (0 to 23), rtc.min(0 to 59), rtc.sec(0 to 59), rtc.ms100(0 to 9) and
//		rtc.DOY (0 to 366), rtc.year
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// Set debug options
// 					**** CAUTION **** 
// if enabling debug directives then compile with the linker scripts
// that allocate additional memory for the bootloader.
// See: p33FJ256GP710_ENC_LDR_debug.gld
// 					**** CAUTION **** 
///////////////////////////////////////////////////////////////////////////
//#define ldr_debug
//#define debug_cipher			// debug_cipher requires ldr_debug
//#define debug_config			// displays IP and MAC address

////////////////////////////////////////////////////////////////////////////
//	Define Cypher/Decypher Constants
////////////////////////////////////////////////////////////////////////////
#define XTEA_KEY "BrushElectronics"  		// must be exactly 16 bytes long
#define XTEA_ITERATIONS (WORD)16			// number of decipher iterations
#define XTEA_DATA_LEN_ASCII 48				// fixed length record size (ASCII)
#define XTEA_DATA_LEN XTEA_DATA_LEN_ASCII/2	// hex record length
#define XTEA_DELTA 0x9E3779B9

///////////////////////////////////////////////////////////////////////////
//	A BRIEF OVERVIEW OF ETHERNET MAC Addresses 
//	The Media Access Control (MAC) addresses is used by a Network
//	Interface Card (NIC) to identify packets to be accepted 
//	"off the wire" by the NIC.
//
//	Originally MAC addresses needed to be globally unique. Early 
//	protocols did not have a network layer address and the MAC 
//	address was the mechanism used to forward or filter packets.
//	Current networking technology uses a network layer address, 
//	typically IP, for this function.
//
//	The Network Layer Protocols use an Address Resolution Protocols
//	to resolve a network layer address to the corresponding target 
//	MAC address. IP uses ARP for this function.
//
//	Today, in theory, MAC addresses only need to be unique within 
//	a subnet. This is because when a packet is forwarded between 
//	subnets (routed), and therefore across a router boundary, the
//	forwarding router substitutes its MAC address for the original
//	MAC address. In fact, for most implementations, it is not
//	necessary for a MAC address to be unique within a subnet. This 
//	is because the host stack will typically examine the network 
//	layer address (such as the IP address) to internally route and
//	process a packet. If the IP address of a packet does not match
//	one of the hosts "interesting packet" addresses the the packet
//	is discarded.
//
//	A unique MAC address is generated the first time the loader is run
//	The MAC address comprises three bytes of Organisational Unique 
//	Identifier (aka OUI) and three bytes typically used to uniquely
//	identify the specific device.
//
//	The BUSY LED toggles periodically while in bootloader mode
//	The Status LED "flashes" whenever an incoming packet has
//	been processed
//
//	Define Ethernet OUI of MAC address
//	Used for the generation of the "first run" MAC address
//	The following three OUI equates define the three byte
//	Organizational Unique Identifier being the first three
//	bytes of a six byte MAC address
///////////////////////////////////////////////////////////////////////////
#define OUI_1	0x10 
#define OUI_2	0x00
#define OUI_3	0x00


///////////////////////////////////////////////////////////////////////////
//	Setup the platform and processor specific configuration bits
///////////////////////////////////////////////////////////////////////////
#if defined(__PIC24F__)	
	#include <p24Fxxxx.h>
#elif defined(__PIC24H__)
	#include <p24Hxxxx.h>
#elif defined (__dsPIC33F__)
	#include <p33Fxxxx.h>
#else
	#error system.h: unknown PIC family
#endif

#define __ICD2RAM

#include "DataTypes.h"
#include "platform.h"

///////////////////////////////////////////////////////////////////////////
// 	Setup configuration bits
///////////////////////////////////////////////////////////////////////////
#if defined BDCMC
	// Configuration Bits
	_FOSCSEL(IESO_OFF & FNOSC_FRC)
	_FOSC(FCKSM_CSECMD & OSCIOFNC_OFF & POSCMD_EC)
	_FWDT(FWDTEN_OFF)
	_FICD(ICS_PGD3 & JTAGEN_OFF)
	_FPOR(PWMPIN_ON & HPOL_ON & LPOL_ON & ALTI2C_OFF) 
#else
	#error Main.c missing config fuses
#endif

#ifdef USE_CLOCK_INIT
	static void clockInit(void);
#endif

///////////////////////////////////////////////////////////////////////////
//	Standard Header File Includes
///////////////////////////////////////////////////////////////////////////
#include <libpic30.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include "ENC28J60.h"
#include "ip.h"

////////////////////////////////////////////////////////////
// 		Setup the User's Application Jump Vector Table
///////////////////////////////////////////////////////////////////////////
BYTE MAC[] __attribute__((space(prog))) __attribute__ ((address(P_MAC))) = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
IP_ADDR Def_IP __attribute__ ((space(prog))) __attribute__ ((address(P_Def_IP))) = {192,168,2,200};


///////////////////////////////////////////////////////////////////////////
// Shadow RAM Area used to build the page contents to be written to program
// memory. The Shadow block is the size of the PICs Erase block size
///////////////////////////////////////////////////////////////////////////
BYTE Shadow[PIC_ERASE_SIZE * PIC_INSTR_SIZE];
BYTE ShadowPage;
WORD ShadowBaseAddr;
BOOLEAN ShadowDirty;


// define the UDP port used for receiving control messages
#define CONTROL_PORT 0x4004	// control port number for encrypted bootloader

// define timer constants for LED illumination
#define C_TMR0_1ms	256 - (SYSCLK/(64*2*1000))
#define CTMR_Activity 1

#define LOW(a) 					(a & 0x00FF)
#define HIGH(a) 				((a>>8) & 0x00FF)

#define restart_wdt() __asm__ volatile("CLRWDT")


	// The Reference platform uses three LEDs to show current activity
	// The Status LED flashes continuously indicating the LIA is servicing the mainline
	// The Health LED flashes when a packet, destined for the LIA, has been processed
	// The Busy LED flashes when a packet is queue for transmission to the Ethernet controller
	// Timer 1 is the base timer controlling the LED flash rate
#define CStatusLEDCount		255	// number of 1ms timer 1 rollovers to toggle the Status LED
BYTE StatusLEDCount;			// used for toggling the Status LED in the mainline
#define CHealthLEDCount		100	// number of 1ms timer 1 rollovers to toggle the Status LED
BYTE HealthLEDCount;			// used for toggling the Health LED in the mainline
#define CBusyLEDCount		100	// number of 1ms timer 1 rollovers to toggle the Status LED
BYTE BusyLEDCount;				// used for toggling the Busy LED in the mainline

MAC_ADDR LIA_MAC;		// Ethernet Controller MAC address
MAC_ADDR SA_MAC;		// Source MAC address
IP_ADDR SA_IP;			// Source IP address
WORD SA_UDP;			// Source Data port (data) address
IP_ADDR LIA_IP;			// LIA's IP address

IP_ADDR LIA_MIP = {230,10,10,11};	// LIA's Multicast IP address
MAC_ADDR Broadcast_MAC = {0xff,0xff,0xff,0xff,0xff,0xff};

// Internal MAC level variables and flags 
WORD NextPacketLocation;
BOOLEAN WasDiscarded;


	// timer control flags and counters
BYTE	TMR_Short;		// Short Timer Counter - used for general purpose timing functions with TMR0 interrupts
long	TMR_Long;		// Long Timer Counter - used for general purpose timing functions with TMR0 interrupts
BYTE	TMR_100ms;		// 100ms timer counter
volatile BYTE	TMR_Activity;	// LED flash timer for activity - number of 100ms increments
short	TF_Short;		// short timer done flag in TMRStat
short	TF_Long;		// long timer done flag in TMRStat
short	TF_100ms;		// 100ms timer done flag in TMRStat


typedef struct _HEX_RCD 
	{
	BYTE len;
	BYTE addrHi;
	BYTE addrLo;
	BYTE type;
	BYTE data[16];
	BYTE crc;
	} HEX_RCD;


union 
	{
	WORD All;
	struct 
		{
		unsigned Type_Err:1;	// Unsupported Record Type
		unsigned Ldr_FErr:1;	// Record Framing Error 
		unsigned MCastPkt:1;	// indicates processing Multicast IP packet
		unsigned LdrLenErr:1;	// new code frame length error
		unsigned Ldr_Err:1;		// indicates a LDR_Command received while not in LDR_Mode
		unsigned No_Code:1;		// User Code space in invalid
		unsigned LDR_Mode:1;	// Loader Mode set via Control Port
		unsigned RstVector:1;	// Set indicates a reset vector is required
		unsigned Rd_Done:1;		// Dump Command Complete
		unsigned T4_Error:1;	// Missing Type 4 record
		unsigned WR_EEPROM:1;	// Written to EEPROM
		unsigned PrgDone:1;		// programming complete
		unsigned PrgRcdDn:1;	// Finished programing current record
		unsigned HiAddrErr:1;	// Address Error - attempt to overwrite loader
		unsigned ChkSumErr:1;	// Record checksum Error
		unsigned ID_Rcd:1; 		// ID and Configuration bits record skipped
		};
	} State;

union
	{
	BYTE All;
	struct
		{
		unsigned Dummy:4;
		unsigned Res:1;
		unsigned Cfg:1;
		unsigned EE:1;
		unsigned PGM:1;
		};
	}T4_Status;

#define T4_PGM  T4_Status.PGM
#define T4_EE   T4_Status.EE
#define T4_Cfg  T4_Status.Cfg
#define T4_Res  T4_Status.Res
#define T4_Mode T4_Status.All
///////////////////////////////////////////////////////////////////////////
//	 	BOOTLOADER APPLICATION EQUATES
///////////////////////////////////////////////////////////////////////////
#define Ldr_Cmd_Delay	5000	// number of ms delay to wait for Loader Command
#define dump_pkt_dly	3		// number of mS delay between dump packets
#define RVecLen			8		// byte length of RESET vector block
#define StatusTmrCnt	8		// Status LED flash rate counter (number of TMR3 rollovers)
#define BusyHoldCnt		5		// Busy LED ON hold count
#define HealthHoldCnt	5		// Health LED ON hold count

	// define the size of the Ethernet packet structures
#define CP_payload_len	19		// control packet fixed payload length
#define IP_Hdr_Len		20 
#define UDP_Hdr_Len		8
#define MAC_Hdr_Len		14
#define LIA_ID_Len		2


  // Define Bootloader Control Port Commands
#define CP_Status		0		// Show Status
#define CP_SetIP		1		// Set IP address
#define CP_Invalidate	2		// Invalidate User Program Area
#define CP_LDR_Mode		3		// Put LIA into Loader State
#define CP_New_Code		4		// New code to store
#define CP_Dump			5		// Dump user memory and EEPROM
#define CP_Erase		6		// Erase Program and EEPROM memory
#define CP_Erase_PGM	7		// Erase Program and EEPROM memory
#define CP_Erase_EE		8		// Erase Program and EEPROM memory
#define CP_Reset		9		// Reboot the LIA



WORD	LIA_CP;				// LIA's control port (destination LIA management)
BYTE	Data_Seq;			// LIA Data Channel Sequence Number LIA -> Host
WORD LIA_ID;				// LIA ID
IP_ADDR SA_IP; 				// Source IP address
MAC_ADDR SA_MAC;			// Source MAC address (@@@ to be removed @@@)
IP_ADDR DA_IP; 				// Destination IP address

BYTE Source; 				// Used for block transfers and compares
BYTE Target; 				// Used for block transfers and compares
BYTE Count; 				// Used for counting loops, block transfers and compares
BYTE Blk_temp; 				// Tempory variable used exclusively by block routines  
BYTE StatusTmr; 			// used for periodic health check
BYTE BusyHold; 				// used for controlling minimum ON time of BUSY LED
BYTE HealthHold; 			// used for controlling minimum ON time of Health LED

	// Ethernet Controller Transmit frame management variables
WORD PktLen; 				// Ethernet packet length
WORD NxtPktOffset;			// Next Rx Frame Pointer
WORD Next; 					// Variable added for MACDiscardRX work around for Errata Rev B4

	// IP RX Header Variables
BYTE IP_PDU_Ptr; 			// pointer to the IP PDU in the MCP frame
BYTE IP_HdrLen; 			// IP header length
BYTE IP_OptLen;				// IP options length

BYTE IP_Protocol;			// IP protocol number
WORD IP_Chksum; 			// IP checksum
WORD ICMP_seq;				// ICMP Sequence number
WORD ICMP_ID;				// ICMP Identifier
WORD IP_SP; 				// Source Port - used for UDP and TCP
WORD IP_DP;					// Destination Port - used for UDP and TCP
WORD CP_Seq; 				// Command Port Sequence number
BYTE CP_Cmd;				// Control Port Command
WORD Ldr_Dly;				// Loader Delay Counter
BYTE LastTPU;				// Used to track increase in TBLPTRU
BYTE FaddrU;				// flash program memory address upper byte
BYTE FaddrH;				// flash program memory address high byte
BYTE FaddrL;				// flash program memory address low byte
BYTE NumBytes;				// number of words in line of hex file
BYTE checksum;				// byte to hold checksum of incoming data
BYTE Counter;				// to count words being saved or programmed
BYTE HexByte;				// byte from 2 incoming ascii characters
BYTE CP_VarLen;				// control packet variable length portion

DWORD_VAL AbsAddr;			// absolute address built from type 0 and data records

MAC_ADDR Host_MAC; 			// Controlling Host's MAC address 
IP_ADDR Host_IP;			// Controlling Host's IP address
WORD Host_CP;				// Controlling Host's control port
BYTE EECntr;				// Counter used in EEPROM processing
BYTE DataLo; 				// Used for quick programming


BOOLEAN WasDiscarded = FALSE;	// Rx Packet Processed Flag
BOOLEAN ShadowDirty = FALSE;	// Shadow Ram to be written to program memory

struct 
	{
	BYTE Base; 				// Base of the RX buffer - : start of record character
	WORD Len;
	WORD AddrH;
	WORD AddrL;
	WORD RType;
	char UR_Data[32];
	WORD ChkMax;
	} UR; // RX buffer


struct
	{
	// Frame buffer - labels wrt received packet structures
	WORD MCP_NPP;			// MCP Preamble Next Packet Pointer
	long MCP_Status;		// MCP RXSTATUS

	// Ethernet Header Base
	MAC_ADDR FMAC_DA; 		// MAC - Ethernet Destination Address
	MAC_ADDR FMAC_SA;		// MAC - Ethernet Source Address
	WORD FMAC_Type;			// MAC - Type / Length

	// Base of MAC PDU
	BYTE FIP_VerF;			// IP Version and Flags
	BYTE FIP_TOS;			// IP Type of Service / IP PRE field
	WORD FIP_Length;		// IP Length
	WORD FIP_ID;			// IP ID field
	WORD FIP_Frag;			// IP Flags / Fragment fields
	BYTE FIP_TTL;			// IP TTL field
	BYTE FIP_Protocol;		// IP Protocol field
	WORD FIP_Checksum;		// IP Header Checksum
	IP_ADDR FIP_SourceIPAddr;	// IP Source Address
	IP_ADDR FIP_DestIPAddr;	// IP Source Address
	
	// End of normal IP HEader
	char FIP_PDU[216];		// payload
	} PDU;



///////////////////////////////////////////////////////////////////////////
//		Local Functions
///////////////////////////////////////////////////////////////////////////
void display_buffer(DWORD offset, DWORD size, BYTE* ptr);
void MirrorBlock (BYTE Page, WORD Addr);
void EraseBlock(BYTE Page, WORD Addr);
void WriteBlock(BYTE Page, WORD Addr);
void ServiceSystemTimer(void);
#define BCD2Bin(x) ((x >> 4 * 10) + (x & 0x0f))

	// function prototypes
void serial_isr(void);
void init_ENC(BYTE *Address);
WORD MACCalcTxChecksum(WORD base, WORD len);
void PutTxChecksum(WORD Base, WORD Len, WORD Checksum_Offset);
void PutUDP(MAC_ADDR *Target_MAC, IP_ADDR *Target_IP, WORD *Source_Port, WORD *Target_Port, WORD Mesg_Len, BYTE *Mesg);
char getc_QConsole(void);
void SelectENC(void);
void ENC_SPI_write(char data);
BOOLEAN DoControl(UDP_HEADER* UDP_Hdr, IP_ADDR* RemoteIP, MAC_ADDR* RemoteMAC);


BYTE blank[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}; 
unsigned char __attribute__((aligned (4))) key[] = XTEA_KEY;	// XTEA cipher key


IP_ADDR MIP = {230, 10, 10, 11};	// LIA Multicast address
WORD MDef_CP = 0x4000;				// LIA RX target port for control

BYTE ProductID = 0x10;		// Device ID
BYTE HWver = 0x10;			// Hardware Version - Major / Minor 4 bits each
BYTE SWver = 0x10;			// Software Version - Major / Minor 4 bits each



void init_CONSOLE(void)
///////////////////////////////////////////////////////////////////////////
// void init_CONSOLE(void)
//
// Initialize Serial Console Port
///////////////////////////////////////////////////////////////////////////
	{
	CONSOLE_BRG = CONSOLE_REG;
	CONSOLE_MODE = 0x0008;
	CONSOLE_STA = 0;
	CONSOLE_UARTEN = 1;
	CONSOLE_TXEN = 1;

  	// reset RX flag
 	CONSOLE_RXIF = 0;
	}

void delay_ms(WORD milliseconds)
	{
	while (milliseconds--)
		__delay32(FCY/1000);
	}

void delay_us(WORD microseconds)
	{
	while (microseconds--)
		__delay32(FCY/1000000);
	}



void decipher(WORD iterations, DWORD* v, DWORD* k)
////////////////////////////////////////////////////////////////////////////
// void decipher(WORD iterations, DWORD* v, DWORD* k)
//
//   decipher (XTEA - eXtended Tiny Encryption Algorithm)
//   The coded cipher text is in v[0] and v[1].
//   The 16 byte cypher key is in key
//   The number of encoding cycles is given by iterations
////////////////////////////////////////////////////////////////////////////
	{
	DWORD v0=v[0], v1=v[1], vx, vy, vz, vxx, vyy, vzz;
	WORD i;
    DWORD delta=0x9E3779B9, sum=delta*iterations;

	
	#ifdef ldr_debug
		#ifdef debug_cipher
			printf("v0 =%08lX, v1=%08lX, key[0]=%08X, key[1]=%08X, key[3]=%08X, key[4]=%08X\r\n",v0, v1, key[0],key[1],key[2],key[3]);
		#endif
	#endif

    for(i=iterations; i; i--) 
		{
		vx = v0 << 4;
		vy = (v0 >> 5);
		vz = sum + k[(sum>>11) & 3];
        v1 -= ((vx ^ vy) + v0) ^ vz;

		#ifdef ldr_debug
			#ifdef debug_cipher
				printf("Pass A: cnt=%02X   sum=%08X   vx =%08X   vy =%08X   vz =%08X   v1=%08X\r\n", i,sum,vx,vy,vz, v1);
			#endif
		#endif

        sum -= delta;

		vxx = v1 << 4;
		vyy = v1 >> 5;
		vzz = sum + k[sum & 3];

        v0 -= ((vxx ^ vyy) + v1) ^ vzz;

		#ifdef ldr_debug
			#ifdef debug_cipher
				printf("Pass B: cnt=%02X   sum=%08X   vxx=%08X   vyy=%08X   vzz=%08X   v0=%08X\r\n", i,sum,vxx,vyy,vzz, v0);
			#endif
		#endif
    	}
    v[0]=v0; v[1]=v1;

	#ifdef ldr_debug
		#ifdef debug_cipher
			printf("post processing %08X%08X\r\n\r\n",v0,v1);
		#endif
	#endif
	}




 void PGM_write(DWORD_VAL Addr, char* data, BYTE len)
///////////////////////////////////////////////////////////////////////////
// void PGM_write(DWORD Addr, char* data, BYTE len)
//
//	Write the program data record to the shadow memory block. If necessary,
//	flush the shadow block to the PIC and reload the shadow block
//
//	If the target address is the reset vector then relocate the vector
//	to the User Parameter block
//
//	Entry
//		Addr		Absolute byte address in PGM memory for this record
//		data		Pointer to the data to be written to program memory
//		len			Number of bytes to be written
//
//	Exit
//		ShadowPage		updated
//		ShadowBaseAddr	updated
//		ShadowDirty		updated
//		State			flags updated
//
//	Revision History
//		20/03/09	Fixed reset vector process to correctly
//					Process reset vector record also containing data
///////////////////////////////////////////////////////////////////////////
	{
	DWORD_VAL dwv;
	WORD w;
	WORD MaxOffset;			// maximum offset value for the shadow block

	#ifdef DEBUG_PGM_write
		printf("PGM_write: Addr = %08lX\r\n",Addr);
	#endif

	// convert byte address to word address
	dwv.Val = Addr.Val >> 1;

	// make sure the record update is in the User Program Space Area
	if (((dwv.Val >= BOOTLOADER_BASE) && (dwv.Val <= BOOTLOADER_END)) || ((dwv.Val >= PARAM_BASE) && (dwv.Val <= PARAM_END)))
		{
		State.HiAddrErr = 1;
		return;
		}

	// ignore records attempting to write to config registers
	if (dwv.Val >= CONFIG_BASE)
		{
		return;
		}

	// see if the current shadow page is the same page as required for the new record
	// bug fix 04/03/10
	if (((dwv.byte.UB != ShadowPage) || ((dwv.word.LW - (dwv.word.LW % (PIC_ERASE_SIZE * 2))) != ShadowBaseAddr)))// && ShadowDirty)
		{
		// different page, flush the existing shadow block to the PIC
		if (ShadowDirty)
			WriteBlock(ShadowPage, ShadowBaseAddr);	

		// load the new page
		#ifdef DEBUG_PGM_write
			printf("PGM_write: UB= %02X,  LW= %04X\r\n",dwv.byte.UB, dwv.word.LW);
		#endif
		MirrorBlock(dwv.byte.UB, dwv.word.LW);
		}

	// determine if this is the reset vector record
	// if so then Mirror the block containing the user's reset vector
	if (dwv.Val < ResetVectorEnd)
		{
		#ifdef DEBUG_PGM_write
			printf("PGM_write: Reset Vector UB= %02X,  LW= %04X\r\n",dwv.byte.UB, dwv.word.LW);
		#endif
		// Mirror the parameter block containing the user's reset vector
		MirrorBlock((UserJump >> 16),UserJump);

		// set w to point to the relevant offset in the shadow memory
		w = ((UserJump & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);

		// set the maximum allowable address in the parameter block
		// for the reset vector record
		MaxOffset = w + 8;
		}
	else
		{
		w = 0;
		MaxOffset = PIC_ERASE_SIZE * PIC_INSTR_SIZE;
		}

	// here we have the correct page loaded into the shadow block
	// calculate the starting offset in the shadow block for this record
	w += (Addr.word.LW % (PIC_ERASE_SIZE * PIC_INSTR_SIZE));

	// update the shadow block from the data record
	do
		{
		if (Shadow[w] != *data)
			{
			Shadow[w] = *data;
			ShadowDirty = TRUE;		// flag the shadow block contents have changed
			}
		w++;
		data++;
		len--;

		// update target byte address in program memory
		Addr.Val++;
		if (len && (w >= MaxOffset))
			{
			// process the rollover of the target page
			if (dwv.Val < ResetVectorEnd)
				w = 8;
			else
				w = 0;
			MaxOffset = PIC_ERASE_SIZE * PIC_INSTR_SIZE;
			WriteBlock(ShadowPage, ShadowBaseAddr);	

			// convert byte address to word address
			dwv.Val = Addr.Val >> 1;
			MirrorBlock(dwv.byte.UB, dwv.word.LW);			
			}

		} while (len && (((Addr.Val >> 1) < BOOTLOADER_BASE) || (((Addr.Val >> 1) > PARAM_END) && ((Addr.Val >> 1) < CONFIG_BASE))));

	// update the state information indication the record has been processed
	State.PrgRcdDn = 1;
	}


BOOLEAN UserVectorPresent(void)
///////////////////////////////////////////////////////////////////////////
// BOOLEAN UserVectPresent(void)
//
//	Tests the User's Reset Vector
//
//	Exit
//  	Returns TRUE if the user vector is present, false otherwise
///////////////////////////////////////////////////////////////////////////
	{
	TBLPAG = (UserJump >> 16) & 0xff;
	return(__builtin_tblrdl(UserJump & 0xffff) != 0xffff);
	}


BOOLEAN CodeStateValid(void)
///////////////////////////////////////////////////////////////////////////
// BOOLEAN CodeStateValid(void)
//
//	Returns the CodeState Status. A CodeState parameter value of 0xFFFF
//	in program memory indicates that no valid user code is present.
//	The CodeState parameter is set to 0xFFFF during the bootloader process
//	If the ERASE option is set in the PGM section of the config file on the
//	media.
//
//	The CodeState parameter is set to 0 when a user reset vector is present
//	and an Intel Type 9 EOF hex record has been processed during the user
//	program memory bootload process
//
//	Exit
//  	Returns TRUE if User Code space is valid (not 0xFFFF)
///////////////////////////////////////////////////////////////////////////
	{
	TBLPAG = (CodeState >> 16) & 0xff;
	return(__builtin_tblrdl(CodeState & 0xffff) != 0xffff);
	}




#ifdef DEBUG_PGM_PIC
	void ShowPgmMemory(BYTE Page, WORD Addr, WORD len)
	///////////////////////////////////////////////////////////////////////////
	// void ShowPgmMemory(BYTE Page, WORD Addr, WORD len)
	//
	// Displays the contents of program memory
	//
	// Developed for the PIC24F 16 bit family with 24bit instruction width
	// Mirrors the instruction in two WORDS with the most significant byte
	// (the phantom byte) set to zero
	//
	// Entry
	//		Page			points to the page in Program Memory containing
	//						the region to be displayed
	//		Addr			Address of the region in program memory to be displayed
	//		len				number of DWORDS to be displayed
	//
	// Exit
	//		ShadowDirty		cleared
	///////////////////////////////////////////////////////////////////////////
		{
		// point to the page in program memory to be displayed
		TBLPAG = Page;
	
		#ifdef DEBUG_PGM_PIC
			printf("ShowPgmMemory\r\n");
		#endif
	
		while(len--)
			{
			printf("%02X%04X: %02X %02X %02X %02X\r\n",Page, Addr, (BYTE)(__builtin_tblrdh(Addr) >> 8), (BYTE)__builtin_tblrdh(Addr),(BYTE)(__builtin_tblrdl(Addr) >> 8), (BYTE)__builtin_tblrdl(Addr));
			Addr+=2;
			}
		}
#endif




void MirrorBlock (BYTE Page, WORD Addr)
///////////////////////////////////////////////////////////////////////////
// void MirrorBlock (BYTE Page, WORD Addr)
//
// Mirrors the contents of the program memory to the Shadow RAM
// The PIC24F
//
// Developed for the PIC24F 16 bit family with 24bit instruction width
// Mirrors the instruction in two WORDS with the most significant byte
// (the phantom byte) set to zero
//
// Entry
//		Page			points to the page in Program Memory containing
//						the region to be updated
//		Addr			Address of the region in program memory to be updated
//
// Exit
//		ShadowDirty		cleared
///////////////////////////////////////////////////////////////////////////
	{
	WORD BaseAddr, offset, w;

	// point to the page in program memory to be copied to the shadow area
	TBLPAG = Page;

	offset = Addr % (PIC_ERASE_SIZE * 2);
	BaseAddr = Addr - offset;

	// setup up the Shadow block pointers identifying the page
	// in program memory that is being mirrored
	ShadowPage = Page;
	ShadowBaseAddr = BaseAddr;

	// indictate the contents of the shadow block have not been changed
	ShadowDirty = FALSE;

	#ifdef DEBUG_SHADOW
		printf("MirrorBlock: Address = %04X, Page = %02X, Offset = %04X, BaseAddr = %04X\r\n",Addr, TBLPAG, offset, BaseAddr);
	#endif

	for (w = 0; w < (PIC_ERASE_SIZE*PIC_INSTR_SIZE);)
		{
		Shadow[w++] = __builtin_tblrdl(BaseAddr);
		Shadow[w++] = __builtin_tblrdl(BaseAddr) >> 8;
		Shadow[w++] = __builtin_tblrdh(BaseAddr);
		Shadow[w++] = 0;
		BaseAddr+=2;
		}
	}



void EraseBlock(BYTE Page, WORD Addr)
///////////////////////////////////////////////////////////////////////////
// void EraseBlock(BYTE Page, WORD Addr)
//
// Erases the selected ERASE PAGE in Program Memory Space
//
// Entry
//		Page			points to the page in Program Memory containing
//						the region to be updated
//		Addr			Address of the region in program memory to be erased
///////////////////////////////////////////////////////////////////////////
	{
	// point to the page in program memory to be copied to the shaddow area
	TBLPAG = Page;

	#ifdef DEBUG_ERASE
		printf("EraseBlock:  Address = %04X, Page = %02X\r\n",Addr, TBLPAG);
	#endif

	// prepare NVMCON to perform page erase
	NVMCON = PIC_PAGE_ERASE;

	__builtin_tblwtl(Addr, Addr);
	__builtin_write_NVM();
	while(NVMCONbits.WR == 1)
		;
	}



void WriteBlock(BYTE Page, WORD Addr)
///////////////////////////////////////////////////////////////////////////
// void WriteBlock(BYTE Page, WORD Addr)
//
// Writes the contents of the Shadow RAM to the Program Memory Space
//
// Developed for the PIC24F 16 bit family with 24bit instruction width
// Ignores the phantom byte
//
// Entry
//		Page			points to the page in Program Memory containing
//						the region to be updated
//		Addr			Address of the region in program memory to be updated
//		
// Exit
//		EraseBlock		The selected page is erased before writing the block
//		ShadowDirty		cleared
///////////////////////////////////////////////////////////////////////////
	{
	WORD BaseAddr, offset, w,x,y;

	EraseBlock(Page, Addr);

	// point to the page in program memory to be copied to the shadow area
	TBLPAG = Page;

	offset = Addr % (PIC_ERASE_SIZE * 2);
	BaseAddr = Addr - offset;

	#ifdef DEBUG_WRITE
		printf("WriteBlock:  Address = %04X, Page = %02X, Offset = %04X, BaseAddr = %04X\r\n",Addr, TBLPAG, offset, BaseAddr);
	#endif

	// write out each row to the program memory
	offset = 0;
	Addr = BaseAddr;
	for (w = 0; w < PIC_WRITE_ROWS; w++)
		{
		for (x = 0; x < PIC_WRITE_SIZE; x++)
			{
			y = (WORD) Shadow[offset++];
			y |= (Shadow[offset++] << 8);
			__builtin_tblwtl(Addr,y);
			__builtin_tblwth(Addr,Shadow[offset++]);
			offset++;
			Addr+=2;
			}

		// issue the write row command
		NVMCON = PIC_ROW_WRITE;
		__builtin_write_NVM();
		while(NVMCONbits.WR == 1)
			;
		}

	// clear the shadow dirty flag
	ShadowDirty = FALSE;
	}



void PGM_Erase(void)
///////////////////////////////////////////////////////////////////////////
// void PGM_Erase(void)
//
// Low Memory Bootloader Version
// Erases the contents of the User Program Memory
// This function also erases the User Application's relocated reset vector
// and the CodeState flag
//
// Exit:
//		User Application's Program space is erased
//		UserJump	erased -
//		CodeState	erased (indicates absense of valid user code)
//		P_MAC		set to the current LIA_MAC MAC address
//		P_Def_IP	set to the current LIA_IP IP address
///////////////////////////////////////////////////////////////////////////
	{
	// here we need to initialize the user program space configuration block
	WORD offset;
	DWORD Addr;

	#ifdef LED_PIC_PGM
		LED_PIC_PGM = 1;
	#endif


//	for (Addr = BOOTLOADER_END + 1; Addr < (CONFIG_BASE - (CONFIG_BASE % (PIC_ERASE_SIZE * 2)) - (PIC_ERASE_SIZE * 2));)
	for (Addr = (BOOTLOADER_END + PIC_ERASE_SIZE) - (BOOTLOADER_END % PIC_ERASE_SIZE); Addr < (CONFIG_BASE - (CONFIG_BASE % (PIC_ERASE_SIZE * 2)) - (PIC_ERASE_SIZE * 2));)
		{
		ServiceSystemTimer();
		EraseBlock ((Addr >> 16 & 0xff), (WORD) Addr);
		Addr += (PIC_ERASE_SIZE * 2);
		}


	// Erase the interrupt vector tables	
	MirrorBlock(0,0);

#ifdef ldr_debug
	for (offset = 16; offset < 0xA0; )
		{
		Shadow[offset++] = 0x16;
		Shadow[offset++] = 0x40;
		Shadow[offset++] = 0x00;
		Shadow[offset++] = 0x00;
		}

	for (offset = 0xA4; offset < 0x2A0; )
		{
		Shadow[offset++] = 0x16;
		Shadow[offset++] = 0x40;
		Shadow[offset++] = 0x00;
		Shadow[offset++] = 0x00;
		}

	for (offset = 0x2A4; offset < 0x400; )
		{
		Shadow[offset++] = 0x16;
		Shadow[offset++] = 0x40;
		Shadow[offset++] = 0x00;
		Shadow[offset++] = 0x00;
		}

	for (offset = 0x400; offset < 0x800; )
		{
		Shadow[offset++] = 0x16;
		Shadow[offset++] = 0x40;
		Shadow[offset++] = 0x00;
		Shadow[offset++] = 0x00;
		}
#else
	for (offset = 12; offset < 0x800; )
		{
		Shadow[offset++] = 0x16;
		Shadow[offset++] = 0x40;
		Shadow[offset++] = 0x00;
		Shadow[offset++] = 0x00;
		}
#endif

	WriteBlock(0,0);


	MirrorBlock(UserCatchAll >> 16, UserCatchAll);
	// determine the offset into the shadow block
	// convert word address form to byte address form
	// and calculate the offset from the start of the shadow block
	offset = ((UserCatchAll & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);

	// restore the CatchAll vector to reset
	Shadow[offset++] = 0x00;
	Shadow[offset++] = 0x00;
	Shadow[offset++] = 0x04;
	Shadow[offset++] = 0x00;
	Shadow[offset++] = 0x00;
	Shadow[offset++] = 0x00;
	Shadow[offset++] = 0x00;
	Shadow[offset] = 0x00;

	// restore the IP address in the shadow block	
	offset = ((P_Def_IP & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);
	memcpy((void *)&Shadow[offset], (void *) LIA_IP, sizeof(IP_ADDR));
	Shadow[offset++] = LIA_IP[0];
	Shadow[offset++] = LIA_IP[1];
	offset++;
	offset++;
	Shadow[offset++] = LIA_IP[2];
	Shadow[offset++] = LIA_IP[3];

	// restore the MAC address in the shadow block
	offset = ((P_MAC & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);
	Shadow[offset++] = LIA_MAC[0];
	Shadow[offset++] = LIA_MAC[1];
	offset++;
	offset++;
	Shadow[offset++] = LIA_MAC[2];
	Shadow[offset++] = LIA_MAC[3];
	offset++;
	offset++;
	Shadow[offset++] = LIA_MAC[4];
	Shadow[offset++] = LIA_MAC[5];

	// writeout the modified parameter block
	WriteBlock((UserCatchAll >> 16),UserCatchAll);

	#ifdef LED_PIC_PGM
		LED_PIC_PGM = 0;
	#endif
	}


void UserExec(DWORD addr)
///////////////////////////////////////////////////////////////////////////
// void UserExec(DWORD addr)
//
// Pass control to code at addr
///////////////////////////////////////////////////////////////////////////
	{
	asm("goto %0" : "=r"(addr));
	}





unsigned char ENC_SPI_read(char command)
///////////////////////////////////////////////////////////////////////////
// unsigned char ENC_SPI_read(char command)   
//	Reads the SPI BUS
//	Contents of WREG are transmitted via the SPI BUS
//	Blocking - waits for SPI write to complete
///////////////////////////////////////////////////////////////////////////
	{
	volatile char dummy;	
	dummy = ENC_SPIBUF; 	// force clearance of buffer full flag
	ENC_SPIBUF = command;

	while (!ENC_SPISTATbits.SPIRBF)
		;
	return(ENC_SPIBUF);
	}




void ENC_SPI_write(char data) 
///////////////////////////////////////////////////////////////////////////
// ENC_SPI_write(char data)   
//	Write to the SPI BUS
//	Contents of WREG are transmitted via the SPI BUS
//	Blocking - waits for SPI write to complete
///////////////////////////////////////////////////////////////////////////
	{
	volatile char dummy;
	dummy = ENC_SPIBUF;		// force clearance of buffer full flag
	
	ENC_SPIBUF = data;
	while (!ENC_SPISTATbits.SPIRBF)
		;
	}


#define SelectENC() 	(ENC_CS=0)
///////////////////////////////////////////////////////////////////////////
// void SelectENC(void)
//
//	Asserts active low CS on ENC28J60 Ethernet controller
//	Deasserts active low CS on MMC socket and FRAM
///////////////////////////////////////////////////////////////////////////


#define DeselectENC() 	(ENC_CS=1)
///////////////////////////////////////////////////////////////////////////
// void DeselectENC(void)
//
//	Deasserts active low CS on ENC28J60 Ethernet controller
///////////////////////////////////////////////////////////////////////////


void init_pic(void)
///////////////////////////////////////////////////////////////////////////
// void init_pic(void)
//
// Initialise the hardware defaults
///////////////////////////////////////////////////////////////////////////
	{
	#ifdef PA_DefData
		// initialse port A
		PORTA = PA_DefData;
		TRISA = PA_DefTRIS;
	#endif

	#ifdef PB_DefData
		// initialise port B
		PORTB = PB_DefData;
		TRISB = PB_DefTRIS;
	#endif

	#ifdef PC_DefData
		// initialise port C
		PORTC = PC_DefData;
		TRISC = PC_DefTRIS;
	#endif

	#ifdef PD_DefData
		// initialise port D
		PORTD = PD_DefData;
		TRISD = PD_DefTRIS;
	#endif
	
	#ifdef PE_DefData
		// initialise port E
		PORTE = PE_DefData;
		TRISE = PE_DefTRIS;
	#endif
	
	#ifdef PF_DefData
		// initialise port F
		PORTF = PF_DefData;
		TRISF = PF_DefTRIS;
	#endif
	
	#ifdef PG_DefData
		// initialise port G
		PORTG = PG_DefData;
		TRISG = PG_DefTRIS;
	#endif
	
	#ifdef PH_DefData
		// initialise port H
		PORTH = PH_DefData;
		TRISH = PH_DefTRIS;
	#endif
	
	#ifdef PJ_DefData
		// initialise port J
		PORTJ = PJ_DefData;
		TRISJ = PJ_DefTRIS;
	#endif
	
	#ifdef PLLFBD_Def
		PLLFBD = PLLFBD_Def;
	#endif
	
	#ifdef CLKDIV_Def
		CLKDIV = CLKDIV_Def;
	#endif
	
	#ifdef AD1PCFG_Def
		AD1PCFG = AD1PCFG_Def;
	#endif
	
	#ifdef AD1PCFGL_Def
		AD1PCFGL = AD1PCFGL_Def;
	#endif
	
	#ifdef AD1PCFGH_Def
		AD1PCFGH = AD1PCFGH_Def;
	#endif

	#ifdef USE_IO_MAPPING
		// setup the I/O mapping
		// initialize the input mapping

		#if ENC_SPI_PORT == 1
			RPINR20bits.SDI1R = SPI1_SDI_RP;

			// map the output pins to their respective functions
			SPI1_SDO_RPR = 7;	// SPI1 SDO
			SPI1_CLK_RPR = 8; 	// SPI1 CLK
		#else
			RPINR22bits.SDI2R= SPI2_SDI_RP;

			// map the output pins to their respective functions
			SPI2_SDO_RPR = 10;	// SPI2 SDO
			SPI2_CLK_RPR = 11; 	// SPI2 CLK
		#endif

		#if CONSOLE_UART == 1
			RPINR18bits.U1RXR = UART1_RX_RP;

			// map the output pins to their respective functions
			UART1_TX_RPR = 3;	// UART1 TX
		#else
			RPINR19bits.U2RXR = UART2_RX_RP;

			// map the output pins to their respective functions
			UART2_TX_RPR = 3;	// UART1 TX
		#endif
	#endif
	}



void ServiceSystemTimer(void)
///////////////////////////////////////////////////////////////////////////
// void ServiceSystemTimer(void)
//
//	Tests the interrupt flag for the system timer (Timer 1)
//	Decrements the TMR_Short (8 bit), TMR_Long (16 bit counters) and TMR_Activity(16 bit counters)
//
// Exit
//	TMR_Short--
//	TMR_Long--
//	FlowMR--
//	TF_Short	set (TRUE) when TMR_Short decrements to 0
//	TF_Long		set (TRUE) when TMR_Long decrements to 0
//	TF_Flow		set (TRUE) when TMR_Flow decrements to 0
///////////////////////////////////////////////////////////////////////////
	{
	// timer 1 interrupt source?
	if (IFS0bits.T1IF)
		{
		// here on timer 1 rollover
		IFS0bits.T1IF=0;

		// service the short timer
		if(!--TMR_Short)
			TF_Short = TRUE;

		// service the long timer
		if(!--TMR_Long)
			TF_Long = TRUE;


		// time to toggle the status led?
		if (!--StatusLEDCount)
			{
			StatusLEDCount = CStatusLEDCount;

			#ifdef LED_Status
				if (LED_Status)
					LED_Status=0;
				else
					LED_Status=1;
			#endif
			}
		//
		// perform Busy LED hold processing
		// the busy LED indicates a packet has
		// been queued to the Ethernet Controller
		// for transmission
		#ifdef LED_Busy
			#ifdef	LED_Busy_NEG
				if(!(LED_Busy))
					{
					// here if the busy LED is illuminated
					if (!--BusyLEDCount)
						{
						// timer expired - turn off the LED
						LED_Busy = 1;
						BusyLEDCount = CBusyLEDCount;
						}
					}
			#else
				if(LED_Busy)
					{
					// here if the busy LED is illuminated
					if (!--BusyLEDCount)
						{
						// timer expired - turn off the LED
						LED_Busy = 0;
						BusyLEDCount = CBusyLEDCount;
						}
					}		
			#endif
		#endif


		// perform Health LED hold processing
		// the Health LED indicates a packet has
		// been received targeted at this system
		#ifdef LED_Health
			#ifdef LED_Health_NEG
				if(!(LED_Health))
					{
					// here if the Health LED is illuminated
					if (!--HealthLEDCount)
						{
						// timer expired - turn off the LED
						LED_Health = 1;
						HealthLEDCount = CHealthLEDCount;
						}
					}
			#else
				if(LED_Health)
					{
					// here if the Health LED is illuminated
					if (!--HealthLEDCount)
						{
						// timer expired - turn off the LED
						LED_Health = 0;
						HealthLEDCount = CHealthLEDCount;
						}
					}		
			#endif
		#endif

		// service the 100ms timer
		if(!--TMR_100ms)
			{
			TF_100ms = TRUE;
			TMR_100ms = 100;

			// service the activity timer
			#ifdef LED_Health
			if (TMR_Activity)
				if(!--TMR_Activity)
					#ifdef LED_Health_NEG
						LED_Health = 1;
					#else
						LED_Health = 0;
					#endif
			#endif
			}
		}
	}


void BFCReg(BYTE Address, BYTE Data)
///////////////////////////////////////////////////////////////////////////
// void BFCReg(BYTE Address, BYTE Data)
//
//	Write the ENC28J60 Ethernet Controller ETH registers via the 
//	Bit Field Clear command
//
//	ONLY FOR USE WITH THE ETH REGISTERS
//
// Entry
//		Address contains the 5 bit address of the target ETH control register
//		Data	mask of bits to be cleared
///////////////////////////////////////////////////////////////////////////
	{
	SelectENC();	// enable the ENC

	// transmit opcode/address to the Ethernet controller
	ENC_SPI_write(BFC | Address);
	ENC_SPI_write(Data);
	DeselectENC();
	}


void BFSReg(BYTE Address, BYTE Data)
///////////////////////////////////////////////////////////////////////////
// void BFSReg(BYTE Address, BYTE Data)
//
//	Write the ENC28J60 Ethernet Controller ETH registers via the 
//	Bit Field Set command
//
//	ONLY FOR USE WITH THE ETH REGISTERS
//
// Entry
//		Address contains the 5 bit address of the target ETH control register
//		Data	mask of bits to be set
///////////////////////////////////////////////////////////////////////////
	{
	SelectENC();	// enable the ENC

	// transmit opcode/address to the Ethernet controller
	ENC_SPI_write(BFS | Address);
	ENC_SPI_write(Data);
	DeselectENC();
	}


void WriteReg(BYTE Address, BYTE Data)
///////////////////////////////////////////////////////////////////////////
// void WriteReg(BYTE Address, BYTE Data)
//
//	Write the ENC28J60 Ethernet Controller via the Write Control Register
//
// Entry
//		Address contains the 5 bit address of the target control register
//		The ENC MUST be in the appropriate bank
///////////////////////////////////////////////////////////////////////////
	{
	SelectENC();	// enable the ENC

	// transmit opcode/address to the Ethernet controller
	ENC_SPI_write(WCR | Address);
	ENC_SPI_write(Data);
	DeselectENC();
	}


void BankSel(WORD Target) 
///////////////////////////////////////////////////////////////////////////
// void BankSel(WORD Target) 
//
//	Select the ENC28J60 current register bank
//
// Entry
//		Takes the high order byte of the target register address and 
//		modifies the ETHCON1 bank select bits to match
///////////////////////////////////////////////////////////////////////////
	{
	// clear the current page select bits
	BFCReg(ECON1, ECON1_BSEL1 | ECON1_BSEL0);

	// 
	//BFSReg(ECON1, ((WORD_VAL*)&Register)->v[1]);
	BFSReg(ECON1, (Target >> 8) & 0x03);
	}




BYTE ReadETHReg(BYTE Address)
///////////////////////////////////////////////////////////////////////////
// void MACPutArray(BYTE *source, WORD len)
//
//	Read the ENC28J60 Ethernet Controller ETH register
//
// Entry
//		Address contains the 5 bit address of the target ETH control register
//
// Exit
//		Returns contents of target register
///////////////////////////////////////////////////////////////////////////
	{
	BYTE x;

	SelectENC();	// enable the ENC

	// transmit opcode/address to the Ethernet controller
	ENC_SPI_read(RCR | Address);
	x = ENC_SPI_read(0);

	DeselectENC();

	return(x);
	}


void ENC_SW_Reset(void)
///////////////////////////////////////////////////////////////////////////
// void ENC_SW_Reset(void)
//
//	Software reset the ENC28J60 Ethernet Controller
///////////////////////////////////////////////////////////////////////////
	{
	// ensure we are not in power saving mode
	BFCReg(ECON2, ECON2_PWRSV);
	delay_ms(1);
	SelectENC();	// enable the ENC

	// transmit Software Reset Command to the Ethernet controller
	ENC_SPI_write(SYSCMD);
	DeselectENC();
	delay_ms(1);
	}



BYTE ReadMACReg(BYTE Address)
///////////////////////////////////////////////////////////////////////////
// BYTE ReadMACReg(BYTE Address)
//
//	ReadMACReg sends the 8 bit RCR opcode/Address byte as well 
//	as a dummy byte over the SPI and then retrieves the 
//	register contents in the last 8 SPI clocks.
//
// Entry
//		Target ENC Bank must be selected
//		Address is the 5 bit address of the MAC or MII register to be read
//		Upper 3 bits must be 0
///////////////////////////////////////////////////////////////////////////
	{
	char x;

	SelectENC();	// enable the ENC

	// transmit opcode/address to the Ethernet controller
	ENC_SPI_read(RCR | Address);
	ENC_SPI_read(0);		// do dummy read
	x = ENC_SPI_read(0);	// get target register
	DeselectENC();
	
	return x;
	}



void WritePHYReg(BYTE Address, WORD Data)
///////////////////////////////////////////////////////////////////////////
// void WritePHYReg(BYTE Address, WORD Data)
//
//	WritePHYReg performs an MII write operation.  While in 
//	progress, it simply polls the MII BUSY bit wasting time.
//
// On Entry:
//		Address of the PHY register to write to.
//		16 bits of data to write to PHY register.
//
// On Exit:
//		ENC Bank 3 selected
///////////////////////////////////////////////////////////////////////////
	{
	BYTE x;

	// Write the register address
	BankSel(MIREGADR);
	WriteReg(LOW(MIREGADR), Address);
	
	// Write the data
	// Order is important: write low byte first, high byte last
	WriteReg(LOW(MIWRL), Data & 0x00ff);	
	WriteReg(LOW(MIWRH), (Data >> 8) & 0x00ff);

	// Wait until the PHY register has been written
	BankSel(MISTAT);
	//	while(ReadMACReg(MISTAT) & MISTAT_BUSY);
	do
		x = ReadMACReg(LOW(MISTAT));
	while(x & MISTAT_BUSY);
	}



WORD ReadPHYReg(BYTE Target)
///////////////////////////////////////////////////////////////////////////
// WORD ReadPHYReg(BYTE Target)
//
//	ReadPHYReg performs an MII read operation.  While in 
//	progress, it simply polls the MII BUSY bit wasting time.
//
// On Entry:
//		Address of the PHY register to read from.
//		16 bits of data to write to PHY register.
//
// On Exit:
//		Returns 16bit value from the target register
//		ENC Bank 2 selected
///////////////////////////////////////////////////////////////////////////
	{
	BYTE x;
	WORD_VAL result;

	// Set the right address and start the register read operation
	BankSel(MIREGADR);
	WriteReg(LOW(MIREGADR), Target);
	WriteReg(LOW(MICMD), MICMD_MIIRD);	

	// Loop to wait until the PHY register has been read through the MII
	BankSel(MISTAT);
	do
		x = ReadMACReg(LOW(MISTAT));
	while (x & MISTAT_BUSY);

	// Stop reading 
	// **** according to the datasheet the next two lines should not be needed
	BankSel(MICMD);
	WriteReg(LOW(MICMD), 0x00);	
	
	// Obtain results and return
	result.LSB = ReadMACReg(LOW(MIRDL));
	result.MSB = ReadMACReg(LOW(MIRDH));
	return(result.Val);

	}//end ReadPHYReg



void MACSetDuplex(DUPLEX DuplexState)
///////////////////////////////////////////////////////////////////////////
// void MACSetDuplex(DUPLEX DuplexState)
//
//		Disables RX, TX logic, sets MAC up for full duplex 
//		operation, sets PHY up for full duplex operation, and 
//		reenables RX logic.  The back-to-back inter-packet gap 
//		register (MACBBIPG) is updated to maintain a 9.6us gap.
//
// Note:
//		If a packet is being transmitted or received while this 
//		function is called, it will be aborted.
//
// Entry
//  Member of DUPLEX enum:
//		FULL: Set full duplex mode
//		HALF: Set half duplex mode
//		USE_PHY: Set the MAC to match the PHYDPLXMODE bit in 
//				 PHYCON.  This is controlled by LEDB on RESET.
//
// Exit
//		ENC Bank 2 selected
///////////////////////////////////////////////////////////////////////////
	{
	BYTE x;
	WORD PhyReg;
	
	// Disable receive logic and abort any packets currently being transmitted
	BFCReg(ECON1, ECON1_TXRTS | ECON1_RXEN);
	
	// Set the PHY to the proper duplex mode
	PhyReg = ReadPHYReg(PHCON1);
	if(DuplexState == USE_PHY)
		{
		if (PhyReg & PHCON1_PDPXMD)
			DuplexState = FULL;
		else
			DuplexState = HALF;
		}
	else
		{
		if (DuplexState == FULL)
			PhyReg |= PHCON1_PDPXMD;
		else
			PhyReg &= ~PHCON1_PDPXMD;
		WritePHYReg(PHCON1, PhyReg);
		}

	// Set the MAC to the proper duplex mode
	BankSel(MACON3);
	x = ReadMACReg(LOW(MACON3));

	if (DuplexState == FULL)
		WriteReg(LOW(MACON3), (x |= MACON3_FULDPX));
	else
		WriteReg(LOW(MACON3), (x &= ~MACON3_FULDPX));


	// Set the back-to-back inter-packet gap time to IEEE specified 
	// requirements.  The meaning of the MABBIPG value changes with the duplex
	// state, so it must be updated in this function.
	// In full duplex, 0x15 represents 9.6us; 0x12 is 9.6us in half duplex
	WriteReg(LOW(MABBIPG), DuplexState ? 0x15 : 0x12);	
	
	// Reenable receive logic
	BFSReg(ECON1, ECON1_RXEN);
	}



void init_ENC(BYTE *Address)
///////////////////////////////////////////////////////////////////////////
// void init_ENC(BYTE *Address)
//
//	Initialise the PIC's SPI port and the ENC28J60 Ethernet Controller
//	This initialization assumes a single transmit buffer 
//     see MCA_TX_BUFFER_COUNT
//	The maximum transmit packet size is set in MAC_TX_BUFFER_SIZE
///////////////////////////////////////////////////////////////////////////
	{
	BYTE i;

	// deselect the Ethernet controller
	ENC_CS = 1;

	#ifdef	ENC_RESET
		ENC_RESET=0;		// reset the ENC
		delay_ms(10);
		ENC_RESET=1;		// remove the RESET
		delay_ms(10);
	#endif

	#ifdef ldr_debug
		printf("Resetting the Ethernet Controller\r\n");
	#endif

	// initialise the SPI interface
	ENC_SPICON1 = 0;  
	ENC_SPISTATbits.SPIEN = 0;		// enable synchronous serial port 
	ENC_SPICON1bits.MODE16 = 0;
	ENC_SPICON1bits.MSTEN = 1;
	ENC_SPICON1bits.CKE = 1;		// data transmitted on rising edge
  	ENC_SPICON1bits.SMP = 0; 		// input sampled at middle of data output time
  	ENC_SPICON1bits.CKP = 0; 
  	ENC_SPICON1bits.PPRE = ENC_SPI_PRESCALE_PRI;	
	ENC_SPICON1bits.SPRE = ENC_SPI_PRESCALE_SEC;	
  	ENC_SPISTATbits.SPIEN = 1;     	// enable synchronous serial port

	delay_ms(2);

	// perform software reset of the Ethernet controller
	// leaves the controller in register bank 0
	do
		{
		ENC_SW_Reset();
		i = ReadETHReg(ESTAT);
		} while((i & 0x08) || (~i & ESTAT_CLKRDY));

	// disable packet reception
	BFCReg(ECON1, ECON1_RXEN);

	// configure the receive buffer boundary pointers 
	WasDiscarded = TRUE;

	// clear the packet count (should already be cleared);
	BankSel(EPKTCNT);
	WriteReg(LOW(EPKTCNT),0);

	NextPacketLocation = RXSTART;
	BankSel(ERXSTL);
	WriteReg(ERXSTL, RXSTART & 0x00ff);
	WriteReg(ERXSTH, (RXSTART >> 8) & 0x00ff);
	WriteReg(ERXRDPTL, RXSTART & 0x00ff);			// Write low byte first
	WriteReg(ERXRDPTH, (RXSTART >> 8) & 0x00ff);	// Write high byte last
	WriteReg(ERXNDL, RXSTOP & 0x00ff);
	WriteReg(ERXNDH, (RXSTOP >> 8) &0x00ff);

	 // configure the transmit buffer pointer
	WriteReg(ETXSTL, TXSTART & 0x00ff);
	WriteReg(ETXSTH, (TXSTART >> 8) & 0x00ff);

	// ** Here is where receive filters will be configured via ERXFCON
	// The default enables unicast and broadcast
	// ** BUG FIX 270109 added banksel
	BankSel(ERXFCON);
	WriteReg(LOW(ERXFCON), ERXFCON_UCEN | ERXFCON_CRCEN | ERXFCON_HTEN | ERXFCON_BCEN | ERXFCON_MCEN);

	// Perform MAC configuration
	BankSel(MACON1);
	// Enable the receive portion of the MAC
	WriteReg(LOW(MACON1), MACON1_MARXEN);
	
	// Bring MAC and subsystem components out of RESET
	WriteReg(LOW(MACON2), 0x00);
	
	// Pad packets to 60 bytes, add CRC, and check Type/Length field.
	WriteReg(LOW(MACON3), MACON3_PADCFG0 | MACON3_TXCRCEN | MACON3_FRMLNEN);

	// Set the maximum packet size which the controller will accept
	WriteReg(LOW(MAMXFLL), MAXFRAMEC & 0x00ff);	
	WriteReg(LOW(MAMXFLH), (MAXFRAMEC >> 8) & 0x00ff);	

	// Set non-back-to-back inter-packet gap to 9.6us.  The back-to-back 
	// inter-packet gap (MABBIPG) is set by MACSetDuplex() which is called 
	// later.
	WriteReg(LOW(MAIPGL), 0x12);
	WriteReg(LOW(MAIPGH), 0x0C);
	
	// This fix is required for revision A0 beta silicon only.  
	// The reserved register must be 0x00 for future silicon versions, which is 
	// the reset default.  If 0x01 is written to 0x215 in future silicon, the 
	// PHY registers will not be readable/writable.  This code checks EREVID 
	// and writes the appropriate value.
/*
	BankSel(EREVID);	// Enter Bank 3
	if (ReadETHReg(LOW(EREVID)) == 0 )
		{
		BankSel(0x200);
		WriteReg(LOW(0x215), 0x01);
		}
*/

	// initialise the MAC address
	BankSel(MAADR0);
    WriteReg((BYTE) MAADR0 &0x00ff, Address[5]);
    WriteReg((BYTE) MAADR1 &0x00ff, Address[4]);
    WriteReg((BYTE) MAADR2 &0x00ff, Address[3]);
    WriteReg((BYTE) MAADR3 &0x00ff, Address[2]);
    WriteReg((BYTE) MAADR4 &0x00ff, Address[1]);
    WriteReg((BYTE) MAADR5 &0x00ff, Address[0]);

	// Disable half duplex loopback in PHY.  Bank bits changed to Bank 2 as a 
	// side effect.
	WritePHYReg(PHCON2, PHCON2_HDLDIS);

	// Configure LEDA to display TX/RX activity, LEDB to display LINK status
	WritePHYReg(PHLCON, 0x0742); // bank 2 selected on exit
	
	// communication mode should be set.  
	MACSetDuplex(HALF);	// Function exits with Bank 2 selected

	// Enable packet reception
	BFSReg(ECON1, ECON1_RXEN);

	// AUTOINC in ECON2 enabled by default
	}



void MACPut(BYTE data)
///////////////////////////////////////////////////////////////////////////
// void MACPut(BYTE data)
//
//	MACPut writes a byte of data to the ENC28J60 RAM.  
//  EWRPT is incremented by len.
//
// Entry
//		EWRPT 		must point to the location to begin writing.
//		data		the byte to be sent
//
// Exit
//		EWRPT		incremented
///////////////////////////////////////////////////////////////////////////
	{
	SelectENC();			// enable the ENC
	ENC_SPI_write(WBM);

	// Send the data
	ENC_SPI_write(data);		// send the data

	DeselectENC();
	}



void MACPutArray(BYTE *source, WORD len)
///////////////////////////////////////////////////////////////////////////
// void MACPutArray(BYTE *source, WORD len)
//
//	MACPutArray writes several sequential bytes to the 
//  ENC28J60 RAM.  It performs faster than multiple MACPut()
//  calls.  EWRPT is incremented by len.
//
// Entry
//		EWRPT 		must point to the location to begin writing.
//		source		Pointer to source of bytes to copy
//		len  		number of bytes to write to the data buffer
//
// Exit
//		EWRPT		incremented by len
///////////////////////////////////////////////////////////////////////////
	{
	// Select the chip and send the proper opcode
	SelectENC();			// enable the ENC
	ENC_SPI_write(WBM);

	// Send the data
	while(len--)
		ENC_SPI_write(*source++);		// send the data

	// Terminate the burst operation
	DeselectENC();
	}


BYTE MACGet(void)
///////////////////////////////////////////////////////////////////////////
// BYTE MACGet(void)
//
//	MACGet reads a data byte from the 
//  ENC28J60 RAM. ERDPT is incremented after the byte is read
//
// Entry
//		ERDPT 		must point to the place to read from
//
// Exit
//		ERDPT		incremented by len
///////////////////////////////////////////////////////////////////////////
	{
	BYTE i;

	SelectENC();			// enable the ENC

	// Start the read operation
	ENC_SPI_write(RBM);			// Send the Read Buffer Memory opcode.

	// Read the data
	i = ENC_SPI_read(0);

	// Terminate the read operation
	DeselectENC();			// enable the ENC

	return i;
	}



WORD MACGetArray(BYTE *destination, WORD len)
///////////////////////////////////////////////////////////////////////////
// WORD MACGetArray(BYTE *destination, WORD len)
//
//	MACGetArray reads several sequential bytes from the 
//  ENC28J60 RAM.  It performs faster than multiple MACGet()
//  calls.  ERDPT is incremented after each byte is read
//
// Entry
//		ERDPT 		must point to the place to read from
//		source		Pointer to source of bytes to copy
//		len  		number of bytes to read fromthe data buffer
//
// Exit
//		ERDPT		incremented by len
//		Returns the number of bytes read
///////////////////////////////////////////////////////////////////////////
	{
	WORD i;

	SelectENC();			// enable the ENC

	// Start the burst operation
	ENC_SPI_write(RBM);			// Send the Read Buffer Memory opcode.

	// Read the data
	for(i = 0; i<len; i++)
		*destination++ = ENC_SPI_read(0);

	// Terminate the burst operation
	DeselectENC();			// enable the ENC

	return i;
	}


void MACSkip(BYTE len)
///////////////////////////////////////////////////////////////////////////
// void MACSkip(BYTE len)
//
//	Skip len sequential bytes from the ENC28J60 RAM.
//
// Entry
//		ERDPT 		must point to the place to read from
//		source		Pointer to source of bytes to copy
//		len  		number of bytes to read fromthe data buffer
//
// Exit
//		ERDPT		incremented by len
///////////////////////////////////////////////////////////////////////////
	{
	BYTE i;

	SelectENC();			// enable the ENC

	// Start the burst operation
	ENC_SPI_write(RBM);	// Send the Read Buffer Memory opcode.

	// skip the data
	for(i = 0; i<len; i++)
		ENC_SPI_read(0);

	// Terminate the burst operation
	DeselectENC();			// enable the ENC
	}


void MACFlush(void)
///////////////////////////////////////////////////////////////////////////
// void MACFlush(void)
//
// Start the transmission
// After transmission completes (MACIsTxReady() returns TRUE), the packet 
// can be modified and transmitted again by calling MACFlush() again.
// Until MACPutHeader() is called, the data in the TX buffer will not be 
// corrupted.
///////////////////////////////////////////////////////////////////////////
	{
/*  Code segment removed 16/11/10 - work around for ENC28J60 R6 silicon bug
	
	BYTE x;

	x = ReadETHReg(EIR);
	if (!(x & EIR_TXIF))
		{
		BFCReg(ECON1, ECON1_TXRTS);
		BFSReg(ECON1, ECON1_TXRTS);
		BFCReg(EIR, EIR_TXIF);
		}
	BFSReg(ECON1, ECON1_TXRTS);
*/

  	// ** Code segment added 16/11/10 - work around for ENC28J60 R6 silicon bug
	BFSReg(ECON1, ECON1_TXRST);
	BFCReg(ECON1, ECON1_TXRST);             
	BFCReg(EIR, EIR_TXERIF | EIR_TXIF);
	BFSReg(ECON1, ECON1_TXRTS);
  	// ** End of code segment added 16/11/10 - work around for ENC28J60 R6 silicon bug

	#ifdef LED_Busy
		// turn on the Busy LED
		#ifdef	LED_Busy_NEG
			LED_Busy = 0;
		#else
			LED_Busy = 1;		
		#endif
		BusyLEDCount = CBusyLEDCount;
	#endif
	}


BOOLEAN MACIsTxReady(void)
///////////////////////////////////////////////////////////////////////////
// BOOLEAN MACIsTxReady(void)
//
// Returns true if the MAC is ready to transmit
///////////////////////////////////////////////////////////////////////////
	{
	BYTE x;
	x = ReadETHReg(ECON1);
	if (!(x & ECON1_TXRTS))
		return TRUE;
	else
		return FALSE; 
	}



void MACDiscardRx(void)
///////////////////////////////////////////////////////////////////////////
// void MACDiscardRx(void)
//
// Free the current receive buffer in the ENC
///////////////////////////////////////////////////////////////////////////
	{
	WORD Next;

	// Make sure the current packet was not already discarded
	if (WasDiscarded)
		return;
	WasDiscarded = TRUE;

	// Errata Rev B4 workaround
	Next = NextPacketLocation - 1;
	if(Next > RXSTOP)
		Next = RXSTOP;

	// Decrement the RX packet counter register, EPKTCNT
	BFSReg(ECON2, ECON2_PKTDEC);

	// Move the receive read pointer to unwrite-protect the memory used by the 
	// last packet.  The writing order is important: set the low byte first, 
	// high byte last.
	BankSel(ERXRDPTL);
	WriteReg(ERXRDPTL, Next & 0x00ff);
	WriteReg(ERXRDPTH, (Next >> 8) & 0x00ff);

	// Errata Rev B4 workaround
	BFSReg(EIR, EIR_PKTIF);

	#ifdef LED_Health
		// turn on the Health LED
		#ifdef	LED_Health_NEG
			LED_Health = 0;
		#else
			LED_Health = 1;		
		#endif
		HealthLEDCount = CHealthLEDCount;
	#endif
	}



BOOLEAN MACGetHeader(MAC_ADDR *remote, WORD* type)
///////////////////////////////////////////////////////////////////////////
// BOOLEAN MACGetHeader(MAC_ADDR *remote, WORD* type)
//
// If a packet exists in the ENC Rx buffer then get the MCP MAC Preamble and
//	the MAC Header
//
// Entry
//
// Exit
//		If the ENC Rx buffer is empty
//			returns false
//		else
//			MAC_Preamble	MCP MAC preamble from Rx buffer 
//			MAC_Header		DA, SA, Type from the packet
//			Returns true
///////////////////////////////////////////////////////////////////////////
	{
	WORD_VAL MAC_type;

	// Test if at least one packet has been received and is waiting
	BankSel(EPKTCNT);
	if (!ReadETHReg(LOW(EPKTCNT)))
		return (FALSE);
	
	// Make absolutely certain that any previous packet was discarded	
	if (!WasDiscarded)
		MACDiscardRx();

	// Set the SPI read pointer to the beginning of the next unprocessed packet
	BankSel(ERDPTL);
	WriteReg(ERDPTL, NextPacketLocation & 0x00ff);
	WriteReg(ERDPTH, (NextPacketLocation >> 8) & 0x00ff);

	// Obtain the ENC MAC Preamble from Ethernet buffer
	MACGetArray((BYTE*)&MAC_preamble, sizeof(MAC_preamble));

	// Obtain the MAC header from Ethernet buffer
	MACGetArray((BYTE*)&MAC_header, sizeof(MAC_header));

	// The EtherType field, like most items transmitted on the Ethernet medium
	// are in big endian.
	MAC_type.MSB = (MAC_header.Type & 0x00ff);
	MAC_type.LSB = ((MAC_header.Type >> 8) & 0x00ff);
    MAC_header.Type = MAC_type.Val;
	
	// Save the location where the hardware will write the next packet to
	NextPacketLocation = MAC_preamble.NextPacketPointer;

	// Return the Ethernet frame's Source MAC address field to the caller
	// This parameter is useful for replying to requests without requiring an 
	// ARP cycle.
    memcpy((void*)remote, (void*)MAC_header.SourceMACAddr, 6);

	// Return a simplified version of the EtherType field to the caller
    *type = MAC_UNKNOWN;
    if ((MAC_header.Type == IP) || (MAC_header.Type == ARP))
    	*type = MAC_header.Type;

    WasDiscarded = FALSE;	// Mark this packet as discardable           
	return TRUE;
	}


#define PutMACHeader MACPutHeader
void MACPutHeader(MAC_ADDR *remote, WORD type, WORD dataLen)
	{
	// Set the SPI write pointer to the beginning of the current transmit buffer
	BankSel(EWRPTL);
	WriteReg(EWRPTL, TXSTART & 0x00ff);
	WriteReg(EWRPTH, (TXSTART >> 8) & 0x00ff);

	// Set the TXND pointer to correspond to the packet size given
    dataLen += (WORD)sizeof(ETHER_HEADER) + TXSTART;
	WriteReg(ETXNDL, dataLen & 0x00ff);
	WriteReg(ETXNDH, (dataLen >> 8) & 0x00ff);

	// Set the per-packet control byte and write the Ethernet destination 
	// address
	MACPut(0x00);	// Use default control configuration
    MACPutArray((BYTE*)remote, 6);

	// Write our MAC address in the Ethernet source field
    MACPutArray(LIA_MAC, 6);

	// Write the appropriate Ethernet Type WORD for the protocol being used
    MACPut((type >> 8) & 0x00ff);
    MACPut(type & 0x00ff);
	}


void PutIPHeader(IP_ADDR *Target_IP, BYTE IP_Protocol, WORD IP_Length)
///////////////////////////////////////////////////////////////////////////
// void PutIPHeader(IP_ADDR *Target_IP, BYTE IP_Protocol, WORD IP_Length)
//
//	Build IP header and write to Ethernet Controller
//
// Entry
//	LIA_IP		holds the source IP address of packet
//	Target_IP	holds the target IP address
//	IP_Length	packet length
//	IP_Protcol  Protocol number
///////////////////////////////////////////////////////////////////////////
	{
	#define IP_HDR_LEN 20
	#define IP_Hdr_Chksum_Offset 10

	WORD_VAL IP_Hdr_Base;

	// get the current location in the MAC buffer
	BankSel(EWRPTL);
	IP_Hdr_Base.MSB = ReadETHReg(EWRPTH);
	IP_Hdr_Base.LSB = ReadETHReg(EWRPTL);

	MACPut(0x45);	// load version and header fields
	MACPut(0x00);

	// output the IP packet length
	MACPut((IP_Length >> 8) & 0x00ff);
	MACPut(IP_Length & 0x00ff);

	// output the fragment identifier
	MACPut(0);
	MACPut(0);

	// output the flags and fragment offset
	MACPut(0);
	MACPut(0);

	// set TTL to maximum and load protocol number
	MACPut(0xff);
	MACPut(IP_Protocol);

	// note the checksum must be updated to include the
	// source and destination IP addresses. This is
	// required because the header checksum is loaded
	// before the addresses

	// output null checksum 
	// this is to be replaced either with the complemented of the SW
	// processed checksum or the checksum derived from the Ethernet
	// controller
	MACPut(0);
	MACPut(0);

	// output LIA's IP address
	MACPutArray(LIA_IP,4);	

	// output destination IP address
	MACPutArray((BYTE *)Target_IP,4);

	// Calculate the checksum
	// note this IP header does not include any options field. 
	// If it was then the checksum would need to include the
	// option field. Perhaps a better method would be to store
	// the start of the header location in the MAC and allow the
	// checksum to be calulate after the call to load the MAC
	// header
	PutTxChecksum(IP_Hdr_Base.Val, IP_HDR_LEN, IP_Hdr_Chksum_Offset);
	}


void PutTxChecksum(WORD Base, WORD Len, WORD Checksum_Offset)
///////////////////////////////////////////////////////////////////////////
//	void PutTxChecksum(WORD Base, WORD Len, WORD Checksum_Offset)
//
//	Initiate the ENC28J60 Checksum Calculation
//	Inserts the SW derived into the transmit buffer
//
// Entry
//		ENC_CS			asserted
//		Base			Base address block for Checksum Calculation
//		Len				Length of the block
//		Checksum_offset	offset into the ENC memory for checksum insertion
//
// Exit
//		Checksum inserted into target black
//		returns with ENC in bank 0
//		ENC_CS			unchanged
///////////////////////////////////////////////////////////////////////////
	{
	union
		{
		DWORD dVal;
		struct
			{
			WORD LSW;
			WORD MSW;
			};
		} checksum;

	BYTE *MSB, *LSB, i;
	WORD w;
	BYTE Current_Offset_MSB, Current_Offset_LSB;
	BYTE Current_ERDPTL, Current_ERDPTH;

	// get the current location in the MAC buffer
	BankSel(EWRPTL);
	Current_Offset_MSB = ReadETHReg(EWRPTH);
	Current_Offset_LSB = ReadETHReg(EWRPTL);
	Current_ERDPTL = ReadETHReg(ERDPTL);
	Current_ERDPTH = ReadETHReg(ERDPTH);

	// setup the ERDPTR to the buffer area containing the data of interest
	WriteReg(ERDPTL, LOW (Base));
	WriteReg(ERDPTH, HIGH (Base));
	
	// perform the checksum calculation
	i = Len >> 1;		// get the number of words
	LSB = (BYTE *)&w;
	MSB = LSB + 1;

	checksum.dVal = 0;
	while(i--)
		{
		*MSB = MACGet();
		*LSB = MACGet();
		checksum.dVal += (DWORD) w;
		}

	if (Len & 1)
		checksum.dVal += MACGet();

	while (checksum.MSW)
		{
		w = checksum.MSW;
		checksum.MSW = 0;
		checksum.dVal += (DWORD) w;
		}

	checksum.LSW = ~checksum.LSW;

	// Insert the checksum back into the data block
	WriteReg(EWRPTL, LOW ((Base + Checksum_Offset)));
	WriteReg(EWRPTH, HIGH ((Base + Checksum_Offset)));
	MACPut(checksum.LSW >> 8);
	MACPut(checksum.LSW);

	// restore the entry EWR and ERD pointers
	WriteReg(EWRPTL, Current_Offset_LSB);
	WriteReg(EWRPTH, Current_Offset_MSB);
	WriteReg(ERDPTL, Current_ERDPTL);
	WriteReg(ERDPTH, Current_ERDPTH);
	}



void ICMPEchoReply(MAC_ADDR *Target_MAC, IP_ADDR *Target_IP, BYTE *ICMP_ID, BYTE *ICMP_Seq)
	{
	#define ICMP_Hdr_Len 8
	#define ICMP_Hdr_Chksum_Offset 2
	#define ICMP_PAD 0
	WORD_VAL ICMP_Hdr_Base;

	MACPutHeader(Target_MAC, IP, IP_HDR_LEN + ICMP_Hdr_Len + ICMP_PAD);
	PutIPHeader(Target_IP, ICMP, IP_HDR_LEN + ICMP_Hdr_Len + ICMP_PAD);

	// get the current location in the MAC buffer
	// this is required to located position of the ICMP Checksum Field
	BankSel(EWRPTL);
	ICMP_Hdr_Base.MSB = ReadETHReg(EWRPTH);
	ICMP_Hdr_Base.LSB = ReadETHReg(EWRPTL);

	// output IP-ICMP message type (Echo Reply 0x0000)
	MACPut(0);
	MACPut(0);	

	// output null checksum **** to be replaced ****
	// note the checksum must be updated to include the
	// ICMP Identifier and Sequence number, . This is
	// required because the header checksum is loaded
	// before the parameters
	MACPut(0x00);
	MACPut(0x00);	

	// load the ICMP identifier
	MACPut(ICMP_ID[0]);
	MACPut(ICMP_ID[1]);

	// load the sequence
	MACPut(ICMP_Seq[0]);
	MACPut(ICMP_Seq[1]);

	// Normally padding would be performed to ensure
	// the packet meets the Ethernet minimum packet
	// length requirement however it is not necessary 
	// with the ENC28J60 as it has been configured to
	// automatically perform padding of undersize packets
	#if ICMP_PAD != 0
		{
		BYTE	i;
		for (i=0;i<ICMP_PAD;i++)
			MACPut('0' + i);
		}
	#endif

	// write the ICMP checksum
	PutTxChecksum(ICMP_Hdr_Base.Val, ICMP_Hdr_Len + ICMP_PAD, ICMP_Hdr_Chksum_Offset);

	// send the packet
	MACFlush();
	}



void PutUDP(MAC_ADDR *Target_MAC, IP_ADDR *Target_IP, WORD *Source_Port, WORD *Target_Port, WORD Mesg_Len, BYTE *Mesg)
	{
	WORD	i;

	PutMACHeader(Target_MAC, IP, IP_HDR_LEN + UDP_Hdr_Len + Mesg_Len);
	PutIPHeader(Target_IP, UDP, IP_HDR_LEN + UDP_Hdr_Len + Mesg_Len);

	// output the UDP Header source and destination port numbers
	MACPut(LOW (*Source_Port));
	MACPut(HIGH (*Source_Port));
	MACPut(LOW (*Target_Port));
	MACPut(HIGH (*Target_Port));

	// output the UDP section length
	i = Mesg_Len + UDP_Hdr_Len;
	MACPut(i >> 8);
	MACPut(i & 0xff);

	// output null checksum
	MACPut(0x00);
	MACPut(0x00);	

	// output the UDP payload
	MACPutArray(Mesg,Mesg_Len);

	// Normally padding would be performed to ensure
	// the packet meets the Ethernet minimum packet
	// length requirement however it is not necessary 
	// with the ENC28J60 as it has been configured to
	// automatically perform padding of undersize packets

	// send the packet
	MACFlush();
	}



void ARPReply(MAC_ADDR *Remote_MAC, IP_ADDR *Remote_IP)
	{
	MACPutHeader(Remote_MAC, ARP, ARP_Pkt_Len);

	// output Ethernet Hardware Type (0x0001)
	MACPut(0);
	MACPut(0x01);

	// output IP Protocol ID
	// Write the appropriate Ethernet Type WORD for the protocol being used
    MACPut(HIGH (IP));
    MACPut(LOW (IP));	

	// output the length of the MAC address and IP address fields
	MACPut(0x06);
	MACPut(0x04);	

	// output the ARP message type
	MACPut(HIGH (ARP_REPLY));
	MACPut(LOW (ARP_REPLY));

	// output LIA's MAC address
	MACPutArray(LIA_MAC,6);	

	// output LIA's IP address
	MACPutArray(LIA_IP,4);	

	// output destination MAC address
	MACPutArray((BYTE *)Remote_MAC,6);

	// output destination IP address
	MACPutArray((BYTE *)Remote_IP,4);

	// padding - not required as MACON3 setup to pad small packets
	//for (i=0;i<18;i++)
	//	MACPut(0);

	// send the packet
	MACFlush();
	}




WORD MACCalcTxChecksum(WORD base, WORD len)
///////////////////////////////////////////////////////////////////////////
// WORD MACCalcTxChecksum(WORD base, WORD len)
//
//	Initiate the ENC28J60 Checksum Calculation
//	using the internal DMA controller of the ENC
//
// Entry
//		offset	offset into the ENC memory for the start of the calculation
//		len		number of sequential bytes to be included in the calculation
//
// Exit
//		returns the checksum
//		retuns in bank 0
///////////////////////////////////////////////////////////////////////////
	{
	WORD_VAL x;
	BYTE y;
	BankSel(EDMASTL);

	WriteReg(EDMASTL, LOW (base));
	WriteReg(EDMASTH, HIGH (base));
	
	WriteReg(EDMANDL, LOW((base + len) & 0xFF));
	WriteReg(EDMANDH, HIGH((base + len) & 0xFF));
	
	BFSReg(ECON1, ECON1_DMAST | ECON1_CSUMEN);
	do
		y = ReadETHReg(ECON1);
	while(y & ECON1_DMAST);

	x.MSB = ReadETHReg(EDMACSH);
	x.LSB = ReadETHReg(EDMACSL);
	return x.Val;
	}




void ServiceENCRx(void)
///////////////////////////////////////////////////////////////////////////
// void ServiceENCRx(void)
//
//	Service the Ethernet controller receive buffer
///////////////////////////////////////////////////////////////////////////
	{
	BYTE 		i;
	MAC_ADDR 	RemoteMAC;
	IP_ADDR 	RemoteIP, TargetIP;
	IP_HEADER 	IP_Hdr;
	UDP_HEADER	UDP_Hdr;
	WORD 		type, ICMP_ID, ICMP_Seq, x;


	if (!MACGetHeader(&RemoteMAC, &type))
		return;

	#ifdef ldr_debug
		printf("Packet Received into NIC\r\n");
	#endif

	switch (type)
		{
		case ARP :
			// discard unneeded bytes
			// address space, protocol address space,
			// length of hardware address, length of
			// protocol address, opcode and the duplicate 
			// source MAC address
			MACSkip(14);	// skip ARP header information

			// Get the ARP Source IP address
			MACGetArray(RemoteIP, sizeof(IP_ADDR));

			// skip redundant Redundant Target MAC address field
			MACSkip(6);

			// get the Target IP address
			MACGetArray(TargetIP, 4);

			// Test the target IP address against the LIA
			// is this for the LIA?
			for (i = 0; (LIA_IP[i] == TargetIP[i]) && (i < 4); i++)
				;
			if (i==4)
				ARPReply(&RemoteMAC,&RemoteIP);

			#ifdef ldr_debug
				printf("ARP Processed\r\n");
			#endif
			break;

		case IP :
			// Fetch the IP packet header
			MACGetArray((BYTE *)&IP_Hdr, sizeof(IP_HEADER));				

			// Test the target IP address against the LIA
			// is this for the LIA?
			for (i = 0; (LIA_IP[i] == IP_Hdr.DestIPAddr[i]) && (i < 4); i++)
				;
			if (i != 4)
				{ 
				// here if not for the unicast address
				// test the multicast address
				for (i = 0; (LIA_MIP[i] == IP_Hdr.DestIPAddr[i]) && (i < 4); i++)
					;
				}

			#ifdef ldr_debug
					printf("destination IP = %u.%u.%u.%u\r\n",IP_Hdr.DestIPAddr[0],IP_Hdr.DestIPAddr[1],IP_Hdr.DestIPAddr[2],IP_Hdr.DestIPAddr[3]);
			#endif
				
			if (i==4)
				{
				switch (IP_Hdr.Protocol)
					{
					case ICMP :
						if (MACGet() == ECHO)
							{
							// skip ICMP code and ICMP checksum
							MACSkip(3);

							// get the ICMP session identifier and sequence number
							MACGetArray((BYTE *)&ICMP_ID, 2);
							MACGetArray((BYTE *)&ICMP_Seq, 2);
							ICMPEchoReply((MAC_ADDR *)&RemoteMAC, (IP_ADDR *)&IP_Hdr.SourceIPAddr, (BYTE *)&ICMP_ID, (BYTE *)&ICMP_Seq);
							}
						#ifdef ldr_debug
							printf("Processed ICMP Mesg\r\n");	
						#endif
						break;
					case UDP :
							// Fetch the UDP packet header
							MACGetArray((BYTE *)&UDP_Hdr, sizeof(UDP_HEADER));

							// get the inbound port this packet
							x = (UDP_Hdr.Dest_Port >> 8) + ((UDP_Hdr.Dest_Port << 8) & 0xff00);
							#ifdef ldr_debug
								printf("\r\nProcessed UDP Mesg received on port %4x\r\n",x);
							#endif

							if (x == CONTROL_PORT)
								{
								#ifdef ldr_debug
									printf("\r\nBOOTLOADER UDP CONTROL port mesg received on port %4x\r\n",x);
								#endif

								DoControl(&UDP_Hdr, &IP_Hdr.SourceIPAddr, &RemoteMAC);
								}

						break;




					default :
							#ifdef ldr_debug
								{
								puts("Unknown IP Procotol Mesg");
								printf("Source MAC ");
								for (i=0;i<6;i++)
									printf("%02x ",RemoteMAC[i]);
								printf("\r\nType = %4x\r\n",type);
								}
							#endif
						break;
					}
				}
			else
				{
				#ifdef ldr_debug
					{
					printf("IP Mesg - NOT FOR THIS LIA\r\n");
					printf("Source MAC ");
					for (i=0;i<6;i++)
						printf("%02x ",RemoteMAC[i]);
					printf("\r\nType = %4x\r\n",type);
					}
				#endif
				}
			break;

		default:
			#ifdef ldr_debug
				{
				printf("Unknown packet type\r\n");
				printf("Source MAC ");
				for (i=0;i<6;i++)
					printf("%02x ",RemoteMAC[i]);
				printf("\r\nType = %4x\r\n",type);
				}
			#endif
			break;
		}

	MACDiscardRx();		// skip_frame
	}


void generate_MAC(void)
///////////////////////////////////////////////////////////////////////////
// void generate_MAC(void)
//
//	Generates a pseudo random MAC address combining the predefined OUI and
//	a three byte random value
//
//	Revision History
//		21/03/009	Modified to support PICs with less than 6 timers
///////////////////////////////////////////////////////////////////////////
	{
	WORD offset,j;
	BYTE i, *ptr = 0x0;

	LIA_MAC[0] = OUI_1;
	LIA_MAC[1] = OUI_2;
	LIA_MAC[2] = OUI_3;

	#ifdef TMR6
		LIA_MAC[3] ^= TMR6 & 0xff;
	#else
		LIA_MAC[3] ^= TMR3 & 0xff;
	#endif

	#ifdef TMR7	
		LIA_MAC[4] ^= TMR7 & 0xff;
	#else
		LIA_MAC[4] ^= TMR4 & 0xff;
	#endif

	#ifdef TMR8	
		LIA_MAC[5] ^= TMR8 & 0xff;
	#else
		LIA_MAC[5] ^= TMR5 & 0xff;
	#endif

	// generate the next three bytes of the MAC address
	// by XORing three 256 byte pages of RAM, one page per byte
	for (i=3; i<6; i++)
		{
		for (j=0;j<255;j++)
			LIA_MAC[i] ^= *ptr++;
		LIA_MAC[i+1] = LIA_MAC[i];
		}

	// now save the new MAC address
	// now update the Program Flash
	// point to the LIA's MAC address in Program Memory
	MirrorBlock((P_MAC >> 16),P_MAC);
	offset = ((P_MAC & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);
					
	// modifing the MAC address in the shadow block
	Shadow[offset++] = LIA_MAC[0];
	Shadow[offset++] = LIA_MAC[1];
	offset++;
	offset++;
	Shadow[offset++] = LIA_MAC[2];
	Shadow[offset++] = LIA_MAC[3];
	offset++;
	offset++;
	Shadow[offset++] = LIA_MAC[4];
	Shadow[offset++] = LIA_MAC[5];
	WriteBlock((P_MAC >> 16),P_MAC);
	}



void init_addr(void)
///////////////////////////////////////////////////////////////////////////
// void init_addr(void)
//
//	Initialises the Network Addresses and the
//	Extracts from the Program Memory the the LIA's default
//	Multicast IP address, MAC address, Control Port numbers	
//
// Entry:
//
// Exit:
//	LIA_IP	Initialilised from Program Memory
//	LIA_MIP	Initialilised from Program Memory
//	LIA_MAC	Initialilised from Program Memory
//	LIA_CP	Initialilised from Program Memory
///////////////////////////////////////////////////////////////////////////
	{
	WORD w;

	// Read the LIA's MAC address from the parameter table
	TBLPAG = (P_Def_IP >> 16) & 0xff;
	w = __builtin_tblrdl(P_Def_IP & 0xffff);
	LIA_IP[0] = w & 0xff;
	LIA_IP[1] = (w >> 8) & 0xff;
	w = __builtin_tblrdl((P_Def_IP+2) & 0xffff);
	LIA_IP[2] = w & 0xff;
	LIA_IP[3] = (w >> 8) & 0xff;

	// Read the LIA's MAC address
	TBLPAG = (P_MAC >> 16) & 0xff;
	w = __builtin_tblrdl(P_MAC & 0xffff);
	LIA_MAC[0] = w & 0xff;
	LIA_MAC[1] = (w >> 8) & 0xff;
	w = __builtin_tblrdl((P_MAC+2) & 0xffff);
	LIA_MAC[2] = w & 0xff;
	LIA_MAC[3] = (w >> 8) & 0xff;
	w = __builtin_tblrdl((P_MAC+4) & 0xffff);
	LIA_MAC[4] = w & 0xff;
	LIA_MAC[5] = (w >> 8) & 0xff;

	// test the first byte to ensure the MAC address has been initialized
	if (LIA_MAC[0] == 0xff)
		generate_MAC();

	} // End of init_Addr


void EE_Erase(void)
///////////////////////////////////////////////////////////////////////////
// void EE_Erase(void)
//
// dummy handler
///////////////////////////////////////////////////////////////////////////
	{
	}



void SetIP(void)
///////////////////////////////////////////////////////////////////////////
// void SetIP(void)
//
// set the IP address of the LIA and update the IP address in program memory
///////////////////////////////////////////////////////////////////////////
	{
	WORD	offset;

	// get the IP address from the Ethernet controller
	MACGetArray((BYTE *)LIA_IP, sizeof(IP_ADDR));

	// here we have updated the LIA IP address
	// now update the Program Flash
	// point to the LIA's IP address in Program Memory
	MirrorBlock((P_Def_IP >> 16),P_Def_IP);
	offset = ((P_Def_IP & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);
					
	// modify the IP address in the shadow block
	memcpy((void *)&Shadow[offset], (void *) LIA_IP, sizeof(IP_ADDR));
	Shadow[offset++] = LIA_IP[0];
	Shadow[offset++] = LIA_IP[1];
	offset++;
	offset++;
	Shadow[offset++] = LIA_IP[2];
	Shadow[offset++] = LIA_IP[3];
	WriteBlock((P_Def_IP >> 16),P_Def_IP);

	} // end of SetIP


BOOLEAN DoCstatus(UDP_HEADER* UDP_Hdr, IP_ADDR* RemoteIP, MAC_ADDR* RemoteMAC)
// *************************************************************************
// BOOLEAN DoCstatus(UDP_HEADER* UDP_Hdr, IP_ADDR* RemoteIP, MAC_ADDR* RemoteMAC)
//
//	Transmit the control status
//
//	UDP PAYLOAD FORMAT
//	Parameter		Size	Comment
//	*********		****	*******
//	LIA_TAG			2		0x5AA5 fixed flag
//	Target_ID		2		0x0000 for traffic from LIA to host
//							0x0000 for status command from host to LIA
//							LIA_ID target LIA for this command
//	Control_seq		2		Control PDU sequence from host command packet
//	Command			1		LIA command byte (see DoControl)
//	Product_ID		1		LIA product identifier - currently 0x01
//	HW_version		1		Major / Minor version 4 bits each
//	SW_Version		1		Major / Minor version 4 bits each
//	LIA_ID			2		Unique ID 0x0001 to 0xFFFF
//	IP_addr			4		User configurable IP address
//	LIA_State		2		LIA status Word
//	Data_Seq		1		Next Data Sequence Number to be used for data traffic
//
// Entry
//	CP_Seq		Entry CP sequence number
//	CP_Cmd		Entry CP command
//	CP_VarLen	Variable length of the command payload
//
// Exit
//  Returns TRUE on success
///////////////////////////////////////////////////////////////////////////
	{
	char mesg[CP_payload_len];

	// LIA Tag
	mesg[0] = 0x5a;	
	mesg[1] = 0xa5;

	// target ID always 0 to the host
	mesg[2] = 0;
	mesg[3] = 0;

	// Entry command sequence number from remote
	mesg[4] = CP_Seq & 0xff;
	mesg[5] = (CP_Seq >> 8) & 0xff;

	// remote command received
	mesg[6] = CP_Cmd;

	// product ID and version number
	mesg[7] = ProductID;
	mesg[8] = HWver;
	mesg[9] = SWver;

	// LIA (LAN Adapter ID)
	mesg[10] = LIA_ID & 0xff;
	mesg[11] = (LIA_ID >> 8) & 0xff;

	// Unicast IP address
	mesg[12] = LIA_IP[0];
	mesg[13] = LIA_IP[1];
	mesg[14] = LIA_IP[2];
	mesg[15] = LIA_IP[3];

	// status information
	mesg[16] = State.All & 0xff;
	mesg[17] = (State.All >> 8) & 0xff;

	// data sequence number
	mesg[18] = Data_Seq & 0xff;
	mesg[19] = (Data_Seq >> 8) & 0xff;

	PutUDP(RemoteMAC, RemoteIP, (WORD*)&UDP_Hdr->Dest_Port, (WORD*)&SA_UDP, (WORD) CP_payload_len, (BYTE*)mesg);

	return(TRUE);
	}


BOOLEAN NewCode(void)
///////////////////////////////////////////////////////////////////////////
// BOOLEAN NewCode(void)   
//	routine to load and program the new code
//
// Modified from original code to support fixed length Encrypted hex
// records. Each PDU contains a fully self contained intex hex record
// padded to a fixed length
//
// Entry:	
//	IP_Len+1	0
//	IP_Len	length of the UDP payload includes the 7 byte overhead
//		of the command packet
//	Realtek	Next byte to read is the new record payload
//
// Exit	
//	State 	Flags set indicating status of the operation
///////////////////////////////////////////////////////////////////////////
	{
	BYTE __attribute__((aligned (4))) PDU[24];
	BYTE i,x,y,checksum;
	BYTE *ptr;
	HEX_RCD *record;
	WORD w;

	// point to the hex record structure
	record = (HEX_RCD*)PDU;

	// get the UDP payload
	MACGetArray(PDU, 24);

	#ifdef debug_cipher
		printf("NewCode: Encrypted = ");
		for (i=0;i<24;i++)
			printf("%02X",PDU[i]);
		printf("\r\n");
	#endif

	// decipher the intel hex record
	decipher(XTEA_ITERATIONS, (DWORD*) &PDU[0], (DWORD*)key);
	decipher(XTEA_ITERATIONS, (DWORD*) &PDU[8], (DWORD*)key);
	decipher(XTEA_ITERATIONS, (DWORD*) &PDU[16], (DWORD*)key);

	#ifdef debug_cipher
		printf("NewCode: Decrypted = ");
		for (i=0;i<24;i++)
			printf("%02X",PDU[i]);
		printf("\r\n\r\n");
	#endif

	// get the record length and initialize the checksum
	ptr = PDU;
	if (*ptr > 16)
		{
		State.LdrLenErr = 1;
		return(FALSE);
		}
	checksum = *ptr++;

	// get the destination address and update checksum
	x = *ptr++;
	checksum += x;
	y = *ptr++;
	checksum += y;

	// get the record type
	x = *ptr++;
	checksum += x;

	// calculate the data checksum
	for (i = 0; i < record->len; i++)
		checksum += *ptr++;

	// get the checksum from the record
	x = *ptr;
	checksum += x;
	record->crc = checksum;

	if (checksum)
		{
		#ifdef ldr_debug
			printf("ParseHexRecord: Checksum error. Checksum= %02X\r\n", checksum);
		#endif
		State.ChkSumErr = 1;
		return(FALSE);
		}

	// here we have a valid intel hex record
	// test for data record
	switch (record->type)
		{
		case 0:
			// status information State.xxx updated in PGM_write()
			AbsAddr.byte.HB = record->addrHi;
			AbsAddr.byte.LB = record->addrLo;
			PGM_write(AbsAddr, (char*)&record->data[0], record->len);
			break;

		case 4:
			// initialise the AbsAddr.HW pointer
			AbsAddr.byte.MB = record->data[0];
			AbsAddr.byte.UB = record->data[1];
			T4_Mode = 0;				// initialize the type 4 mode (** NOT USED **)
			T4_PGM = 1;
			State.PrgRcdDn = 1;			// Done programming this record
			// note used T4_Error
			break;

		case 1:
			// here we have reached the end of the load
			// check the UserJump vector is not empty
			// then set the CodeState flag

			// flush the current shadow block
			if(ShadowDirty)
				WriteBlock(ShadowPage, ShadowBaseAddr);						

			// sample to read the users reset vector
			if (UserVectorPresent())
				{
				// here if the user vector has been installed
				// we have a valid end of record
				// clear the code state
				MirrorBlock((CodeState >> 16),CodeState);
				w = ((CodeState & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);
					
				// modifing CodeState
				Shadow[w++] = 0x00;
				Shadow[w++] = 0x00;
				WriteBlock((CodeState >> 16),CodeState);
				#ifdef ldr_debug
					printf("PIC programming done\r\n");
				#endif
			
				#ifdef LED_PIC_PGM
					LED_PIC_PGM = 0;
				#endif
				State.PrgDone = 1;		// flag programming completed
				State.No_Code = 0;		// Clear the no code flag
                State.RstVector = 0;	// Clear the no reset vector flag
				break;
				}
			else
				return (FALSE);
			break;

		default:
			#ifdef ldr_debug
				printf("PGM_PIC: Invalid record discarded\r\n");
			#endif
			State.Type_Err = 1;
			return(FALSE);
			break;
		}
	return(TRUE);
	}




BOOLEAN DoControl(UDP_HEADER* UDP_Hdr, IP_ADDR* RemoteIP, MAC_ADDR* RemoteMAC)
///////////////////////////////////////////////////////////////////////////
// BOOLEAN DoControl(UDP_HEADER* UDP_Hdr, IP_ADDR RemoteIP, MAC_ADDR RemoteMAC)
//
//	Processed the control channel commands
//
//	COMMAND FORMAT
//	Command			  Value		Size	Comment
//	*******			  *****		****	*******
//	CP_Status			0		 7		Show status (see DoCstatus)	
//	CP_SetIP			1		11		Set IP address
//	CP_Invalidate		2		 7		Invalidate User Program Area
//	CP_LDR_Mode			3		 7		Put LIA into Loader State
//	CP_New_Code			4		15 to x	New code to store
//	CP_Dump				5		 7		Dump user memory and EEPROM
//	CP_Erase			6		 7		Erase Program Memory and EEPROM
//	CP_Erase_PGM		7		 7		Erase Program Memory only
//	CP_Erase_EE			8		 7		Erase EEPROM only
//	CP_Reset			9		 7		Reboot the LIA
//
// Entry
//	UDP_Header	points to the UDP header for the received packet
//	RemoteIP	remote IP address
//	RemoteMAC	remote MAC address
//
// Exit
//	returns TRUE on success
//	CP_Cmd	set to the source packet CP command
//	CP_Seq[]	set to the source packet CP sequence
///////////////////////////////////////////////////////////////////////////
	{
	WORD len;
	WORD ID, w;

	// here we have a UDP packet

	// Copy IP_SP to Host_CP
	// ** NOTE BIG ENDIAN FORMAT **
	SA_UDP = UDP_Hdr->Source_Port;

	// get the payload length
	len = ((UDP_Hdr->UDP_Len << 8) | (UDP_Hdr->UDP_Len >> 8)) - sizeof(UDP_HEADER);

	// test to ensure the payload length is >= 7  & <= 31
	if ((len < 7) || (len > 31))
		{
		// DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
		return(FALSE);
		}

	// here we have a valid length control payload
	// we may be able to dump the preceeding length test
	// test for Control 'key' - 5A A5
	if (MACGet() != 0x5a)
		{
		// DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
		return(FALSE);
		}

	if (MACGet() != 0xa5)
		{
		// DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
		return(FALSE);
		}

	// here on a valid key
	// key the target LIA ID
	ID = (MACGet() & 0xff);
	ID |= ((MACGet() << 8) & 0xff00);

	// get code port sequence number
	MACGetArray((BYTE*)&CP_Seq, sizeof(WORD));

	// get the command
	CP_Cmd = MACGet();

	// printf("** DoControl: CP_Cmd = %u\r\n",CP_Cmd);
	// test if command address is null
	// if null then ignore rest of packet and handle as status request
	if(ID == 0)
		{
		DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
		return(TRUE);
		}

	// test if ID matches this LIA		
	if (ID != LIA_ID)
		return(FALSE);

	// parse the command and pass control to the command handler
	switch (CP_Cmd)
		{
		case CP_SetIP :
			if (len == 11)
				{
				SetIP();
				DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
				return(TRUE);
				}
			else
				{
				DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
				return(FALSE);
				}

		case CP_Status :
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			return(TRUE);

		case CP_Invalidate :
			// invalidate the contents of the user program space
			// determine if the LIA is in LDR_Mode
			if (!State.LDR_Mode)
				{
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
				return(FALSE);
				}
			MirrorBlock((CodeState >> 16),CodeState);
			w = ((CodeState & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);
					
			// example modifing CodeState
			Shadow[w++] = 0x00;
			Shadow[w++] = 0x00;
			WriteBlock((CodeState >> 16),CodeState);
			State.No_Code = 1;			// Clear the no code flag
			State.RstVector = 1;		// flag waiting for RstVector record
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			return(FALSE);

		case CP_LDR_Mode :
			// Put LIA into Loader State
			State.LDR_Mode = 1;
			T2CONbits.TON = 0;			// Stop the bootloader capture timer
			IFS0bits.T2IF = 0; 			// clear the timer roll-over interrupt flag
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			AbsAddr.Val = 0;			// initialize bootloader absolute address
			return(TRUE);

		case CP_New_Code :
			//printf("At CP_New_Code\r\n");
			// determine if the LIA is in LDR_Mode
			if (!State.LDR_Mode)
				{
				State.Ldr_Err = 1;
				DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
				State.Ldr_Err = 0;
				// printf("CP_New_Code: ** Not in Loader Mode\r\n");
				return(FALSE);
				}

			// test to determine the UDP payload length == 31 (includes 7 byte control overhead)
			if (len != 31)
				{
				State.LdrLenErr = 1;
				DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
				State.LdrLenErr = 0;
				// printf("CP_New_Code: ** Length Error, len = %u\r\n",len);
				return(FALSE);
				}
	
			// process the record
			if (NewCode())
				{
				DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command			
				State.Type_Err = 0;			// clear record type error flag
				State.Ldr_FErr = 0;			// clear framing error flag
				State.ID_Rcd = 0;			// clear ID and Configuration record skipped
				State.ChkSumErr = 0;		// clear record checksum error flag
				State.HiAddrErr = 0;		// clear loader address conflict error
				State.PrgRcdDn = 0;			// clear finished programing current record
				State.PrgDone = 0;			// clear programming completed flag
				State.WR_EEPROM = 0;		// clear written to EEPROM
				State.T4_Error = 0;			// clear missing type 4 record error flag
				return (TRUE);
				}
			return(FALSE);

		case CP_Dump :
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			State.Rd_Done = 0;
			return(FALSE);

		case CP_Erase_EE :				// Erase EEPROM only
		case CP_Erase :					// erase PGM and EEPROM
		case CP_Erase_PGM :				// Erase PGM memory only
			if (!State.LDR_Mode)
				{
				State.Ldr_Err = 1;
				DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
				State.Ldr_Err = 0;
				return(FALSE);
				} 

			// erase EEPROM if required
			if (CP_Cmd != CP_Erase_PGM)	// erase EEPROM
				{
				EE_Erase();
				T4_Mode = 0;			// initialise the type 4 record processsing mode
				}

			// erase program memory if required
			if ((CP_Cmd == CP_Erase) || (CP_Cmd == CP_Erase_PGM))
				{
				PGM_Erase();
				T4_Mode = 0;			// initialise the type 4 record processsing mode
				State.No_Code = 1;		// Clear the no code flag
				State.RstVector = 1;	// flag waiting for RstVector record
				}
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			return(TRUE);

		case CP_Reset :
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			delay_ms(100);
			reset_cpu();
			return(TRUE);

		default :
			#ifdef ldr_debug
				printf("** DoControl: Unknown command = %u\r\n",CP_Cmd);
			#endif
			DoCstatus(UDP_Hdr, RemoteIP, RemoteMAC);	// execute the status command
			return(FALSE);
		}
	}	// end of DoControl


int main(void)
	{
	BYTE i;

	#if defined USE_CLOCK_INIT
		clockInit();
	#endif

	// disable interrupts
	__asm__ volatile("disi #0x3FFF");
	INTCON2 = 0;
	IEC0 = 0;
	IEC1 = 0;
	IEC2 = 0;
	IEC3 = 0;
	IEC4 = 0;

	// use CONSOLE serial port for STDIO
	__C30_UART = CONSOLE_UART;

	// initialise the I/O subsystem - leaves the ENC28J60 in hardware reset
	init_pic();
	restart_wdt();

	// initialise the network addresses from Program Memory
	// LIA_MAC, LIA_IP ** MUST BE DONE EARLY **
	init_addr();


	// Setup the UART
	init_CONSOLE(); 
	CONSOLE_RXIP = 4;	// set console interrupt priority to 4


	// Setup the timer 1 for 1ms
	PR1 = FCY/1000-1;
	IPC0bits.T1IP = 0;				// disable interrupt
	T1CON = 0b1000000000000000;
		// prescaler 1:1
		// internal clock (Fosc/2)
		// timer on
		// 16 bit mode
	IFS0bits.T1IF = 0;		// clear timer 1 interrupt flag

	// Setup the timer 2 for 1ms rollover
	PR2 = FCY/1000-1;
	IEC0bits.T2IE = 0;				// disable timer 2 interrupts 
	T2CON = 0b0000000000000000;
		// prescaler 1:1
		// internal clock (Fosc/2)
		// timer off
		// 16 bit mode
	IFS0bits.T2IF = 0;		// clear timer 2 interrupt flag


	#ifdef LED_LDR_MODE
		// indicate we are in bootloader mode
		LED_LDR_MODE = 1;
	#endif

 	// initialise status information
	State.All = 0;		// initialise the bootloader state

	#ifdef LED_Status
		// send an "I'm alive" LED toggle
		for (i=0; i<3; i++)
			{
			#ifdef LED_Status_NEG
				LED_Status=0;
				delay_ms(300);
				LED_Status=1;
				delay_ms(300);
			#else
				LED_Status=1;
				delay_ms(300);
				LED_Status=0;
				delay_ms(300);
			#endif
			}
	#endif

	#ifdef ldr_debug
		printf("\r\n\r\nBrush Electronics' PIC24/dsPIC Ethernet Bootloader\r\n%s %s %s\r\n\r\n",
	       "Version 0.1 - compiled", __DATE__,__TIME__);
	#endif


	// setup Status LED Toggle counter
	StatusLEDCount = CStatusLEDCount;
	TMR_Activity = CTMR_Activity;

	// setup Busy LED Toggle counter
	BusyLEDCount = CBusyLEDCount;

	// setup Status LED Toggle counter
	HealthLEDCount = CHealthLEDCount;


	// @@@ TO BE REMOVED @@@ set the SA_MAC to the MAC broadcast address
	memset ((void *)SA_MAC, 0xff, sizeof(MAC_ADDR));	

	// copy the SA_IP from the LIA's IP address	
	memcpy ((void *)SA_IP, (void *) LIA_IP, sizeof(IP_ADDR));

	// initialise the LIA ID from 2 LSB of MAC address
	LIA_ID = (WORD)(LIA_MAC[4] << 8) | LIA_MAC[5];


	// initialise the Ethernet controller
	#ifdef ldr_debug
		printf("Initialising Ethernet controller\r\n");
	#endif
	init_ENC(LIA_MAC);

	// wait to enable link to become active
	for (i = 0; i < 4; i++)
		delay_ms(250);

	#ifdef ldr_debug
		if(LinkStatus())
			printf("Ethernet controller ready\r\n");
		else
			printf("Link not active\r\n");
	#endif


	SA_UDP = (CONTROL_PORT >> 8) | ((CONTROL_PORT & 0xff) << 8);

	// initialise the target MAC
	for (i=0; i<6; i++)
		SA_MAC[i] = 0xff;

	// wait for network devices (switches and routers)
	delay_ms(250);
	delay_ms(250);
	delay_ms(250);
	delay_ms(250);

	// gratuitous ARP
	ARPReply((MAC_ADDR *) &SA_MAC, (IP_ADDR *) &LIA_IP);

	// OK, everything in order
	T4_Mode	= 0; 				// initiaise the type 4 record processsing mode
	Data_Seq = 0;				// initialise the data sequence counter LIA -> Host
	CP_VarLen = 0;				// clear the Control Packet varialbe character count
	AbsAddr.Val = 0;			// initialize bootloader absolute address


	// gratuitous ARP
	ARPReply(&Broadcast_MAC, &LIA_IP);
	#ifdef LED_Busy
		LED_Busy_On = 1;
	#endif

	#ifdef LED_LDR_MODE
		// indicate we are leaving bootloader mode
		LED_LDR_MODE = 0;
	#endif

	#ifdef ldr_debug
		printf("IP address  = %u.%u.%u.%u\r\n", LIA_IP[0], LIA_IP[1],LIA_IP[2],LIA_IP[3]);
		printf("MAC address = %02X:%02X:%02X:%02X:%02X:%02X\r\n", LIA_MAC[0], LIA_MAC[1],
			LIA_MAC[2], LIA_MAC[3],LIA_MAC[4], LIA_MAC[5]);
	#endif

	// If valid code is present the Loader will delay
	// Ldr_Cmd_Delay ms for a Loader Command before
	// jumping to the User's Program
	// if the LSB CodeState = 0 (valid user code space) then start 5 second timer
	if (UserVectorPresent() && CodeStateValid())
		{
		#ifdef ldr_debug
			printf("User Vector Present & Code State Valid\r\n");
			delay_ms(10);
		#endif

		// here we have enabled the Loader Command Timer if user code is present
		T2CONbits.TON = 1;	// Start the timer

		// initialise the Loader Command Delay Counter
		Ldr_Dly = Ldr_Cmd_Delay;
		}
	else
		{
		State.No_Code = 1;		// Invalid code in user code space
		State.LDR_Mode = 1;		// **** PUT IN LDR MODE ****
		#ifdef ldr_debug
			printf("Invalid code in user code space\r\n");
			delay_ms(10);
		#endif
		}


	//ExecLoop
	for (;;)
		{

		// if 5 second timer elapsed (CodeState = 0) then
		//     boot user program
		// else
		//     execute loader code

		// test the timer roll-over interrupt flag
		if (IFS0bits.T2IF)
			{
			IFS0bits.T2IF = 0; 				// clear the timer roll-over interrupt flag
			if (!--Ldr_Dly)					// Loader Delay Counter
				{
				// here if we have exceeded the Loader Boot Delay waiting for a loader command
				// clear the status LED and go boot the user program
				#ifdef	LED_Status
 					 #ifdef	LED_Status_Neg
						LED_Status = 1;			// turn off Status LED
					 #else
						LED_Status = 0;			// turn off Status LED
 					 #endif
				#endif


				#ifdef LED_LDR_MODE
					// indicate we are leaving bootloader mode
					LED_LDR_MODE = 0;
				#endif
				UserExec(UserJump);			
				}
			}

		ServiceSystemTimer();

		// service the Ethernet Controller Receive buffer
		ServiceENCRx();
		}
	}


/*****************************************************************************
  Function:
        static void clockInit(void)
  Summary:
        Changes to the pll clock source to achieve 40 mips
  Description:
        Call first after power on to switch from non-PLL EC.
        It changes the multiplier and two dividers to allow
        for 10MHz input to produce 80MHz (2*Fcy)
 ***************************************************************************/
#if defined USE_CLOCK_INIT
	static void clockInit(void)
	{
	    PLLFBD = 0x1E; // M=32
	    CLKDIVbits.PLLPOST = 0; // N2 = 2
	    CLKDIVbits.PLLPRE = 0; // N1 = 2
	    __builtin_write_OSCCONH(0x03); // Select Pri/PLL clock
	    __builtin_write_OSCCONL(0x01); // Request clock switch
	    while (OSCCONbits.COSC != 0b011); // Wait for oscillator to switch
	}
#endif
