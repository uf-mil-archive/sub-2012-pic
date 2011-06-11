#include "taskADC.h"

static volatile BOOL adcMAVGsInited = FALSE;

// Paul - concrete instances of your MAVG's. These can be arrays if you match
// the index number to a rail number. I was thinking something like batteries
// are 0,1,2, and 3 is the rail out, but you know your schematic so it's up to
// you.
static MAVGFilter vrail32MAVG[4];
static MAVGFilter vrail16MAVG[4];
static MAVGFilter current16MAVG;
static MAVGFilter current32MAVG;


/*
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

    LED = LED_OFF;
}
*/
