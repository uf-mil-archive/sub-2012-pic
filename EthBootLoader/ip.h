//////////////////////////////////////////////////////////////////////////
//	ip.h include file Ethernet Bootloader
//
//	Copyright 2009 Andrew Smallridge
//
//	Revision History
//		27/01/09	initial build
//////////////////////////////////////////////////////////////////////////
//	IP Protocol and Packet Type Definitions

#define	IP_ver4	4	; supported IP version

//	Protocol Type
#define	IP	0x0800
#define	ARP	0x0806
#define ARP_REQUEST 0x0001
#define ARP_REPLY 	0x0002
//#define MAC_UNKNOWN 0x0ffff

//	Transport Layer Contents
#define	ICMP	 1
#define	TCP	 6
#define	UDP	17

// Default Protocol Header Lengths
#define ICMP_Hdr_Len 8
#define ARP_Pkt_Len 28
// #define ARP_Pkt_Len 46	// value used when MAC cannot PAD automatically
#define UDP_Hdr_Len 8
#define IP_Hdr_Len 20

//	ICMP message types
#define	ECHO	0x08	// PING
#define	REPLY	0x00	// PING reply

//	TCP packet types
#define	TCP_FIN	0x01
#define	TCP_SYN	0x02
#define	TCP_RST	0x04
#define	TCP_PSH	0x08
#define	TCP_ACK	0x10
#define	TCP_URG	0x20

// Ethernet / IP data types
typedef	BYTE MAC_ADDR[6];
typedef	BYTE IP_ADDR[4];
typedef	WORD IP_PORT;

// Duplex configuration options
typedef enum _DUPLEX {
	HALF = 0, 
	FULL = 1, 
	USE_PHY = 2
} DUPLEX;

typedef struct _ETHER_HEADER
	{
    MAC_ADDR        DestMACAddr;
    MAC_ADDR        SourceMACAddr;
    WORD	        Type;
	} ETHER_HEADER;

typedef struct _IEEE_HEADER
	{
    MAC_ADDR        DestMACAddr;
    MAC_ADDR        SourceMACAddr;
    WORD        	Len;
    BYTE            LSAPControl[3];
    BYTE            OUI[3];
    WORD		    Protocol;
	} IEEE_HEADER;


typedef struct _IP_HEADER
	{
	BYTE			Ver_Flags;
	BYTE			TOS;
	WORD			IP_Len;
	WORD			ID;
	WORD			Flags_Frag;
	BYTE			TTL;
	BYTE			Protocol;
	WORD			Checksum;
    IP_ADDR        	SourceIPAddr;
    IP_ADDR 	    DestIPAddr;
	} IP_HEADER;


typedef struct _MCP_MAC_PREAMBLE
	{
    WORD			NextPacketPointer;
    RXSTATUS		StatusVector;
	} MCP_MAC_PREAMBLE;

typedef struct _UDP_HEADER
	{
	WORD		Source_Port;
	WORD		Dest_Port;
	WORD		UDP_Len;
	WORD		UDP_Checksum;
	} UDP_HEADER;

MCP_MAC_PREAMBLE MAC_preamble;
ETHER_HEADER MAC_header;


