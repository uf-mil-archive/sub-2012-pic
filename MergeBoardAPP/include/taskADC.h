#ifndef ADC_H
#define ADC_H

#include "p33FJ128MC804.h"
#include "taskUART.h"
#include "fixMath.h"
#include "mavg.h"
#include "buzzer.h"
#include "I2C_FanControl.h"

#include <math.h>   // for pow

/* Configure these for the A/D settings and hardware */
#define ADC_MAVG_QUEUE_LENGTH   10
#define ADC_RATE                50 // How fast to run the task, in Hz

#define ADC_REFV                5.0 // The reference voltage of the ADC
/* The ADC is configured in 12 bit unsigned integer mode(Q12_0). Hence,
   the max value the ADC can put out is 0b0000 1111 1111 1111*/
#define ADC_MAX_VAL             (0x3FF)
// The VRail Voltage divider gain
//#define ADC_VRAIL16_GAIN  (1.0/4.0)       // should be this
#define ADC_VRAIL16_GAIN    (3.944/16.01)   // but is actually this
//#define ADC_VRAIL32_GAIN    (100.0/798.0)
//#define ADC_VRAIL32_GAIN    (100.0/798.0)
#define ADC_VRAIL32_GAIN    (100.0/798.0)*(30.05/34.4)
// The Current Divider Gain
#define ADC_CURRENT16_GAIN        (4.0/40.0)*(14.08/16.51)
#define ADC_CURRENT32_GAIN        (3.0/60.0)*(26.18/33.5)

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
#define DEFAULT_MAX_CURRENT16   ((Q7_9)(35<<9))     //25 AMPS in Q7_9
#define DEFAULT_MAX_VOLTAGE16   ((Q6_10)(17 << 10)) // 17 volts in Q6_10
#define DEFAULT_MIN_VOLTAGE16   ((Q6_10)(13.500*pow(2,10))) // 13.12345 in Q6_10. If you want a decimal, you have to do it like this
#define DEFAULT_WARN_VOLTAGE16  ((Q6_10)(14.000*pow(2,10))) // 13.12345 in Q6_10. If you want a decimal, you have to do it like this


#define DEFAULT_MAX_CURRENT32   ((Q6_10)(45 << 10))  // 40 AMPS in Q6_10
#define DEFAULT_MAX_VOLTAGE32   ((Q6_10)(34 << 10)) // 17 volts in Q6_10
#define DEFAULT_MIN_VOLTAGE32   ((Q6_10)(26.500*pow(2,10))) // 13.12345 in Q6_10. If you want a decimal, you have to do it like this
#define DEFAULT_WARN_VOLTAGE32  ((Q6_10)(27.300*pow(2,10))) // 13.12345 in Q6_10. If you want a decimal, you have to do it like this


// FreeRTOS defines
#define STACK_SIZE_ADC     (configMINIMAL_STACK_SIZE * 4)

// Global Flag masks
#define MERGE_STATE_MASK_RAIL16 	(1 << 0)
#define MERGE_STATE_MASK_ONOFFSW  	(1 << 1)
#define MERGE_STATE_MASK_ESTOPSW   	(1 << 2)
#define MERGE_STATE_MASK_RAIL32 	(1 << 3)

// defines for the 16 and 32 volt slection
#define ADC_RAIL_16 0
#define ADC_RAIL_32 1

#define NUM_ADCS          5
#define NUM_ADC_SAMPLES   50

#define OVER_CURRRENT_DELAY_MS 	250
#define OVER_CURRENT_DELAY      (UINT16)((UINT32)OVER_CURRRENT_DELAY_MS * ADC_RATE / 1000)

#define CUTOFF_LOW_VOLTAGE16_DELAY_MS 	1000
#define CUTOFF_LOW_VOLTAGE16_DELAY      (UINT16)((UINT32)CUTOFF_LOW_VOLTAGE16_DELAY_MS * ADC_RATE / 1000)

#define CUTOFF_LOW_VOLTAGE32_DELAY_MS 	1000
#define CUTOFF_LOW_VOLTAGE32_DELAY      (UINT16)((UINT32)CUTOFF_LOW_VOLTAGE32_DELAY_MS * ADC_RATE / 1000)

#define CUTON_AFTER_LOW_VOLTAGE32_DELAY_MS 	1000
#define CUTON_AFTER_LOW_VOLTAGE32_DELAY      (UINT16)((UINT32)CUTON_AFTER_LOW_VOLTAGE32_DELAY_MS * ADC_RATE / 1000)

// defines used wth RailControl helper function
#define CONTROL_RAIL_16     0
#define CONTROL_RAIL_32     1
#define CONTROL_RAIL_BOTH   2

//#define TURN_OFF    0     //already defined in hardware.h
//#define TURN_ON     1     //already defined in hardware.h

typedef struct
{
    BYTE  state;        // current state of the EStop ; on/off/ ; Rails
                        // Bits 7:4 - N/A
                        // Bit  3   - 32 Rail ON/OFF State (1 = 32V Rail has Power ; 0 = 32V Rail has no powewr)
                        // Bit  2   - EStop Hall SW State (1= Enabled ; 0= Running Sub)
                        // Bit  1   - On/OFF Hall SW State (1 = ON ; 0= OFF)
                        // Bit  0   - 16V Rail ON/OFF State (1 = 16V Rail has Power ; 0 = 16V Rail has no powewr)

    Q6_10 VRail32[4];   // The 4 32V measurements
    Q6_10 Current32;    // 32V current measurement
    Q6_10 VRail16[4];   // The 4 32V measurements
    Q6_10 Current16;    // 32V current measurement

}RailData;

// Configuration options can go here
typedef struct
{
    Q7_9 MaxCurrent16;
    Q6_10 MinVoltage16;
    Q6_10 MaxVoltage16;
    Q6_10 WarnVoltage16;
    Q6_10 MaxCurrent32;
    Q6_10 MinVoltage32;
    Q6_10 MaxVoltage32;
    Q6_10 WarnVoltage32;
    UINT16 BaudDiv;     // The baud rate divisor
}RailConfig;

extern xSemaphoreHandle hCommonSPIMutex; // The mutex used for access to the shared SPI
extern xTaskHandle hADCTask;

extern RailData gRailData;
extern RailConfig gRailConfig;

void xADCTaskInit(void);
void taskADC(void* pvParameter);
void SaveRailConfig(RailConfig* railCfg);
void RailControl(UINT8 rail, UINT8 action);

#endif // ADC_H
