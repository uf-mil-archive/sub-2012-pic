#ifndef MCP4821_H
#define MCP4821_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

/*
 * This function sets the DAC voltage output. It automatically turns
 * the DAC on.
 * Parameters:
 *  voltage:  0V - 4.096V
 */
void DAC_SetOutput(float voltage, int dacSel);

/*
 * Turns off DAC Output voltage. To turn it back on, write a new voltage
 * using DAC_SetOutput
 */
void DAC_Shutdown(int dacSel);

#endif // MCP4821_H
