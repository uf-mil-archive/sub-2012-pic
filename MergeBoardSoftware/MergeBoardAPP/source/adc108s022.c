////////////////////////////////////////////////////////////////////////////////
// Analog to Digital Converters (source)             Authored by:   Paul Launier
//
// Created: 04/29/2011                       Last Modified: 05/01/2011   9:09 AM
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following code contains the functions to talk with the ADC over SPI.
//  Both ADC16 and ADC32 have 5 voltages that need to be read and stored into a
//  global variable.
//
//  10 bit ADC data is recieved in 16 bits with 4 leading zeros and 2 trailing
//  zeros (0000DDDDDDDDDD00)
//
//  The 3 bit Address for the next read is sent out as 16 bits with 2 leading
//  zeros and 11 trailing: (00AAA00000000000).
//
////////////////////////////////////////////////////////////////////////////////

#include "adc108s022.h"
#include "p33FJ128MC804.h"

#define MAX_NUMBER_OF_ADC_READS	5

#if defined(ADC16_CS_IO) || defined(ADC32_CS_IO)

UINT16 ADC16Val[MAX_NUMBER_OF_ADC_READS] = {0};     //array for ADC16 values
UINT16 ADC32Val[MAX_NUMBER_OF_ADC_READS] = {0};     //array for ADC16 values

INT16 ADC_IsInited = 0;

struct SavedSPI
{
    UINT16 CON1;
    UINT16 CON2;
    UINT16 STAT;
}ADC_savedSPI;

/******************************************************************************/

void ADC_saveSPI()
{
    ADC_savedSPI.CON1 = ADC_SPIxCON1;
    ADC_savedSPI.CON2 = ADC_SPIxCON2;
    ADC_savedSPI.STAT = ADC_SPIxSTAT;
}

/******************************************************************************/

void ADC_restoreSPI()
{
    // Disable the SPI
    ADC_SPIxSTATbits.SPIEN = 0;

    // Write back the saved configuration
    ADC_SPIxCON1 = ADC_savedSPI.CON1;
    ADC_SPIxCON2 = ADC_savedSPI.CON2;
    ADC_SPIxSTAT = ADC_savedSPI.STAT;
}

/******************************************************************************/

void ADC_configSPI(void)
{
    // Make sure the ADC pins have been initialized correctly
    if(!ADC_IsInited)
    {
       
        ADC16_CS_TRIS = OUTPUT_PIN;
        ADC16_CS_IO = AL_FALSE;

        ADC32_CS_TRIS = OUTPUT_PIN;
        ADC32_CS_IO = AL_FALSE;

        ADC_IsInited = TRUE;
    }


    // Disable the SPI to reconfigure for the ADC
    ADC_SPIxSTATbits.SPIEN = 0;

    //ADC_saveSPI();

    // This assumes a 40Mhz instruction clock to get 5MHz on SPI
    // DAC_SPIxCON1 = 0x0523;
    ADC_SPIxCON1 = 0x0522;        //slower SPI for debugging (1.25 MHz)
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

    ADC_SPIxCON2 = 0x0000;  // Framing is not used, keep this register cleared
                            // for it to stay disabled

    // Reenable the SPI, clearing any overflow flags.
    ADC_SPIxSTAT = 0x8000;
}

/******************************************************************************/

void ADC_getData(int adcSel)
{
    ADC_configSPI();

    volatile UINT16 adcADDR;      // shifted address to send to ADC
    volatile UINT16 nextAddr;     // counter for pre-shifted address
    volatile UINT16* tempVAL;     // temp array for ADC values


    if (adcSel == 1 || adcSel == 16)    // save data to the correct global array
        tempVAL = ADC16Val;
    else
        tempVAL = ADC32Val;

    while(DAC_SPIxSTATbits.SPITBF);     // Make sure the buffer is ready

    if (adcSel == 1 || adcSel == 16){    // prepare to send by lowering CS
        ADC16_CS_IO = AL_TRUE;
    }else{
        ADC32_CS_IO = AL_TRUE;
    }

    for (nextAddr = 1; nextAddr <= 5; nextAddr++)
    {

        if (nextAddr == 5)  //fith write needs to send a zero as next address
            adcADDR = 0;
        else
            adcADDR = (nextAddr << 11);     // move addr to correct bit loaction

        // Send out the adc address to read next (0-7 in bits 12,11,10)
        // and fill buffer with current address
        ADC_SPIxBUF = adcADDR;

        while(!ADC_SPIxSTATbits.SPIRBF);    // Wait for transmission to complete

        // copy the ADC value from the buffer and trim off trailing zeroes
        tempVAL[nextAddr-1] = (ADC_SPIxBUF >> 2);
    }

    if (adcSel == 1 || adcSel == 16) {       // ADC array now has fresh data
        ADC16_CS_IO = AL_FALSE;
    }else{
       ADC32_CS_IO = AL_FALSE;
    }

    // Put the SPI back how it was
    //ADC_restoreSPI();
}

/******************************************************************************/

#endif

