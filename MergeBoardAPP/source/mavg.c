/********************************************************************
* FileName:		mavg.c
* Dependencies: mavg.h    
* Processor:	PIC24FJ64GA002
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
#include "mavg.h"

// This primes the moving average filter. It starts by inserting raw values
// into the queue, and the initial average is the first plain average
// calculated using the queue size. This is not a very good average and you should
// wait queuesize*enqueue_time after calling this function before you use the data.
void MAVG_Init(MAVGFilter *filter, UINT16 *data, INT16 queueLength)
{
	if(queueLength > MAX_SQUEUE_SIZE )
		queueLength = MAX_SQUEUE_SIZE ;
	
	filter->NumAverages = queueLength;
	INT16 i = 0;
	UINT32 sum = 0;
	for(i = 0; i < filter->NumAverages; i++)
	{
		sum += *data;
		SEnqueue(&(filter->DataQueue), *data++);
	}
	
	filter->CurrentAvgSum = sum;
	sum /= filter->NumAverages;
	filter->CurrentAvg = sum;

	return;
}

void MAVG_Update(MAVGFilter *filter, UINT16 *data, INT16 sampleCount)
{
	UINT32 oldVal;
    INT16 count;

	SDequeue(&(filter->DataQueue), &oldVal);
	
	UINT32 sum = 0;
		
	for(count = 0; count < sampleCount; count++)
	{
		sum += *data++;
	}

	sum /= sampleCount;
	
	SEnqueue(&(filter->DataQueue), sum);

	// Uniform distribution moving average, not symmetric
        filter->CurrentAvgSum =  filter->CurrentAvgSum - oldVal + sum;
	
	filter->CurrentAvg = filter->CurrentAvgSum / filter->NumAverages;

	return;
}
