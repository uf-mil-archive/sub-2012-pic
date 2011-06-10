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

//********************* ADDRESS MAP *********************************/
// First two pages blank - it seems when you screw up, those are the
// pages you ruin, so keep them empty.
#define ETH_EROM_BASE       (EROM_PAGE_SIZE*2) // 1k reserved for Ethernet settings
#define UDP_EROM_BASE       (EROM_PAGE_SIZE*32 + ETH_EROM_BASE)	// 1k reserved for UDP settings
#define MTR_EROM_BASE       (EROM_PAGE_SIZE*32 + UDP_EROM_BASE)  // 1k reserved for motor settings
#define COMMON_EROM_BASE    (EROM_PAGE_SIZE*32 + MTR_EROM_BASE)  // 1k reserved for common settings
#define UART_EROM_BASE      (EROM_PAGE_SIZE*32 + COMMON_EROM_BASE)
//********************* ~ADDRESS MAPS *******************************/

INT8 EROM_ReadBytes(UINT16 address, UINT16 length, BYTE* const buf);
INT8 EROM_WriteBytes(UINT16 address, UINT16 length, BYTE* const buf);
INT16 EROM_ReadInt16(UINT16 address);
float EROM_ReadFloat(UINT16 address);
INT8 EROM_WriteInt16(UINT16 address, INT16 value);
INT8 EROM_WriteFloat(UINT16 address, float value);
INT8 EROM_Clear();  // Erases the entire EEPROM

#endif // 25XX640A_H
