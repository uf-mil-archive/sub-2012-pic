#ifndef BUZZER_H
#define BUZZER_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

#define MAX_NOTE_LENGTH     65500
#define SONG_START_DELAY    100

//song commands

#define SONG_STOP_PLAYING   0
#define SONG_BUZZ           2
#define SONG_QUIET          3


#define SONG_DELAY4  MAX_NOTE_LENGTH
#define SONG_DELAY3  MAX_NOTE_LENGTH/2
#define SONG_DELAY2  MAX_NOTE_LENGTH/3
#define SONG_DELAY1  MAX_NOTE_LENGTH/6


//song names
#define LOWPOWER_SONG 	0
#define BADPOWER_SONG 	1
#define ON_SONG		2
#define OFF_SONG	3
#define ESTOP_ON_SONG	4
#define ESTOP_OFF_SONG	5


typedef struct
{
    int  song;              // song to play
    BYTE  count;            // beat counter
    int songs[10][100];    // songs to play
}SongData;

extern SongData gSongData;

void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void);
void buzzerInit();      // Initialize the change notification interupt
void buzz(int song);

#endif


