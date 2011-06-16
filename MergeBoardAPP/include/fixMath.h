#ifndef FIXMATH_H
#define FIXMATH_H

#include "GenericTypeDefs.h"

// These help me keep straight what I'm doing in fixed point
#define Q1_15   UINT16
#define Q6_10   UINT16
#define Q12_0   UINT16
#define Q4_12   UINT16
#define Q7_9   UINT16


#define Q8_24   UINT32
#define Q6_26   UINT32
#define Q6_16   UINT32

// This is a hacked way to handle the signs for the motor control loop
// The S signifies a leading sign bit, followed by the normal unsigned
// nomenclature. This is just used as a flag, then removed before doing
// standard unsigned fixed point math
#define QS7_8   UINT16


#endif //FIXMATH_H
