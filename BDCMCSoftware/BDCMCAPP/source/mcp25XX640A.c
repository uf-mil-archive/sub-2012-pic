#include "mcp25XX640A.h"
#include "p33FJ128MC804.h"
#include <stdlib.h>
#include <string.h>

// This driver doesn't know anything about FreeRTOS!
// You should put semaphores around driver function calls
// if you are embedding it into a RTOS application where the
// bus is shared. However, this driver does share the bus, it will
// reconfigure SPI for itself and then put it back how it found it
// when its done.

#if defined(EROM_CS_IO)

// Forward declarations
void EROM_saveSPI(void);
void EROM_restoreSPI(void);
void EROM_configSPI(void);
BYTE EROM_checkSPIConfig(void);
void EROM_wipPoll(void);
void EROM_writeEnable(void);
BYTE EROM_writeSPI(BYTE data);
BYTE EROM_readSPI();

#define EROM_HAS_SPI        1
#define EROM_RELEASED_SPI   0

INT16 EROM_IsInited = 0;

struct SavedSPI
{
    UINT16 CON1;
    UINT16 CON2;
    UINT16 STAT;
    BYTE FLAG;
}EROM_savedSPI;

void EROM_saveSPI(void)
{
    EROM_savedSPI.CON1 = EROM_SPIxCON1;
    EROM_savedSPI.CON2 = EROM_SPIxCON2;
    EROM_savedSPI.STAT = EROM_SPIxSTAT;
    EROM_savedSPI.FLAG = EROM_HAS_SPI;
}

void EROM_restoreSPI(void)
{
    // Disable the SPI
    EROM_SPIxSTATbits.SPIEN = 0;

    // Write back the saved configuration
    EROM_SPIxCON1 = EROM_savedSPI.CON1;
    EROM_SPIxCON2 = EROM_savedSPI.CON2;
    EROM_SPIxSTAT = EROM_savedSPI.STAT;     // If the SPI was enabled, this
    EROM_savedSPI.FLAG = EROM_RELEASED_SPI; // turns it back on.
}

void EROM_configSPI(void)
{
    if(!EROM_IsInited)
    {
        EROM_WP_TRIS = OUTPUT_PIN;
        EROM_WP_IO = AL_FALSE;
        EROM_CS_TRIS = OUTPUT_PIN;
        EROM_CS_IO = AL_FALSE;

        EROM_IsInited = TRUE;
    }    
    // Disable the SPI to reconfigure for the EROM
    EROM_SPIxSTATbits.SPIEN = 0;

    // This assumes a 40Mhz instruction clock to get 5MHz on SPI
    EROM_SPIxCON1 = 0x0123;
    // Bits 15-13 = 000  Unimplemented
    // Bit 12 = 0        SCK pin is controlled by SPI
    // Bit 11 = 0        SDO pin is controlled by SPI
    // Bit 10 = 0        8 bit data mode(8 clks per write)
    // Bit 9 = 0         Sample in middle of output time
    // Bit 8 = 1         Output data changes at falling edge
    // Bit 7 = 0         Not used in master mode
    // Bit 6 = 0         SCK is active high
    // Bit 5 = 1         SPI is in master mode
    // Bits 4-2 = 000    Secondary clock prescalar 8:1
    // Bits 1-0 = 11     Primary clock prescalar 1:1
    
    EROM_SPIxCON2 = 0x0000;  // Framing is not used, keep this register cleared
                             // for it to stay disabled

    // Reenable the SPI, clearing any overflow flags.
    EROM_SPIxSTAT = 0x8000;
}

BYTE EROM_checkSPIConfig(void)
{
    if(EROM_savedSPI.FLAG == EROM_HAS_SPI)
        return FALSE;

    EROM_saveSPI();
    EROM_configSPI();

    return TRUE;
}

BYTE EROM_ReadStatusRegister(void)
{
    BYTE iconfigured = EROM_checkSPIConfig();

    EROM_CS_IO = AL_TRUE;   // Activate the EEPROM

    EROM_writeSPI(EROM_CC_RDSR);   // Send the read status register command
    BYTE res = EROM_readSPI();      // Get the value

    EROM_CS_IO = AL_FALSE;  // Done, deactivate the EEPROM

    if(iconfigured)
        EROM_restoreSPI();

    return res;
}

void EROM_wipPoll(void)
{
    BYTE res = 1;
    do
    {
        res = EROM_ReadStatusRegister();
    }while(res & 0x01);

    return;
}

INT8 EROM_ReadBytes(UINT16 address, UINT16 length, BYTE* const buf)
{
    if(address >= EROM_SIZE_BYTES)
        return EROM_ADDRESS_OUT_OF_RANGE;

    BYTE iconfigured = EROM_checkSPIConfig();

    EROM_CS_IO = AL_TRUE;   // Activate the EEPROM
    EROM_writeSPI(EROM_CC_READ);   // Send the read command
    EROM_writeSPI(((UINT16_VAL)address).v[1]);  // Send out the high address
    EROM_writeSPI(((UINT16_VAL)address).v[0]);  // Send out the low address

    // Read data
    BYTE* tmpPtr = buf;
    while(length)                       // Reads don't care about pages!
    {                                   // They will also wrap around
        *tmpPtr++ = EROM_readSPI();     // the entire address range quietly!!!
        length--;
    }                                           

    EROM_CS_IO = AL_FALSE;  // Done, deactivate the EEPROM

    if(iconfigured)
        EROM_restoreSPI();

    return EROM_SUCCESS;   // No error
}

INT8 EROM_WriteBytes(UINT16 address, UINT16 length, BYTE* const buf)
{
    if(address >= EROM_SIZE_BYTES || length > EROM_SIZE_BYTES)
        return EROM_ADDRESS_OUT_OF_RANGE;

    // Calculate number of bytes written to first page
    volatile INT16 fPageBytes = EROM_PAGE_SIZE - (address % EROM_PAGE_SIZE);
    // Calculate number of pages we'll need to write past the first one
    INT16 numBytesLeft = (length - fPageBytes);
    INT16 numPages = 1;
    if(numBytesLeft > 0)
    {
        numPages += ((numBytesLeft % EROM_PAGE_SIZE) > 0) ?
                                       ((numBytesLeft / EROM_PAGE_SIZE) + 1)
                                     : (numBytesLeft / EROM_PAGE_SIZE);
    }

    BYTE iconfigured = EROM_checkSPIConfig();
    
    // write data
    BYTE* tmpPtr = buf;
    INT16 i, j;
    INT16 k = 0;
    for(i = 0; i < numPages; i++)   // The number of pages written
    {
        EROM_writeEnable();     // Enable the write latch
        EROM_CS_IO = AL_TRUE;   // Activate the EEPROM
        EROM_writeSPI(EROM_CC_WRITE);   // Send the write command
        UINT16 add = address + k;
        EROM_writeSPI(((UINT16_VAL)add).v[1]);  // Send out high address
        EROM_writeSPI(((UINT16_VAL)add).v[0]);  // Send out low address

        // The number of bytes written to this page
        for(j = 0; (j < fPageBytes && k < length); j++)
        {
            k++;    // This counter is how many bytes written total
            EROM_writeSPI(*tmpPtr++); // Write the byte
        }

        EROM_CS_IO = AL_FALSE;      // This begins the write sequence for the
                                    // current page
        EROM_wipPoll();             // Wait until the write is finished

        fPageBytes = EROM_PAGE_SIZE; // After the first page you can write to
                                     // the full page size.
    }

    if(iconfigured)
        EROM_restoreSPI();  
    
    return EROM_SUCCESS;   // No error
}

void EROM_writeEnable(void)
{
    EROM_CS_IO = AL_TRUE;
    EROM_writeSPI(EROM_CC_WREN);    // Send the write enable command
    EROM_CS_IO = AL_FALSE;          // The EEPROM is now ready for writing

    return;
}

/*
 * This helper function expects CS to be handled externally
 */
BYTE EROM_writeSPI(BYTE data)
{
   
    while(EROM_SPIxSTATbits.SPITBF);    // Make sure the buffer is ready

    EROM_SPIxBUF = (0x00FF & data);     // Mask the byte and write it out

    while(!EROM_SPIxSTATbits.SPIRBF);    // Wait for transmission to complete

    return (EROM_SPIxBUF & 0xFF);       // Return what was clocked in in case
                                        // someone is interested. This also
                                        // keeps the overflow flag clear
}

BYTE EROM_readSPI()
{
    EROM_SPIxSTATbits.SPIROV = 0;   // Clear the overflow flag

    while(EROM_SPIxSTATbits.SPITBF); // Check if the write buffer is still full

    EROM_SPIxBUF = 0x00;    // Dummy write to generate clocks for reading

    while(!EROM_SPIxSTATbits.SPIRBF);    // Wait for transmission to complete

    return (EROM_SPIxBUF & 0xFF);
}

INT8 EROM_Clear()
{
    INT16 i = 0;
    INT8 res = 0;

    BYTE* erase = malloc(sizeof(BYTE)*EROM_PAGE_SIZE);
    memset(erase, 0xFF , EROM_PAGE_SIZE);
   
    for(i = 0; i < EROM_SIZE_BYTES / EROM_PAGE_SIZE; i++)
    {
        res |= EROM_WriteBytes(i*EROM_PAGE_SIZE, EROM_PAGE_SIZE, erase);
    }

    free(erase);

    return res;
}

INT16 EROM_ReadInt16(UINT16 address)
{
    INT16 res;
    BYTE* resByte = (BYTE *)(void *)&res;

    EROM_ReadBytes(address, sizeof(INT16), resByte);

    return res;
}

INT8 EROM_WriteInt16(UINT16 address, INT16 value)
{
    return EROM_WriteBytes(address, sizeof(INT16), (BYTE *)(void *)&value);
}

float EROM_ReadFloat(UINT16 address)
{
    float res;
    BYTE* resByte = (BYTE *)(void *)&res;

    EROM_ReadBytes(address, sizeof(float), resByte);
    
    return res;
}

INT8 EROM_WriteFloat(UINT16 address, float value)
{
    return EROM_WriteBytes(address, sizeof(float), (BYTE *)(void *)&value);
}

#endif

