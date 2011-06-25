#include "buzzer.h"
#include "p33Fxxxx.h"


SongData gSongData;

void __attribute__((__interrupt__, no_auto_psv)) _T4Interrupt(void)
{
	IFS1bits.T4IF = 0; // Clear Timer1 Interrupt Flag

	if (gSongData.count >= 20 || gSongData.songs[gSongData.song][gSongData.count] == 4	) {
		gSongData.count = 0;
		BUZZER = TURN_OFF;
		T4CONbits.TON = 0; // Stop Timer		
		TMR4 = 0x00; // Clear timer register
		PR4 = 0;
	
	}else {

		if (gSongData.count%2 == 0 )
			BUZZER = TURN_ON;
		else 
			BUZZER = TURN_OFF;

		PR4 = gSongData.songs[gSongData.song][gSongData.count];		
		gSongData.count++;
	}
}


void buzzerInit()
{
	gSongData.song = 0;
	
	// LOW POWER Song
	gSongData.songs[0][0] = 65000;
	gSongData.songs[0][1] = 65000/4;
	gSongData.songs[0][2] = 65000;
	gSongData.songs[0][3] = 65000/4;
	gSongData.songs[0][4] = 65000;
	gSongData.songs[0][5] = 65000/4;
	gSongData.songs[0][6] = 65000;
	gSongData.songs[0][7] = 65000/4;
	gSongData.songs[0][8] = 65000;
	gSongData.songs[0][9] = STOP_PLAYING_SONG;
	
	// BAD POWER Song
	gSongData.songs[1][0] = 65000/2;
	gSongData.songs[1][1] = 65000/6;
	gSongData.songs[1][2] = 65000/2;
	gSongData.songs[1][3] = 65000/6;
	gSongData.songs[1][4] = 65000/2;
	gSongData.songs[1][5] = STOP_PLAYING_SONG ;
	
	//ON Song
	gSongData.songs[2][0] = 65000;
	gSongData.songs[2][1] = 1;
	gSongData.songs[2][2] = 65000;
	gSongData.songs[2][3] = 65000;
	gSongData.songs[2][4] = 65000;
	gSongData.songs[2][5] = 1;
	gSongData.songs[2][6] = 65000;
	gSongData.songs[2][7] =  STOP_PLAYING_SONG;

	//OFF Song
	gSongData.songs[3][0] = 1;
	gSongData.songs[3][1] = 1;
	gSongData.songs[3][2] = 65000;
	gSongData.songs[3][3] = 1;
	gSongData.songs[3][4] = 65000;
	gSongData.songs[3][5] = STOP_PLAYING_SONG;

	//ESTOP ON
	gSongData.songs[4][0] = 65000/3;
	gSongData.songs[4][1] = 65000/3;
	gSongData.songs[4][2] = STOP_PLAYING_SONG;
	
	//ESTOP OFF
	gSongData.songs[5][0] = 65000/3;
	gSongData.songs[5][1] = 65000/3;
	gSongData.songs[5][2] = 65000/3;
	gSongData.songs[5][3] = 65000/3;
	gSongData.songs[5][4] =  STOP_PLAYING_SONG;


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
	PR4 = 1;
	TMR4 = 0x00; // Clear timer register
	T4CONbits.TON = 1; // Start/Stop Timer
}