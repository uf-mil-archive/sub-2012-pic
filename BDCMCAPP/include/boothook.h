#ifndef BOOTHOOK_H
#define BOOTHOOK_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"
#include "p33Fxxxx.h"

#if defined(IS_BOOTLOADED) 
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

    // This module allows the user application to sync its IP and MAC addresses
    // with the brush electronics UDP bootloader.


    void SyncBL(BYTE MAC[], BYTE IP[]);
#endif
    
#endif // BOOTHOOK_H
