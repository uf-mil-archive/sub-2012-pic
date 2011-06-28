////////////////////////////////////////////////////////////////////////////////
// Overcurrent Protection (header)                   Authored by:   Paul Launier
////////////////////////////////////////////////////////////////////////////////
#ifndef OVERCURRENTPROTECTION_H
#define OVERCURRENTPROTECTION_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

void overCurrentInit(void);
void __attribute__((__interrupt__)) _INT0Interrupt(void);
void __attribute__((__interrupt__)) _INT1Interrupt(void);


#endif
