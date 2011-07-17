#ifndef cheesyUART_H
#define cheesyUART_H
#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

extern BYTE actuators;

void UARTInit(void);
void UARTSendChar(char ch);
void UARTSendString(char* s);
void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt(void);

#endif
