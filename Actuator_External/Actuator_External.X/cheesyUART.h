////////////////////////////////////////////////////////////////////////////////
// Cheesy UART transmisions
////////////////////////////////////////////////////////////////////////////////

#ifndef cheesyUART_H
#define cheesyUART_H
#include "HardwareProfile.h"
#include "../../Microchip/Include/GenericTypeDefs.h"

#define READ_SW 0x00
#define PING 0x40
#define SET_ACT 0x80
#define ERROR 0xFF

extern BYTE actuators;
extern BYTE UART_state;

void UARTInit(void);
void UARTAcknowledge(char ch);
void UARTSendChar(char ch);
void UARTSendString(char* s);
void __attribute__((__interrupt__, auto_psv)) _U2RXInterrupt(void);

#endif
