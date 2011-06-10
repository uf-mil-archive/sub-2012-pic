#ifndef BLOCKING_DELAY_H
#define BLOCKING_DELAY_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"
#include "p33FJ128MC804.h"

/*
 * This file exposes a blocking timer that is sometimes necessary.
 * In a FreeRTOS task, you should never use this delay loop, but vTaskDelay
 * instead!!
 */

// Calculate the number of ticks/ms
#define BDELAY_TICKS    (((GetInstructionClock() / 8)/1000))

// Timer 1 is used
// This is not a precise blocking delay. It turns on and off the timer,
// so you will be guaranteed to have a longer delay than requested, but not by
// much (the instruction cycles to call the function are more).
void BlockingDelayms(INT16 ms);

#endif
