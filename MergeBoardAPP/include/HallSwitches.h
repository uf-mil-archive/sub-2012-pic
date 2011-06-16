////////////////////////////////////////////////////////////////////////////////
// Hall Effect Switches (header)                     Authored by:   Paul Launier
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following header contains prototypes for initializing the Hall effect
//  Sensors.
////////////////////////////////////////////////////////////////////////////////
#ifndef HALLSWITCHES_H
#define HALLSWITCHES_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"



void hallSwInit();      // Initialize the change notification interupt
void __attribute__ ((__interrupt__)) _CNInterrupt(void);

#endif
