#ifndef BUZZER_H
#define BUZZER_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void);
void buzzerInit();      // Initialize the change notification interupt

#endif
