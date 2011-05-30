////////////////////////////////////////////////////////////////////////////////
// Hall Effect Switches (header)                     Authored by:   Paul Launier
//
// Created: 04/29/2011                       Last Modified: 05/01/2011   8:36 AM
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following header contains prototypes for initializing the Hall effect
//  Sensors.
//
//  TODO:
//
////////////////////////////////////////////////////////////////////////////////
#ifndef HALLSWITCHES_H
#define HALLSWITCHES_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"


void hallSwInit();      // Initialize the change notification interupt
void __attribute__ ((__interrupt__)) _CNInterrupt(void);

#endif
