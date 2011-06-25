#ifndef BUZZER_H
#define BUZZER_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

#define STOP_PLAYING_SONG	4
#define LOWPOWER_SONG 	0
#define BADPOWER_SONG 	1
#define ON_SONG			2
#define OFF_SONG		3
#define ESTOP_ON_SONG	4
#define ESTOP_OFF_SONG	5


typedef struct
{
    int  song;       	// song to play
    BYTE  count;		// beat counter
	int songs[10][20];	// songs to play
}SongData;

extern SongData gSongData;

void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void);
void buzzerInit();      // Initialize the change notification interupt
void buzz(int song);

#endif


