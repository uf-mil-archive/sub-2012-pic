#ifndef ADC_H
#define ADC_H

#include "p33Fxxxx.h"
#include "HardwareProfile.h"
#include "taskPublisher.h"
#include "fixMath.h"
#include "mavg.h"
#include "math.h"

/* Configure these for the A/D settings and hardware */
#define ADC_DMA_BUFFER_SIZE     128
#define ADC_MAVG_QUEUE_LENGTH   7

#define ADC_REFV                3.3 // The reference voltage of the ADC
/* The ADC is configured in 12 bit unsigned integer mode(Q12_0). Hence,
   the max value the ADC can put out is 0b0000 1111 1111 1111*/
#define ADC_MAX_VAL             (0xFFF)
// The Pressure Transducer gain, this will change volts to pressure.
// The transducer is 0.5-4.5V for 14.5-50PSIA. The voltage divider gain is included.
#define ADC_VPRES_GAIN          ((4.0/35.5)*(10.0/16.8))

// The pressure measurement is calibrated to yield 14.5psia at 0.5V. If the voltage
// isn't in that range, its invalid.

// then the relation between depth for freshwater and pressure
// (.432psi per foot = 1.417322834645669136psi/m => 0.70555555555555563288444444444445 m/psi) 
#ifdef FRESHWATER    
    #define PRESSURE_TO_DEPTH   ((Q6_10)(0.70555555555555563288444444444445*pow(2,10)))
#endif

// The Thermistor Gain
#define ADC_VTHERM_GAIN        (10.0/16.8)

/* Shouldn't need to edit these */
// The calculated maximum measurable pressure
#define ADC_VPRES_MMP           (ADC_REFV/ADC_VPRES_GAIN)
// The amount of pressure per bit for VPres measurements
#define ADC_VPRES_BPP           ((Q1_15)((ADC_VPRES_MMP / ADC_MAX_VAL) * 32767))

// The calculated maximum measurable temperature for the thermistor
#define ADC_VTHERM_MMT         (ADC_REFV/ADC_VTHERM_GAIN)
// The amount of degC per bit for thermistor temp measurements
#define ADC_VTHERM_BPC         ((Q1_15)((ADC_VTHERM_MMT / ADC_MAX_VAL) * 32767))

#define HEARTBEAT_TIMEOUT_TICKS     3000    // ~2s at 1.5kHz tick rate of A/D
#define ADC_FLAGMASK_HEARTBEAT      (1<<0)

typedef struct
{
    UINT8 Flags;
    UINT16 InterruptCount;
    Q6_10 Depth;
    Q8_8 ThermTemp;
    UINT16 Humidity;
    UINT16 HumTemp;
}SensorData;

extern SensorData gSensorData;

void ADCInit(void);
inline void FeedHeartbeat(void);

#endif // ADC_H
