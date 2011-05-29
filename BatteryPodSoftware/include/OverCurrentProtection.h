////////////////////////////////////////////////////////////////////////////////
// Overcurrent Protection (header)                   Authored by:   Paul Launier
//
// Created: 05/01/2011                       Last Modified: 05/01/2011  10:53 PM
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following header contains prototypes for initializing the interputs
//  associated with the Fault protection.
//
//  TODO:
//
////////////////////////////////////////////////////////////////////////////////
#ifndef OVERCURRENTPROTECTION_H
#define OVERCURRENTPROTECTION_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

void overCurrent_Init(void);
void __attribute__((__interrupt__)) _INT0Interrupt(void);
void __attribute__((__interrupt__)) _INT1Interrupt(void);


#endif
