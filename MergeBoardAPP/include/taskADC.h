#ifndef ADC_H
#define ADC_H

#include "p33FJ128MC804.h"
#include "taskUART.h"
#include "fixMath.h"
#include "mavg.h"

#include <math.h>   // for pow

/* Configure these for the A/D settings and hardware */
#define ADC_MAVG_QUEUE_LENGTH   10
#define ADC_RATE                50 // How fast to run the task, in Hz

#define ADC_REFV                5.0 // The reference voltage of the ADC
/* The ADC is configured in 12 bit unsigned integer mode(Q12_0). Hence,
   the max value the ADC can put out is 0b0000 1111 1111 1111*/
#define ADC_MAX_VAL             (0x3FF)
// The VRail Voltage divider gain
#define ADC_VRAIL16_GAIN          (1.0/4.0)
#define ADC_VRAIL32_GAIN          (100.0/798.0)
// The Current Divider Gain
#define ADC_CURRENT16_GAIN        (4.0/40.0)
#define ADC_CURRENT32_GAIN        (3.0/60.0)

// The calculated maximum measurable voltage for VRail
#define ADC_VRAIL16_MMV           (ADC_REFV/ADC_VRAIL16_GAIN)
#define ADC_VRAIL32_MMV           (ADC_REFV/ADC_VRAIL32_GAIN)
// The amount of volts per bit for VRail measurements
#define ADC_VRAIL16_BPV           ((Q1_15)((ADC_VRAIL16_MMV / ADC_MAX_VAL) * 32767))
#define ADC_VRAIL32_BPV           ((Q1_15)((ADC_VRAIL32_MMV / ADC_MAX_VAL) * 32767))

// The calculated maximum measurable amperage for Current
#define ADC_CURRENT16_MMA         (ADC_REFV/ADC_CURRENT16_GAIN)
#define ADC_CURRENT32_MMA         (ADC_REFV/ADC_CURRENT32_GAIN)

// The amount of amps per bit for Current measurements
#define ADC_CURRENT16_APB         ((Q1_15)((ADC_CURRENT16_MMA / ADC_MAX_VAL) * 32767))
#define ADC_CURRENT32_APB         ((Q1_15)((ADC_CURRENT32_MMA / ADC_MAX_VAL) * 32767))

// Paul - these should be the fractional (fixed point) representations of you constants
#define DEFAULT_MAX_CURRENT16   0
#define DEFAULT_MAX_VOLTAGE16   ((Q6_10)(17 << 10)) // 17 volts in Q6_10
#define DEFAULT_MIN_VOLTAGE16   ((Q6_10)(13.12345*pow(2,10))) // 13.12345 in Q6_10. If you want a decimal, you have to do it like this

// FreeRTOS defines
#define STACK_SIZE_ADC     (configMINIMAL_STACK_SIZE * 4)

// Global Flag masks
#define MERGE_FLAGMASK_KILLSW   (1 << 0)

// defines for the 16 and 32 volt slection
#define ADC_RAIL_16 0
#define ADC_RAIL_32 1

#define NUM_ADCS          5
#define NUM_ADC_SAMPLES   50


// Paul - The functionality of your board is predominantly ADC
// conversions, so like I had a motordata struct in BDCMC, you'll
// have a RailData or something struct, defined like this
typedef struct
{
    BYTE  flags;       // Useful flags/etc.
    Q6_10 VRail32[4];   // The 4 32V measurements
    Q6_10 Current32;    // 32V current measurement
    Q6_10 VRail16[4];   // The 4 32V measurements
    Q6_10 Current16;    // 32V current measurement

}RailData;

// Configuration options can go here
typedef struct
{
    Q6_10 MaxCurrent16;
    Q6_10 MinVoltage16;
    Q6_10 MaxVoltage16;
    Q6_10 MaxCurrent32;
    Q6_10 MinVoltage32;
    Q6_10 MaxVoltage32;
    UINT16 BaudDiv;     // The baud rate divisor
}RailConfig;

extern xSemaphoreHandle hCommonSPIMutex; // The mutex used for access to the shared SPI
extern xTaskHandle hADCTask;

extern RailData gRailData;
extern RailConfig gRailConfig;

void xADCTaskInit(void);
void taskADC(void* pvParameter);
void SaveRailConfig(RailConfig* railCfg);

#endif // ADC_H
