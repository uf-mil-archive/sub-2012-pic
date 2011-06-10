/********************************************************************
* FileName:		mavg.h
* Dependencies: queue.h, GenericTypeDefs.h
* Hardware:		Depth Board R1.0
* Compiler:		C30 3.00 or later
* Company:		MIL
*
*
* 
* File Description:
*
*
*
*
* Change History:
*
* Author      	Revision #      Date        Comment
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
********************************************************************/

#ifndef MAVG_H
#define MAVG_H

//********************* Includes ***********************************/
#include "GenericTypeDefs.h"
#include "simplequeue.h"
//******************************************************************/

struct MAVG
{
	xSimpleQueue DataQueue;
	UINT16 NumAverages;
	UINT32 CurrentAvgSum;
	UINT32 CurrentAvg;
};
typedef struct MAVG MAVGFilter;

/********************************************************************
* Function: 	void MAVG_Initialize(void)
*
* Precondition: None
*
* Input: 		None
*
* Output: 		None
*
* Side Effects:	None
*
* Overview: 	Initially fills the moving average filter.
*
*
* Note:		 	
********************************************************************/
void MAVG_Init(MAVGFilter *filter, UINT16 *data, INT16 sampleCount);

void MAVG_Update(MAVGFilter *filter, UINT16 *data, INT16 sampleCount);

#endif
