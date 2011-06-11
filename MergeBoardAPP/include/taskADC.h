#ifndef ADC_H
#define ADC_H

#include "p33FJ128MC804.h"
#include "taskUART.h"
#include "fixMath.h"
#include "mavg.h"

#include <math.h>   // for pow

/* Configure these for the A/D settings and hardware */
#define ADC_MAVG_QUEUE_LENGTH   10
#define ADC_RATE                250 // How fast to run the task, in Hz

#define ADC_REFV                3.3 // The reference voltage of the ADC
/* The ADC is configured in 12 bit unsigned integer mode(Q12_0). Hence,
   the max value the ADC can put out is 0b0000 1111 1111 1111*/
#define ADC_MAX_VAL             (0xFFF)
// The VRail Voltage divider gain
#define ADC_VRAIL_GAIN          (8.25/108.25)
// The Current Divider Gain
#define ADC_CURRENT_GAIN        (1.0/5.0)

// The calculated maximum measurable voltage for VRail
#define ADC_VRAIL_MMV           (ADC_REFV/ADC_VRAIL_GAIN)
// The amount of volts per bit for VRail measurements
#define ADC_VRAIL_BPV           ((Q1_15)((ADC_VRAIL_MMV / ADC_MAX_VAL) * 32768))

// The calculated maximum measurable amperage for Current
#define ADC_CURRENT_MMA         (ADC_REFV/ADC_CURRENT_GAIN)
// The amount of amps per bit for Current measurements
#define ADC_CURRENT_BPA         ((Q1_15)((ADC_CURRENT_MMA / ADC_MAX_VAL) * 32768))

// Paul - these should be the fractional (fixed point) representations of you constants
#define DEFAULT_MAX_CURRENT16   0
#define DEFAULT_MAX_VOLTAGE16   ((Q6_10)(17 << 10)) // 17 volts in Q6_10
#define DEFAULT_MIN_VOLTAGE16   ((Q6_10)(13.12345*pow(2,10))) // 13.12345 in Q6_10. If you want a decimal, you have to do it like this

// FreeRTOS defines
#define STACK_SIZE_ADC     (configMINIMAL_STACK_SIZE * 4)

// Paul - The functionality of your board is predominantly ADC
// conversions, so like I had a motordata struct in BDCMC, you'll
// have a RailData or something struct, defined like this
typedef struct
{
    UINT16 flags;       // Useful flags/etc.
    Q6_10 VRail32[4];   // The 4 32V measurements
    Q6_10 Current32;    // 32V current measurement
    Q6_10 VRail16[4];   // The 4 32V measurements
    Q6_10 Current16;    // 32V current measurement
    UINT16 BaudDiv;     // The baud rate divisor
}RailData;

// Configuration options can go here
typedef struct
{
    Q6_10 MaxCurrent16;
    Q6_10 MinVoltage16;
    Q6_10 MaxVoltage16;
}RailConfig;

extern xSemaphoreHandle hCommonSPIMutex; // The mutex used for access to the shared SPI
extern xTaskHandle hADCTask;

extern RailData gRailData;
extern RailConfig gRailConfig;

void xADCTaskInit(void);
void taskADC(void* pvParameter);
void SaveRailConfig(RailConfig* railCfg);

#endif // ADC_H
