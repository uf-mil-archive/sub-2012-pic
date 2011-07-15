#ifndef cheesyUART_H
#define cheesyUART_H
#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

#define ACTUATOR1_MASK (1<<0)
#define ACTUATOR2_MASK (1<<1)
#define ACTUATOR3_MASK (1<<2)
#define ACTUATOR4_MASK (1<<3)
#define ACTUATOR5_MASK (1<<4)

void UARTInit(void);
void UARTSendChar(char ch);
void UARTSendString(char* s);
void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt(void);

#endif
