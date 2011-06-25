#ifndef MCP4821_H
#define MCP4821_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

// defines for the 16 and 32 volt slection
#define DAC_RAIL_16 0
#define DAC_RAIL_32 1


/*
 * This function sets the DAC voltage output. It automatically turns
 * the DAC on.
 * Parameters:
 *  voltage:  0V - 4.096V
 */
void DAC_SetOutput(float voltage, UINT16 dacSel);

/*
 * Turns off DAC Output voltage. To turn it back on, write a new voltage
 * using DAC_SetOutput
 */
void DAC_Shutdown();

#endif // MCP4821_H
