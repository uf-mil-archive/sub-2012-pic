////////////////////////////////////////////////////////////////////////////////
// Merge Board Code                                  Authored by:   Devin Hughes
//                                                   Edited by  :   Paul Launier
//
// Created: 04/28/2011                       Last Modified: 04/29/2011   8:01 AM
////////////////////////////////////////////////////////////////////////////////
// Description:
//  The following code was explicetly written for the Mergeboard on subjugator7.
//
//  uC used: dsPIC33FJ128MC802
//
////////////////////////////////////////////////////////////////////////////////

#include "p33Fxxxx.h"
#include "HardwareProfile.h"
//#include "mcp4821.h"
//#include "HallSwitches.h"
//#include "adc108s022.h"
//#include "I2C_FanControl.h"
//UINT16 FanMinus;
//UINT16 FanPlus;

//#include "cheesyUART.h"
// Configuration Bits
_FOSCSEL(IESO_OFF & FNOSC_FRC)
_FOSC(FCKSM_CSECMD & OSCIOFNC_OFF & POSCMD_EC)
_FWDT(FWDTEN_OFF)
_FICD(ICS_PGD3 & JTAGEN_OFF)
_FPOR(PWMPIN_ON & HPOL_ON & LPOL_ON & ALTI2C_OFF)


/*************************/
/*  FUNCTION PROTOTYPES  */
/*************************/
static void clockInit(void);
//void configure_HALLSW(void);


/**********************/
/*  Global Variables  */
/**********************/
//extern UINT16 ADC16Val[5];
//extern UINT16 ADC32Val[5];

//I2C_DRV i2cfan = I2C_FANDRV_DEFAULTS;
// FANCTRLR;
//UINT16 FanMinus;
//UINT16 FanPlus;

// C30 Exception Handlers
// If your code gets here, you either tried to read or write
// a NULL pointer, or your application overflowed the stack
// by having too many local variables or parameters declared.
void _ISR __attribute__((__no_auto_psv__)) _AddressError(void)
{
    Nop();
    Nop();
}

void _ISR __attribute__((__no_auto_psv__)) _StackError(void)
{
    Nop();
    Nop();
}


////////////////////////////////////////////////////////////////////////////////
//                                 MAIN
////////////////////////////////////////////////////////////////////////////////

int main(void)
{
    /***********/
    /** SETUP **/
    /***********/

    clockInit();                // Set the clock frequency
    ioMap();                    // Initialize pins
    //UARTInit();                 // initialize UART
//    hallSwInit() ;              // Initialize HALL SW interupts

//    DAC_SetOutput(.5, 1);      //Set 32V Side DAC ouput
//    DAC_SetOutput(2.0, 2);      //Set 16V Side DAC ouput

    BUZZER = BUZZER_OFF;        // initial state of buzzer is off
    LED = LED_OFF;              // initial state of debug LED is off
 

    int i=0;         // temp var for delay loop
    int j=0;

  //  UINT16 FanVal = 1;
   // unsigned int tachVal=0;

   // FanMinus=0;
   // FanPlus=0;

// Initialize I2C for Fan Control
//        I2Cinit(&i2cfan);
 //       i2cfan.oData = &FANCTRLR;

//        FanVal = 75;
        //FanOpenLoop(&i2cfan);
        //FanSetRPM(&i2cfan,FanVal);

        //FanClosedLoop(&i2cfan);
        //FanFullOff(&i2cfan);

    /***************/
    /** MAIN LOOP **/
    /***************/
    // test
    for(;;)
    {

       //ADC_getData(16);
       //ADC_getData(32);
       //DAC_SetOutput(0.5, 16);
       LED ^= 1  ;
//       ENET_SW = TURN_ON ;
       // tachVal = FanReadTach(&i2cfan);

        //UARTSendChar( (char)tachVal );

        // UARTSendChar( 0 );

       for (i=0; i<10000; i++){ 
            for (j=0; j<100; j++){  Nop(); }  //delay loop
        }//end delay



       // for (j=0; j<5; j++){
       //   UARTSendChar( (char)(ADC16Val[j] >> 8) );
       //   UARTSendChar( (char)(ADC16Val[j]) );
       // }//end ADC16 UART
    
/*
        for (j=0; j<5; j++){
          UARTSendChar( (char)(ADC32Val[j] >> 8) );
          UARTSendChar( (char)(ADC32Val[j]) );
        }//end ADC32 UART
*/



/*
        if (FanPlus == 1){
            FanPlus = 0;
            if (++FanVal > 124) FanVal = 124;
            UARTSendChar( (char)FanVal );
            FanSetRPM(&i2cfan,FanVal);
        }
        else if (FanMinus == 1){
            FanMinus = 0;
            FanVal--;
            if (FanVal == 0) FanVal = 1;
            UARTSendChar( (char)FanVal );
            FanSetRPM(&i2cfan,FanVal);
        }
*/
       
    }//end MAIN LOOP

    return 1;
}
////////////////////////////////////////////////////////////////////////////////
//end Main

/*****************************************************************************
  Function:
        static void ioMap(void)
  Summary:

  Description:

 ***************************************************************************/
void ioMap(void)
{
    // Map the Analog pins
    AD1PCFGL = ANCONFIG;

    // set LED Pin as an output
    LED_TRIS = OUTPUT_PIN;

    // set Buzzer Pin as an output
    BUZZER_TRIS = OUTPUT_PIN;


    // Initialize the ADC CS pins and set them to fasle
    ADC16_CS_TRIS = OUTPUT_PIN;
    ADC16_CS_IO = AL_FALSE;

    ADC32_CS_TRIS = OUTPUT_PIN;
    ADC32_CS_IO = AL_FALSE;

    /********** High Side Drivers ***************/
    
    // Set the Highside Control pins as ouputs and turn them off
    RAIL16_TRIS = OUTPUT_PIN;   //16V Rail Control
    RAIL16 = TURN_OFF;

    RAIL32_TRIS = OUTPUT_PIN ;   //32V Rail Control
    RAIL32 = TURN_OFF;

    ENET_SW_TRIS = INPUT_PIN;   //Ethernet Switch Control
    ENET_SW = TURN_ON;

    /********** Set up the open drain pins ***************/
    #ifdef ODCACONFIG
        ODCA = ODCACONFIG;
    #endif
    #ifdef ODCBCONFIG
        ODCB = ODCBCONFIG;
    #endif
    #ifdef ODCCCONFIG
        ODCC = ODCCCONFIG;
    #endif

    // Clear the IOLOCK bit
    __builtin_write_OSCCONL(OSCCON & 0xFFBF);

    /********** ENC SPI ***************/

    // Inputs
    ENC_SDI_PINREG = ENC_SDI_PIN;
    // Outputs
    ENC_SCK_PIN = ENC_SPIxSCK_IO;
    #if defined ENC_SDO_PIN
        ENC_SDO_PIN = ENC_SPIxSDO_IO;
    #endif


    /********** Multiple Devices SPI ***************/

    // Inputs
    DAC_SDI_PINREG = DAC_SDI_PIN;
    // Outputs
    DAC_SCK_PIN = DAC_SPIxSCK_IO;
    #if defined DAC_SDO_PIN
        DAC_SDO_PIN = DAC_SPIxSDO_IO;
    #endif

    /********** Communication UART ***************/

    TRISCbits.TRISC7 = 0;   // UART TX TRIS for cheesyUART
    
    // Inputs
    COM_URX_PINREG = COM_URX_PIN;
    // Outputs
    COM_UTX_PIN = COM_UxTX_IO;

    // Lock the IOLOCK bit so that the IO is not accidentally changed.
    __builtin_write_OSCCONL(OSCCON | 0x0040);
}//end ioMap()


/*****************************************************************************
  Function:
        static void clockInit(void)
  Summary:
        Changes to the pll clock source to achieve 40 mips
  Description:
        Call first after power on to switch from non-PLL EC.
        It changes the multiplier and two dividers to allow
        for 10MHz input to produce 80MHz (2*Fcy)
 ***************************************************************************/
static void clockInit(void)
{
    PLLFBD = 0x1E; // M=32
    CLKDIVbits.PLLPOST = 0; // N2 = 2
    CLKDIVbits.PLLPRE = 0; // N1 = 2
    __builtin_write_OSCCONH(0x03); // Select Pri/PLL clock
    __builtin_write_OSCCONL(0x01); // Request clock switch
    while (OSCCONbits.COSC != 0b011); // Wait for oscillator to switch
}


/*****************************************************************************/
