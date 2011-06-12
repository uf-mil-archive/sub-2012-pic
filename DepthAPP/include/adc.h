#ifndef ADC_H
#define ADC_H

#include "p33Fxxxx.h"
#include "taskUART.h"
#include "fixMath.h"
#include "mavg.h"

/* Configure these for the A/D settings and hardware */
#define ADC_DMA_BUFFER_SIZE     128
#define ADC_MAVG_QUEUE_LENGTH   7

#define ADC_REFV                3.3 // The reference voltage of the ADC
/* The ADC is configured in 12 bit unsigned integer mode(Q12_0). Hence,
   the max value the ADC can put out is 0b0000 1111 1111 1111*/
#define ADC_MAX_VAL             (0xFFF)
// The VRail Voltage divider gain
#define ADC_VRAIL_GAIN          (8.25/108.25)
// The Current Divider Gain
#define ADC_CURRENT_GAIN        (1.0/5.0)


/* Shouldn't need to edit these */
// The calculated maximum measurable voltage for VRail
#define ADC_VRAIL_MMV           (ADC_REFV/ADC_VRAIL_GAIN)
// The amount of volts per bit for VRail measurements
#define ADC_VRAIL_BPV           ((Q1_15)((ADC_VRAIL_MMV / ADC_MAX_VAL) * 32768))

// The calculated maximum measurable amperage for Current
#define ADC_CURRENT_MMA         (ADC_REFV/ADC_CURRENT_GAIN)
// The amount of amps per bit for Current measurements
#define ADC_CURRENT_BPA         ((Q1_15)((ADC_CURRENT_MMA / ADC_MAX_VAL) * 32768))

void ADCInit(void);

#endif // ADC_H
