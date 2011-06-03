#include "adc.h"
#include "motor.h"

struct
{
    UINT16 ADC1CH0[ADC_DMA_BUFFER_SIZE];
    UINT16 ADC1CH1[ADC_DMA_BUFFER_SIZE];
} ADCBufferA __attribute__((space(dma),aligned(32)));

struct
{
    UINT16 ADC1CH0[ADC_DMA_BUFFER_SIZE];
    UINT16 ADC1CH1[ADC_DMA_BUFFER_SIZE];
} ADCBufferB __attribute__((space(dma),aligned(32)));

void ADCDMAInit(void);

// Channel 0 is the rail voltage divider
// Channel 1 is the current sense resistor
void ADCInit(void)
{
    AD1CON1bits.ADON = 0;

    AD1CON1 = 0x24E4;
    // Bit 15 - 0       ADC module is off while configuring
    // Bit 14 - 0       Unimplemented
    // Bit 13 - 1       Discontinue operation in Idle Mode
    // Bit 12 - 0       DMA buffers in Scatter/Gather Mode
    // Bit 11 - 0       Unimplemented
    // Bit 10 - 1       12 bit 1 channel
    // Bits 9-8 - 00    Unsigned Integer
    // Bits 7-5 - 111   Internal counter ends sampling and starts conversion
    // Bit 4 - 0        Unimplemented
    // Bit 3 - 0        Don't Care, using single channel since 12 bit
    // Bit 2 - 1        Sampling begins immediately after last conversion
    // Bit 1 - 0        Automatically set
    // Bit 0 - 0        A/D Done

    AD1CON2 = 0xE404;
    // Bits 15-13 - 111 AVdd/AVss Reference voltages
    // Bits 12-11 - 00  Unimplemented
    // Bit 10 - 1       Scan inputs for CH0+
    // Bits 9-8 - 00    CH0 is the only channel converted
    // Bit 7 - 0        Read Only
    // Bit 6 - 0        Unimplemented
    // Bit 5-2 - 0001   Increment DMA Address every 2nd Sample/Conversion
    // Bit 1 - 0        Begin buffer fill at address 0
    // Bit 0 - 0        Always use channel input for Sample A

    AD1CON3 = 0x1F3F;
    // Bit 15 - 0       ADC clock derived from system clock
    // Bits 14-13 - 00  Unimplemented
    // Bits 12-8 - 11111   Auto sample time bits 31*Tad
    // Bits 7-0 - 00111111 ADC Conversion clock divider 64*Tcy

    AD1CON4 = 0x0003;
    // Bits 15-3 - 0    Unimplemented
    // Bits 2-0 - 011   8 Words per analog input for DMA buffer

    AD1CSSL = 0x0003;
    // Bits 15-9 - 0    Unimplemented
    // Bits 8-2 - 0     Skip AN8-2 for scanning
    // Bits 1-0 - 11    Scan AN1-0 with CH0

    AD1CHS0 = 0;

    IFS0bits.AD1IF = 0;     // Clear the interrupt flag
    IEC0bits.AD1IE = 0;     // Do not enable the ADC interrupt

    ADCDMAInit();           // Initialize the DMA to handle ADC

    AD1CON1bits.ADON = 1;   // Turn on the ADC

    return;
}

void ADCDMAInit(void)
{
    DMA5CONbits.CHEN = 0;

    DMA5CON = 0x0022;
    // Bit 15 - 0       Disable the channel while configuring
    // Bit 14 - 0       Data Transfer size is WORD
    // Bit 13 - 0       Read from peripheral address, write to DMA RAM
    // Bit 12 - 0       Interrupt when all data has been moved
    // Bit 11 - 0       Normal Operation
    // Bits 10-6 - 0    Unimplemented
    // Bits 5-4 - 10    Peripheral Indirect Adressing Mode
    // Bits 3-2 - 00    Unimplemented
    // Bits 1-0 - 10    Continuous Ping Pong Mode

    DMA5REQ = 0x0D;         // Select ADC1 as DMA request source
    DMA5CNT = 15;   // Set the number of transfers before interrupt
    DMA5PAD = (volatile unsigned int)&ADC1BUF0;

    DMA5STA = __builtin_dmaoffset(&ADCBufferA);
    DMA5STB = __builtin_dmaoffset(&ADCBufferB);

    IFS3bits.DMA5IF = 0;    // Clear the DMA interrupt flag bit
    IEC3bits.DMA5IE = 1;    // Enable the DMA interrupt
    IPC15bits.DMA5IP = 3;

    DMA5CONbits.CHEN = 1;   // Enable the DMA

    return;
}

volatile UINT16 ADCCurrentDMABuffer = 0;

void __attribute__((interrupt, no_auto_psv)) _DMA5Interrupt(void)
{
    UINT32 currentSum = 0;
    UINT32 vrailSum = 0;
    INT16 i;
 
    if(ADCCurrentDMABuffer == 0)
    {
        for(i = 0; i < ADC_DMA_BUFFER_SIZE; i++)
        {
            vrailSum += ADCBufferA.ADC1CH0[i];
            currentSum += ADCBufferA.ADC1CH1[i];
        }
    }
    else
    {
        for(i = 0; i < ADC_DMA_BUFFER_SIZE; i++)
        {
            vrailSum += ADCBufferB.ADC1CH0[i];
            currentSum += ADCBufferB.ADC1CH1[i];
        }
    }

    // Calculate the averaged values - leave these promoted as a UINT32 to
    // facilitate the next calculation
    UINT32 vrail = vrailSum / ADC_DMA_BUFFER_SIZE;
    UINT32 current = currentSum / ADC_DMA_BUFFER_SIZE;

    if(hMotorData)
    {
        // Q12_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q6_10 in the motor
        // struct, so shift to generate final result
        hMotorData->VRail = (Q6_10)((vrail*ADC_VRAIL_BPV) >> 5);
        // Q12_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q4_12 in the motor
        // struct, so shift to generate final result
        hMotorData->Current = (Q4_12)((current*ADC_CURRENT_BPA) >> 3);
    }

    ADCCurrentDMABuffer ^= 1; // Toggle to other buffer

    IFS3bits.DMA5IF = 0;    // Clear the DMA0 interrupt flag
}

