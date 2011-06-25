#include "mcp4821.h"
#include "p33FJ128MC804.h"

// This driver doesn't know anything about FreeRTOS!
// You should put semaphores around driver function calls
// if you are embedding it into a RTOS application where the
// bus is shared. However, this driver does share the bus, it will
// reconfigure SPI for itself and then put it back how it found it
// when its done.

#if defined(DAC_CS_IO)

INT16 DAC_IsInited = 0;

#define DAC_MAXVOLTAGE  4.096
#define DAC_VMODESWITCH 2.048
#define DAC_HVCBITS     0x1000
#define DAC_LVCBITS     0x3000

struct SavedSPI
{
    UINT16 CON1;
    UINT16 CON2;
    UINT16 STAT;
}DAC_savedSPI;

void DAC_saveSPI()
{
    DAC_savedSPI.CON1 = DAC_SPIxCON1;
    DAC_savedSPI.CON2 = DAC_SPIxCON2;
    DAC_savedSPI.STAT = DAC_SPIxSTAT;
}

void DAC_restoreSPI()
{
    // Disable the SPI
    DAC_SPIxSTATbits.SPIEN = 0;

    // Write back the saved configuration
    DAC_SPIxCON1 = DAC_savedSPI.CON1;
    DAC_SPIxCON2 = DAC_savedSPI.CON2;
    DAC_SPIxSTAT = DAC_savedSPI.STAT;
}

void DAC_configSPI(void)
{
    // Make sure the DAC pins have been initialized correctly
    if(!DAC_IsInited)
    {
        DAC_LD_TRIS = OUTPUT_PIN;
        DAC_LD_IO = AL_FALSE;
        
		DAC16_CS_TRIS = OUTPUT_PIN;
        DAC16_CS_IO = AL_FALSE;

        DAC32_CS_TRIS = OUTPUT_PIN;
        DAC32_CS_IO = AL_FALSE;

        DAC_IsInited = TRUE;
    }

    // Disable the SPI to reconfigure for the DAC
    DAC_SPIxSTATbits.SPIEN = 0;

    DAC_saveSPI();

    // This assumes a 40Mhz instruction clock to get 5MHz on SPI
    DAC_SPIxCON1 = 0x0523;
    // Bits 15-13 = 000  Unimplemented
    // Bit 12 = 0        SCK pin is controlled by SPI
    // Bit 11 = 0        SDO pin is controlled by SPI
    // Bit 10 = 1        16 bit data mode(16 clks per write)
    // Bit 9 = 0         Sample in middle of output time
    // Bit 8 = 1         Output data changes at falling edge
    // Bit 7 = 0         Not used in master mode
    // Bit 6 = 0         SCK is active high
    // Bit 5 = 1         SPI is in master mode
    // Bits 4-2 = 000    Secondary clock prescalar 8:1
    // Bits 1-0 = 11     Primary clock prescalar 1:1
    
    DAC_SPIxCON2 = 0x0000;  // Framing is not used, keep this register cleared
                            // for it to stay disabled

    // Reenable the SPI, clearing any overflow flags.
    DAC_SPIxSTAT = 0x8000;
}

void DAC_SetOutput(float voltage, UINT16 dacSel)
{
    DAC_LD_IO = AL_TRUE;    // Load when CS is deasserted

    DAC_configSPI();

    if(voltage > DAC_MAXVOLTAGE)    // Silently cap the max voltage
        voltage = DAC_MAXVOLTAGE;
    
    UINT16 dacReg = 0;
    if(voltage > DAC_VMODESWITCH)
    {
        // The voltage is above the high res mode
        dacReg = ((DAC_HVCBITS)|((UINT16)(voltage*1000)));
    }
    else
    {
       dacReg = ((DAC_LVCBITS)|((UINT16)(voltage*2000)));
    }  

    while(DAC_SPIxSTATbits.SPITBF);     // Make sure the buffer is ready

	if (dacSel == DAC_RAIL_16)
        DAC16_CS_IO = AL_TRUE;
    else
        DAC32_CS_IO = AL_TRUE;

    // Send out the voltage and command nibble
    DAC_SPIxBUF = dacReg;
    
    while(!DAC_SPIxSTATbits.SPIRBF);    // Wait for transmission to complete

    volatile UINT16 dummy = DAC_SPIxBUF; // This ensures the overflow flag
    (void)dummy;                         // stays clear
    DAC_SPIxSTATbits.SPIROV = 0;

	DAC16_CS_IO = AL_FALSE;
    DAC32_CS_IO = AL_FALSE;   // DAC has new voltage
    DAC_LD_IO = AL_FALSE;    // Leave this high to help with current draw
    
    // Put the SPI back how it was
    DAC_restoreSPI();
}

void DAC_Shutdown()
{
    DAC_LD_IO = AL_TRUE;    // Load when CS is deasserted

    DAC_configSPI();

    while(DAC_SPIxSTATbits.SPITBF);     // Make sure the buffer is ready

    if (dacSel == DAC_RAIL_16)
    	DAC16_CS_IO = AL_TRUE;
    else
        DAC32_CS_IO = AL_TRUE;

    // Send out the turn off command
    DAC_SPIxBUF = 0x2000;

    while(!DAC_SPIxSTATbits.SPIRBF);    // Wait for transmission to complete

	DAC16_CS_IO = AL_FALSE;
    DAC32_CS_IO = AL_FALSE;   // DAC has new voltage
    DAC_LD_IO = AL_FALSE;    // Leave this high to help with current draw

    // Put the SPI back how it was
    DAC_restoreSPI();
}

#endif

