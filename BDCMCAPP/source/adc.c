#include "adc.h"

struct
{
    UINT16 ADC1CH0[ADC_DMA_BUFFER_SIZE];
    UINT16 ADC1CH1[ADC_DMA_BUFFER_SIZE];
} ADCBufferA __attribute__((space(dma),aligned(512)));

struct
{
    UINT16 ADC1CH0[ADC_DMA_BUFFER_SIZE];
    UINT16 ADC1CH1[ADC_DMA_BUFFER_SIZE];
} ADCBufferB __attribute__((space(dma),aligned(512)));

static volatile BOOL adcMAVGsInited = FALSE;

static MAVGFilter currentMAVG;
static MAVGFilter vrailMAVG;

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
    // Bits 7-5 - 111   Internal timer ends sampling and starts conversion
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

    AD1CON3 = 0x0305;
    // Bit 15 - 0       ADC clock derived from system clock
    // Bits 14-13 - 00  Unimplemented
    // Bits 12-8 - 00011   Auto sample time bits 3*Tad (450ns)
    // Bits 7-0 - 00000101 ADC Conversion clock divider 6*Tcy(150ns min is 117.6)
    // Total time is Conversion+Sampling = 14*Tad + *Tad = 2550ns  or ~196kHz per channel

    AD1CON4 = 0x0007;
    // Bits 15-3 - 0    Unimplemented
    // Bits 2-0 - 011   128 Words per analog input for DMA buffer

    AD1CSSL = 0x0003;
    // Bits 15-9 - 0    Unimplemented
    // Bits 8-2 - 0     Skip AN8-2 for scanning
    // Bits 1-0 - 11    Scan AN1-0 with CH0

    AD1CHS0 = 0;

    IFS0bits.AD1IF = 0;     // Clear the interrupt flag
    IEC0bits.AD1IE = 0;     // Do not enable the ADC interrupt

    ADCDMAInit();           // Initialize the DMA to handle ADC

    AD1CON1bits.ADON = 1;   // Turn on the ADC

    // Wait until the averages get initialized
    while(!adcMAVGsInited) Nop();

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
    DMA5CNT = 255;   // Set the number of transfers before interrupt
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
    LED = LED_ON;

    // The first time through is an initialization run really
    if(!adcMAVGsInited)
    {
        if(ADCCurrentDMABuffer == 0)
        {
            MAVG_Init(&vrailMAVG, &ADCBufferA.ADC1CH0[0], ADC_MAVG_QUEUE_LENGTH);
            MAVG_Init(&currentMAVG, &ADCBufferA.ADC1CH1[0], ADC_MAVG_QUEUE_LENGTH);
        }
        else
        {
            MAVG_Init(&vrailMAVG, &ADCBufferB.ADC1CH0[0], ADC_MAVG_QUEUE_LENGTH);
            MAVG_Init(&currentMAVG, &ADCBufferB.ADC1CH1[0], ADC_MAVG_QUEUE_LENGTH);
        }
        adcMAVGsInited = TRUE;
        goto ADC_DONE;
    }

    // Update the moving average
    if(ADCCurrentDMABuffer == 0)
    {
        MAVG_Update(&vrailMAVG, &ADCBufferA.ADC1CH0[0], ADC_DMA_BUFFER_SIZE);
        MAVG_Update(&currentMAVG, &ADCBufferA.ADC1CH1[0], ADC_DMA_BUFFER_SIZE);
    }
    else
    {
        MAVG_Update(&vrailMAVG, &ADCBufferB.ADC1CH0[0], ADC_DMA_BUFFER_SIZE);
        MAVG_Update(&currentMAVG, &ADCBufferB.ADC1CH1[0], ADC_DMA_BUFFER_SIZE);
    }    

    if(hMotorData)
    {
        // Q12_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q6_10 in the motor
        // struct, so shift to generate final result
        hMotorData->VRail = (Q6_10)((vrailMAVG.CurrentAvg*ADC_VRAIL_BPV) >> 5);
        // Q12_0(ADC reading)*Q1_15(bits/v)=QX_15. We store Q4_12 in the motor
        // struct, so shift to generate final result
        hMotorData->Current = (Q4_12)((currentMAVG.CurrentAvg*ADC_CURRENT_BPA) >> 3);
    }

ADC_DONE:
    ADCCurrentDMABuffer ^= 1; // Toggle to other buffer
    IFS3bits.DMA5IF = 0;    // Clear the DMA0 interrupt flag

    //LED = LED_OFF;
}
