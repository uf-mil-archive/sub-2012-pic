#include "buzzer.h"
#include "p33Fxxxx.h"


SongData gSongData;

void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void)
{
    IFS1bits.T4IF = 0; // Clear Timer1 Interrupt Flag

    if (gSongData.songs[gSongData.song][gSongData.count] == SONG_STOP_PLAYING ||
		PR4 < SONG_START_DELAY) {
        BUZZER = TURN_OFF;
        T4CONbits.TON = 0; // Stop Timer
        gSongData.count = 0;
        TMR4 = 0x00; // Clear timer register
        PR4 = SONG_START_DELAY;

    }else {
        
        //check the command
        if (gSongData.songs[gSongData.song][gSongData.count] == SONG_BUZZ)
            BUZZER = TURN_ON;
        else
            BUZZER = TURN_OFF;

        gSongData.count++;

        //set the duration
        PR4 = gSongData.songs[gSongData.song][gSongData.count];

        gSongData.count++;
    }
}


void buzzerInit()
{
	gSongData.song = 0;

        // LOW POWER Song
	gSongData.songs[LOWPOWER_SONG][0] = SONG_BUZZ   ;
	gSongData.songs[LOWPOWER_SONG][1] = SONG_DELAY3 ;
	gSongData.songs[LOWPOWER_SONG][2] = SONG_QUIET  ;
	gSongData.songs[LOWPOWER_SONG][3] = SONG_DELAY2 ;
	gSongData.songs[LOWPOWER_SONG][4] = SONG_BUZZ   ;
	gSongData.songs[LOWPOWER_SONG][5] = SONG_DELAY3 ;
	gSongData.songs[LOWPOWER_SONG][6] = SONG_QUIET  ;
	gSongData.songs[LOWPOWER_SONG][7] = SONG_DELAY2 ;
	gSongData.songs[LOWPOWER_SONG][8] = SONG_BUZZ   ;
	gSongData.songs[LOWPOWER_SONG][9] = SONG_DELAY3 ;
        gSongData.songs[LOWPOWER_SONG][10] = SONG_QUIET  ;
	gSongData.songs[LOWPOWER_SONG][11] = SONG_DELAY2 ;
	gSongData.songs[LOWPOWER_SONG][12] = SONG_BUZZ   ;
	gSongData.songs[LOWPOWER_SONG][13] = SONG_DELAY3 ;
	gSongData.songs[LOWPOWER_SONG][14] = SONG_QUIET  ;
	gSongData.songs[LOWPOWER_SONG][15] = SONG_DELAY2 ;
	gSongData.songs[LOWPOWER_SONG][16] = SONG_BUZZ   ;
	gSongData.songs[LOWPOWER_SONG][17] = SONG_DELAY3 ;
        gSongData.songs[LOWPOWER_SONG][18] = SONG_STOP_PLAYING  ;
	
	// BAD POWER Song
	gSongData.songs[BADPOWER_SONG][0] = SONG_BUZZ   ;
	gSongData.songs[BADPOWER_SONG][1] = SONG_DELAY2 ;
	gSongData.songs[BADPOWER_SONG][2] = SONG_QUIET  ;
	gSongData.songs[BADPOWER_SONG][3] = SONG_DELAY2 ;
       	gSongData.songs[BADPOWER_SONG][4] = SONG_BUZZ   ;
	gSongData.songs[BADPOWER_SONG][5] = SONG_DELAY2 ;
	gSongData.songs[BADPOWER_SONG][6] = SONG_QUIET  ;
	gSongData.songs[BADPOWER_SONG][7] = SONG_DELAY2 ;
	gSongData.songs[BADPOWER_SONG][8] = SONG_BUZZ   ;
	gSongData.songs[BADPOWER_SONG][9] = SONG_DELAY2 ;
	gSongData.songs[BADPOWER_SONG][10] = SONG_QUIET  ;
	gSongData.songs[BADPOWER_SONG][11] = SONG_DELAY2 ;
	gSongData.songs[BADPOWER_SONG][12] = SONG_STOP_PLAYING ;
	
	//ON Song
	gSongData.songs[ON_SONG][0] =  SONG_BUZZ   ;
	gSongData.songs[ON_SONG][1] = SONG_DELAY4 ;
	gSongData.songs[ON_SONG][2] = SONG_QUIET   ;
	gSongData.songs[ON_SONG][3] = SONG_DELAY4 ;
	gSongData.songs[ON_SONG][4] = SONG_BUZZ  ;
	gSongData.songs[ON_SONG][5] = SONG_DELAY4 ;
        gSongData.songs[ON_SONG][8] = SONG_STOP_PLAYING  ;

	//OFF Song
	gSongData.songs[OFF_SONG][0] = SONG_BUZZ   ;
	gSongData.songs[OFF_SONG][1] = SONG_DELAY4 ;
	gSongData.songs[OFF_SONG][2] = SONG_BUZZ   ;
	gSongData.songs[OFF_SONG][3] = SONG_DELAY4 ;
	gSongData.songs[OFF_SONG][4] = SONG_STOP_PLAYING  ;

	//ESTOP ON
	gSongData.songs[ESTOP_ON_SONG][0] = SONG_BUZZ   ;
	gSongData.songs[ESTOP_ON_SONG][1] = SONG_DELAY1 ;
	gSongData.songs[ESTOP_ON_SONG][2] = SONG_STOP_PLAYING;
	
	//ESTOP OFF
	gSongData.songs[ESTOP_OFF_SONG][0] = SONG_BUZZ  ;
	gSongData.songs[ESTOP_OFF_SONG][1] = SONG_DELAY1 ;
        gSongData.songs[ESTOP_OFF_SONG][2] = SONG_QUIET  ;
	gSongData.songs[ESTOP_OFF_SONG][3] = SONG_DELAY1 ;
	gSongData.songs[ESTOP_OFF_SONG][4] = SONG_BUZZ  ;
	gSongData.songs[ESTOP_OFF_SONG][5] = SONG_DELAY1 ;
        gSongData.songs[ESTOP_OFF_SONG][6] = SONG_STOP_PLAYING ;
	

	T4CONbits.TON = 0; // Disable Timer
	T4CONbits.TCS = 0; // Select internal instruction cycle clock 
	T4CONbits.TGATE = 0; // Disable Gated Timer mode
	T4CONbits.TCKPS = 0b11; // Select 1:256 Prescaler
	TMR4 = 0x00; // Clear timer register
	PR4 = 1; // Load the period value
	IPC6bits.T4IP = 0x01; // Set Timer4 Interrupt Priority Level
	IFS1bits.T4IF = 0; // Clear Timer4 Interrupt Flag
	IEC1bits.T4IE = 1; // Enable Timer1 interrupt
	T4CONbits.TON = 0; // Start/Stop Timer
}

void buzz(int song){
	
	gSongData.song = song;
	gSongData.count = 0;
	PR4 = SONG_START_DELAY;
	TMR4 = 0x00; // Clear timer register
	T4CONbits.TON = 1; // Start/Stop Timer
}
