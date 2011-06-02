#ifndef ADC_H
#define ADC_H

#include "p33FJ128MC804.h"
#include "taskUART.h"

#define ADC_DMA_BUFFER_SIZE     8
#define ADC_REFV                3.3
/* The ADC is configured in 12 bit unsigned fractional mode. This gives the
   bottom word of a Q16 format, but we cheat here and simply shift the output
   1 bit to the right, giving us Q15 format with the result [0 1). Hence,
   the max value the ADC can put out is 0b0111 1111 1111 1000*/
#define ADC_MAX_VAL             (0xFFF << 3)
#define ADC_VRAIL_GAIN          0.07621247113163972286374133949192
#define ADC_VRAIL_BPV           (ADC_VRAIL_GAIN*(ADC_MAX_VAL / ADC_REFV))


void ADCInit(void);

#endif // ADC_H
