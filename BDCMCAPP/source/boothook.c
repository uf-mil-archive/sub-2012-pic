#include "HardwareProfile.h"

#if defined(IS_BOOTLOADED)
#include "boothook.h"

///////////////////////////////////////////////////////////////////////////
// Shadow RAM Area used to build the page contents to be written to program
// memory. The Shadow block is the size of the PICs Erase block size
///////////////////////////////////////////////////////////////////////////
BYTE Shadow[PIC_ERASE_SIZE * PIC_INSTR_SIZE];
BYTE ShadowPage;
WORD ShadowBaseAddr;
BOOL ShadowDirty;

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

void SyncBL(BYTE MAC[], BYTE IP[])
{
    WORD offset;

    // Mirror the Parameter block to ram first
    MirrorBlock((P_Def_IP >> 16), P_Def_IP);

    // Point the offset to the IP section
    offset = ((P_Def_IP & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);

    // Modify the IP address in the shadow block
    Shadow[offset++] = IP[0];
    Shadow[offset++] = IP[1];
    offset++;
    offset++;
    Shadow[offset++] = IP[2];
    Shadow[offset++] = IP[3];

    // Point the offset to the MAC section
    offset = ((P_MAC & 0xffff) * 2) % (PIC_ERASE_SIZE * PIC_INSTR_SIZE);

    // Modify the MAC Address in the shadow block
    Shadow[offset++] = MAC[0];
    Shadow[offset++] = MAC[1];
    offset++;
    offset++;
    Shadow[offset++] = MAC[2];
    Shadow[offset++] = MAC[3];
    offset++;
    offset++;
    Shadow[offset++] = MAC[4];
    Shadow[offset++] = MAC[5];

    WriteBlock((P_Def_IP >> 16), P_Def_IP);
}

#endif
