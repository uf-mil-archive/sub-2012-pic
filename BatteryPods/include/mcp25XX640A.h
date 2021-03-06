#ifndef MCP25XX640A_H
#define MCP25XX640A_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

#define EROM_PAGE_SIZE  0x20        // 32 byte page boundaries
#define EROM_SIZE_BYTES 8192        // Total size of the EEPROM array

// Error Codes
#define EROM_SUCCESS                0
#define EROM_ADDRESS_OUT_OF_RANGE   1


// Command Codes
#define EROM_CC_READ    0x03        // Read
#define EROM_CC_WRITE   0x02        // Write
#define EROM_CC_WRDI    0x04        // Reset Write Enable Latch(Disable Writing)
#define EROM_CC_WREN    0x06        // Set Write Enable Latch(Enable Writing)
#define EROM_CC_RDSR    0x05        // Read STATUS Register
#define EROM_CC_WRSR    0x01        // Write STATUS Register

INT8 EROM_ReadBytes(UINT16 address, UINT16 length, BYTE* const buf);
INT8 EROM_WriteBytes(UINT16 address, UINT16 length, BYTE* const buf);

#endif // 25XX640A_H
