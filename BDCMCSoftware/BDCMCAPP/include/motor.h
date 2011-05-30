#ifndef MOTOR_H
#define MOTOR_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"
#include "mcp25XX640A.h"
#include <math.h>

// The motor control module uses Timer4
#define MTR_TICK_RATE     1000      // 1    kHz control loop
#define MTR_INT_PRIORITY   3

// Type 0 is reserved to mean uninitialized controller
#define MTR_TYPE_BROL   1   // Brushed Open Loop Motor
#define MTR_TYPE_BRCL   2   // Brushed Closed Loop Motor
#define MTR_TYPE_BLOL   3   // Brushless Open Loop Motor
#define MTR_TYPE_BLCL   4   // Brushless Closed Loop Motor

#define MTR_BR_FORWARD     0x0000   // Motor turns forward
#define MTR_BR_BACKWARD    0x0001   // Motor turns in reverse

#define HEARTBEAT_TIMEOUT_TICKS     (MTR_TICK_RATE*2)   // 2s Timeout
#define MTR_MAX_DUTY        ((1 << 12) - 1)
#define MTR_MAX_PERCENT     94.0
#define MTR_MIN_PERCENT     6.0
#define MTR_AMPS_SCALE      (10.0/(2.0/3.3*((1<<12) - 1)))
#define MTR_RAILVOLTS_SCALE (10.0/(2.0/3.3*((1<<12) - 1)))

typedef struct tagMotorFlags
{
    union
    {
        INT16 All;
        struct
        {
            unsigned :9;

            unsigned Endianess:1;        // Endianess of published packet
            unsigned ReferenceChanged:1; // Reference has been changed
            unsigned OverCurrent:1;      // Over current detected
            unsigned UnderVoltage:1;     // Voltage too low
            unsigned Heartbeat:1;        // Heartbeat valid
            unsigned MotorType:2;
        };
    };
}MotorFlags;

typedef struct MotorDataDefinition
{
    BYTE Address;          // This motor module address
    MotorFlags Flags;
    INT16 InterruptCount;
    INT16 ReferenceInput;
    INT16 ReferenceDuty;
    INT16 PresentOutput;
    INT16 PresentDuty;
    INT16 VRail;
    INT16 Current;
    INT16 RPM;
    INT16 MaxSlew;          // PWM max slew change
    INT16 MaxVoltage;       // The desired running maximum voltage, this will 
                            // actually scale effor to not distort the 
                            // linearization plot
    INT16 HardMaxVoltage;   // The maximum voltage used when the thruster was plotted
    INT16 MinVoltage;
    INT16 MaxCurrent;
    float FCoeff[6];
    float RCoeff[6];
} MotorData;

extern MotorData *hMotorData;   // Pointer to motor data in use by controller
extern MotorData BROLMotorData;

void MotorInit(void);
void ChargeBootStraps(void);
inline void FeedHeartbeat(void);
INT16 MotorGetAmpsString(MotorData* data, BYTE* buf);
INT16 MotorGetRailVoltsString(MotorData* data, BYTE* buf);

#endif // MOTOR_H
