#ifndef MOTOR_H
#define MOTOR_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"
#include "mcp25XX640A.h"
#include "fixMath.h"
#include "blockingDelay.h"
#include "messages.h"   // For CRC-16

#include <math.h> // for pow()
#include <string.h> // for memset
#include "Compiler.h"


// The motor control module uses Timer4
#define MTR_TICK_RATE     1000      // 1    kHz control loop
#define MTR_INT_PRIORITY   3

#define MTR_CODE_NONE   0
#define MTR_CODE_BROL   1   // Brushed Open Loop Motor
#define MTR_CODE_BRCL   3   // Brushed Closed Loop Motor
#define MTR_CODE_BLOL   5   // Brushless Open Loop Motor
#define MTR_CODE_BLCL   7   // Brushless Closed Loop Motor

#define MTR_FORWARD     0x0305   // Motor turns forward
#define MTR_BACKWARD    0x0C05   // Motor turns in reverse

#define HEARTBEAT_TIMEOUT_TICKS     (MTR_TICK_RATE*2)   // 2s Timeout

#define MTR_100PERC_Q7_8    ((QS7_8)(100 << 8))

// Q6_10 - This is what the components on the PCB are designed to handle
#define MTR_PCB_MAX_VOLTAGE ((Q6_10)(50<<10))
// Q4_12 - This is the max current the PCB can handle
#define MTR_PCB_MAX_CURRENT ((Q6_10)(10<<12))

#define MTR_MAX_DUTY        (4095)
#define MTR_MAX_PWM_PERC    (3849)  // 96% of 4095
#define MTR_MIN_PWM_PERC    (246)   // 6% of 4095

#define MTR_DEFAULT_MANUFACTURER    "SEABOTIX"
#define MTR_DEFAULT_HMAXV           ((Q6_10)20480)	// ~20.0V
#define MTR_DEFAULT_MINV            ((Q6_10)(25 << 10))
#define MTR_DEFAULT_MAXCURRENT      ((Q4_12)(4 << 12))
#define MTR_DEFAULT_MAXSLEW         (15) // 1*1KHz =

// Flags
// Bits 210 = Motor Type
//  Bit 0 - indicates valid motor config
//  Bit 1 - 0 - open loop 1 - closed loop
//  Bit 2 - 0 - brushed 1 - brushless
// Bit 3 - Heartbeat
//  1 - valid heartbeat
// Bit 4 - UnderVoltage
//  1 - under voltage detected
// Bit 5 - OverCurrent
//  1 - overcurrent detected
// Bit 6 - ReferenceChanged
//  1 - new reference set - update reference PWM duty
#define MTR_FLAGMASK_MOTORCODE      (0x7)
#define MTR_FLAGMASK_CONTROLTYPE    (1 << 1)
#define MTR_FLAGMASK_MOTORTYPE      (1 << 2)
#define MTR_FLAGMASK_HEARTBEAT      (1 << 3)
#define MTR_FLAGMASK_UNDERVOLTAGE   (1 << 4)
#define MTR_FLAGMASK_OVERCURRENT    (1 << 5)
#define MTR_FLAGMASK_REFCHANGED     (1 << 6)

typedef struct MotorDataDefinition
{
    INT16 Flags;
    BYTE  Manufacturer[16]; // The manufacturer of the motor controlled
    Q6_10 HardMaxVoltage;   // The maximum voltage used when the thruster was plotted
    Q6_10 MinVoltage;       // The minimum voltage the motor controller will operate to
    Q4_12 MaxCurrent;       // The maximum current the motor is allowed to draw
    INT16 MaxSlew;          // PWM max slew change
    float FCoeff[6];
    float RCoeff[6];
    INT16 InterruptCount;
    INT16 ReferenceInput;
    INT16 ReferenceDuty;
    INT16 PresentOutput;
    INT16 PresentDuty;
    Q6_10 VRail;
    Q6_10 Current;
} MotorData;

extern MotorData *hMotorData;   // Pointer to motor data in use by controller
extern MotorData BROLMotorData;

void MotorInit(void);
void ChargeBootStraps(void);

// These functions require a valid hMotorData structure before calling!
inline void FeedHeartbeat(void);
inline void ReferenceChanged(void);

#endif // MOTOR_H
