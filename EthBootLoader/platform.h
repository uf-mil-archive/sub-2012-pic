//////////////////////////////////////////////////////////////////////////
//	Platform.h Project Header File for the ENC Ethernet Bootloader
//	MCHP C30 Specific file for the PIC24 series
//
//	This file contains system and target specific configuration
//	The original hardware was the Explorer 16 with the 
//	PIC24FJ128GA010, PIC24HJ256GA610 and dsPIC33FJ256GP710
//
//	The Ethernet interface is via a ENC PICTail installed in
//	the top slot of J5
//
//	SPI1 is used to communicate with the ENC card
//
//		Copyright (c) 2008-2009, Andrew Smallridge
//
// 	Revision History
//		03/02/09 ported from SD_24F_NO_XEE and EBLPX bootloaders
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//		Select the target platform
//////////////////////////////////////////////////////////////////////////
#define BDCMC

///////////////////////////////////////////////////////////////////////////
//		Specify the debug code to be included
///////////////////////////////////////////////////////////////////////////
//#define DEBUG_PGM_XEE		// Debug XEE programming
//#define DEBUG_PGM_PIC		// Debug PIC programming
//#define DEBUG_PGM_write	// Debug PIC PGM write process
//#define DEBUG_PARSE_HEX	// Debug parsing the hex records
//#define DEBUG_SHADOW		// Debug shadow block processing
//#define DEBUG_WRITE		// Debug write to program memory
//#define DEBUG_ERASE		// Debug PIC Erase block

//////////////////////////////////////////////////////////////////////////
//		DEFINE PLATFORM SPECIFIC EQUATES
//////////////////////////////////////////////////////////////////////////
#if defined BDCMC

	#ifndef __dsPIC33FJ128MC804__
		#error "Hardware Profile for selected processor does not exist"
	#endif // Allowable processors

	// Don't forget to call clockinit for this board! This configures
	// the dspic33f to use a 10MHz clock and get 40MIPs
	#define USE_CLOCK_INIT
	
	#define XTAL_FREQ 		10000000
	#define PLLMODE			8
	
	#define AD1PCFGL_Def	0xFFF0	// Default Analog pin configuration
	
	#define CONSOLE_BAUDRATE	115200
	
	// Define UART I/O
	#define CONSOLE_UART 		2

	// Map RP's properly
	#define USE_IO_MAPPING	
	// UART RP
	#define UART2_RX_RP			21
	#define UART2_TX_RPR		RPOR3bits.RP7R	
	// ENCSPI RP
	#define SPI2_SDI_RP			24
	#define SPI2_CLK_RPR		RPOR11bits.RP22R
	#define SPI2_SDO_RPR		RPOR11bits.RP23R

	///////////////////////////////////////////////////////////////////////////
	//		Default I/O configuration
	///////////////////////////////////////////////////////////////////////////
	#define	PA_DefData		0b0000011100011000
	#define	PA_DefTRIS		0b1111100011100111
		//	10		LED
		//	9		EROM_WP
		//	8		DAC_CS
		//	4		EROM_CS
		//	3		DA_LD
	

	#define	PB_DefData		0b0000001100000000
	#define	PB_DefTRIS		0b0000000001111111
		//	15	PWM		Turn this off!
		//	14	PWM		Turn this off!
		//	13	PWM		Turn this off!
		//	12	PWM		Turn this off!
		//	11	PWM		Turn this off!
		//	10	PWM		Turn this off!
		//	9	ENC_CS	
		//	8	ENC_RESET
		//	7	CONSOLE TX
		//	4	EROMSPI_SDI	

	#define	PC_DefData		0b0000000000000000
	#define	PC_DefTRIS		0b1111111100100111	
		//	8		ENCSPI_SDI	
		//  7		ENCSPI_SDO	
		//  6 		ENCSPI_CLK	
		//	5		CONSOLE RX
		// 	4		EROMSPI_SDO
		//	3		EROMSPI_CLK

	///////////////////////////////////////////////////////////////////////////
	// define ENC SPI bus low and high speed prescalars
	///////////////////////////////////////////////////////////////////////////
	#define ENC_SPI_PRESCALE_PRI 2  	// Primary Scaler = 1:2
	#define ENC_SPI_PRESCALE_SEC 7		// Secondary Scaler = 1:1
	#define ENC_SPI_PORT	2
	#define	ENC_CS			LATBbits.LATB9	// ENC Chip Select Active low

	///////////////////////////////////////////////////////////////////////////
	//		Status LEDs
	///////////////////////////////////////////////////////////////////////////
	#define LED_Status			LATAbits.LATA10
	#define LED_Status_TRIS		TRISAbits.TRISA10
	#define LED0 				LED_Status
	#define LED0_TRIS 			LED_Status_TRIS

#endif // BDCMC platform

///////////////////////////////////////////////////////////////////////////
//		End of platform specific definititions
///////////////////////////////////////////////////////////////////////////

#define FCY					XTAL_FREQ*PLLMODE/2			// Instruction Cycle Frequency
#define SYSCLK        	 	XTAL_FREQ*PLLMODE
#define CONSOLE_REG 		SYSCLK/8/CONSOLE_BAUDRATE	// -1

///////////////////////////////////////////////////////////////////////////
//		Map the console port
///////////////////////////////////////////////////////////////////////////
#if CONSOLE_UART == 1
	#define CONSOLE_BRG		U1BRG
	#define CONSOLE_MODE	U1MODE
	#define CONSOLE_STA		U1STA
	#define CONSOLE_UARTEN	U1MODEbits.UARTEN
	#define CONSOLE_TXEN	U1STAbits.UTXEN
	#define CONSOLE_TXREG	U1TXREG
	#define CONSOLE_UTXBF	U1STAbits.UTXBF
	#define CONSOLE_RXIF	IFS0bits.U1RXIF
	#define CONSOLE_OERR	U1STAbits.OERR
	#define	CONSOLE_RXREG	U1RXREG
	#define CONSOLE_RXIP	IPC2bits.U1RXIP
	#define CONSOLE_RXIE	IEC0bits.U1RXIE
#else
	#define CONSOLE_BRG		U2BRG
	#define CONSOLE_MODE	U2MODE
	#define CONSOLE_STA		U2STA
	#define CONSOLE_UARTEN	U2MODEbits.UARTEN
	#define CONSOLE_TXEN	U2STAbits.UTXEN
	#define CONSOLE_TXREG	U2TXREG
	#define CONSOLE_UTXBF	U2STAbits.UTXBF
	#define CONSOLE_RXIF	IFS1bits.U2RXIF
	#define CONSOLE_OERR	U2STAbits.OERR
	#define	CONSOLE_RXREG	U2RXREG
	#define CONSOLE_RXIP	IPC7bits.U2RXIP
	#define CONSOLE_RXIE	IEC1bits.U2RXIE
#endif


///////////////////////////////////////////////////////////////////////////
//		Map the ENC PICTail to the SPI port
///////////////////////////////////////////////////////////////////////////
#if ENC_SPI_PORT == 1
	#define ENC_SPISTAT		SPI1STAT
	#define ENC_SPISTATbits	SPI1STATbits
	#define ENC_SPICON1		SPI1CON1
	#define ENC_SPICON1bits	SPI1CON1bits
	#define ENC_SPIBUF		SPI1BUF
	#define ENC_SPISTAT_RBF	SPI1STATbits.SPIRBF
#elif ENC_SPI_PORT == 2
	#define ENC_SPISTAT		SPI2STAT
	#define ENC_SPISTATbits	SPI2STATbits
	#define ENC_SPICON1		SPI2CON1
	#define ENC_SPICON1bits	SPI2CON1bits
	#define ENC_SPIBUF		SPI2BUF
	#define ENC_SPISTAT_RBF	SPI2STATbits.SPIRBF
#else
	#error platform.h missing ENC_SPI_PORT definition
#endif


///////////////////////////////////////////////////////////////////////////
//	MAP the SPI port used for the External EEPROM
//
//	Ensure the SDI I/O configuration matches the port used.
///////////////////////////////////////////////////////////////////////////
#if XEE_SPI_PORT == 1
	#define XEE_SPICON1			SPI1CON1
	#define XEE_SPICON2			SPI1CON2
	#define XEE_SPISTAT			SPI1STAT
	#define XEE_SPIBUF			SPI1BUF
	#define XEE_SPISTAT_RBF		SPI1STATbits.SPIRBF
	#define XEE_SPICON1bits		SPI1CON1bits
	#define XEE_SPISTATbits		SPI1STATbits
#elif XEE_SPI_PORT == 2
	#define XEE_SPICON1			SPI2CON1
	#define XEE_SPICON2			SPI2CON2
	#define XEE_SPISTAT			SPI2STAT
	#define XEE_SPIBUF			SPI2BUF
	#define XEE_SPISTAT_RBF		SPI2STATbits.SPIRBF
	#define XEE_SPICON1bits		SPI2CON1bits
	#define XEE_SPISTATbits		SPI2STATbits
#endif


///////////////////////////////////////////////////////////////////////////
//	Processor Specific Configuration
///////////////////////////////////////////////////////////////////////////
#define PIC_ERASE_SIZE	512			// instructions per erase page (1536 bytes + 512 phantom)
#define PIC_WRITE_SIZE	64			// instructions per write page
#define PIC_WRITE_ROWS	(PIC_ERASE_SIZE/PIC_WRITE_SIZE)
#define PIC_INSTR_SIZE	4			// bytes per PIC instruction (includes phantom byte)


///////////////////////////////////////////////////////////////////////////
//	Processor Non Volatile Memory Erase and Write Opcoded
///////////////////////////////////////////////////////////////////////////
#define PIC_PAGE_ERASE	0x4042		// NVM page erase opcode
#define PIC_ROW_WRITE 	0x4001		// NVM row write opcode

///////////////////////////////////////////////////////////////////////////
//	Configure the Memory Addresses of the Bootloader and its vectors
//
// The base address MUST be a multiple of the PIC_ERASE_SIZE to ensure the 
// base address is on an Erase Page boundary
// The BOOTLOADER_BASE, BOOTLOADER_END and UserJump MUST match the linker
// script
///////////////////////////////////////////////////////////////////////////
#define ResetVectorEnd	(DWORD)0x00004		// End of the reset vector
#define BOOTLOADER_BASE (DWORD)0x00400		// Base address of the bootloader
#ifdef ldr_debug
	#define BOOTLOADER_END  (DWORD)0x03fff		// End address of the bootloader
#else
	#define BOOTLOADER_END  (DWORD)0x02fff		// End address of the bootloader
#endif

///////////////////////////////////////////////////////////////////////////
//	Locate the parameter block in write accessable program memory
/////////////////////////////////////////////////////////////////////////// 
#ifdef ldr_debug   
	#define PARAM_BASE		(DWORD) 0x04000		// Start of the parameter block	
#else
	#define PARAM_BASE		(DWORD) 0x03000		// Start of the parameter block	
#endif
#define UserJump		(DWORD) PARAM_BASE		
#define UserCatchAll	(DWORD) (PARAM_BASE + 4)
#define CodeState		(DWORD) (PARAM_BASE + 8)
#define ImageID			(DWORD) (PARAM_BASE + 12)
#define P_MAC			(DWORD) (PARAM_BASE + 16)
#define P_Def_IP		(DWORD) (PARAM_BASE + 24)		
#define PARAM_END		(DWORD) (PARAM_BASE + 28)


/////////////////////////////////////////////////////////////////////////// 
//		Define the address of the CONFIG fuses
/////////////////////////////////////////////////////////////////////////// 
#if defined __dsPIC33FJ128MC804__
	#define CONFIG_BASE		(DWORD) 0x157FE	
#else
	#error platform.h - missing CONFIG_BASE parameter
#endif



/////////////////////////////////////////////////////////////////////////// 

//#define reset_cpu() abort()
#define reset_cpu() __asm__ volatile("RESET")

//////////////////////////////////////////////////////////////////////////
// Catch all to ensure a platform has been selected and matches a 
// declaration in the header file
//////////////////////////////////////////////////////////////////////////
#ifndef ENC_CS
	#error No matching hardware platform definition in header file
#endif
//////////////////////////////////////////////////////////////////////////

#define LinkStatus() ((ReadPHYReg(PHSTAT2) & PHSTAT2_LSTAT) > 0)