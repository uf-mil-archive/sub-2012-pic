////////////////////////////////////////////////////////////////////////////////
// I2C Fan Controller (source)                       Authored by:   Paul Launier
////////////////////////////////////////////////////////////////////////////////


#include "I2C_FanControl.h"
#include "p33FJ128MC804.h"

unsigned int jDone;
I2C_DRV i2cfan = I2C_FANDRV_DEFAULTS;
I2C_FAN_DATA fanData;


/*=============================================================================
I2C Master Interrupt Service Routine
=============================================================================*/
void __attribute__((interrupt, no_auto_psv)) _MI2C1Interrupt(void)
{
		jDone=1;
        IFS1bits.MI2C1IF = 0;		//Clear the Interrupt Flag;

}


/*=============================================================================
I2C Slave Interrupt Service Routine
=============================================================================*/
void __attribute__((interrupt, no_auto_psv)) _SI2C1Interrupt(void)
{

        IFS1bits.SI2C1IF = 0;		//Clear the Interrupt Flag
}

void FanFullOn(I2C_DRV *i2cDRV){

        //set fan to FULL ON
        i2cDRV->cmd = I2C_WRITE;
        i2cDRV->oData->addr = FANCNTRL_ADDR;
        i2cDRV->oData->reg = FANCON;
        i2cDRV->oData->buff = 0b000010;    // FULLON, 5 Volts, prescaler = 4

        //while(i2cDRV->cmd!=I2C_IDLE && i2cDRV->cmd != I2C_ERR){
        //    I2Cdrv(i2cDRV);
        //}

}


void FanFullOff(I2C_DRV *i2c){

        //set fan to FULL OFF
        i2c->cmd = I2C_WRITE;
        i2c->oData->addr = FANCNTRL_ADDR;
        i2c->oData->reg = FANCON;
        i2c->oData->buff = 0b010010;    // FULLOFF, 5 Volts, prescaler = 4

        //while(i2c->cmd!=I2C_IDLE){
        //    I2Cdrv(i2c);
        //    if (i2c->cmd==I2C_ERR) break;
        //}
       
        return;
}

void FanOpenLoop(I2C_DRV *i2c){

        //set fan to FULL ON
        i2c->cmd = I2C_WRITE;
        i2c->oData->addr = FANCNTRL_ADDR;
        i2c->oData->reg = FANCON;
        i2c->oData->buff = 0x3A;    // OPEN LOOP, 12 Volts, prescaler = 4

        while(i2c->cmd!=I2C_IDLE){
            I2Cdrv(i2c);
            if (i2c->cmd==I2C_ERR) break;
        }

        return;
}

void FanClosedLoop(I2C_DRV *i2c){

        //set fan to FULL ON
        //closed loop speed will be set using the
        i2c->cmd = I2C_WRITE;
        i2c->oData->addr = FANCNTRL_ADDR;
        i2c->oData->reg = FANCON;
        i2c->oData->buff = 0x2A;    // CLOSED LOOP, 12 Volts, prescaler = 4

        while(i2c->cmd!=I2C_IDLE){
            I2Cdrv(i2c);
            if (i2c->cmd==I2C_ERR) break;
        }

        return;
}

void FanSetRPM(I2C_DRV *i2c, unsigned int rpm){
    //right now this is not rpm. the rpm var is the value that
    //will get directly written to the DAC. the calculation for rpm can be
    //added after debugging is over.

    //This is used only for open loop control.

    if (rpm < 1) rpm = 1;
    else if(rpm > 124) rpm = 124;

    i2c->cmd = I2C_WRITE;
    i2c->oData->addr = FANCNTRL_ADDR;
    i2c->oData->reg = FANDAC;
    //i2c->oData->buff = (3968/(rpm/60))-1;
    i2c->oData->buff = rpm;
    while(i2c->cmd!=I2C_IDLE){
        I2Cdrv(i2c);
        if (i2c->cmd==I2C_ERR) break;
    }

    return;
}


unsigned int FanReadTach(I2C_DRV *i2c){

    i2c->cmd = I2C_READ;
    i2c->oData->addr = FANCNTRL_ADDR;
    //i2c->oData->reg = FANDAC;
    i2c->oData->reg = FANTACH;
    i2c->oData->buff = 0x00;        //buffer doesn't matter for a read.

    while(i2c->cmd!=I2C_IDLE){
        I2Cdrv(i2c);
        if (i2c->cmd==I2C_ERR) break;
    }

        return i2c->oData->buff;
}


unsigned int TempRead(I2C_DRV *i2c){

    i2c->cmd = I2C_READ;
    i2c->oData->addr = TEMP_ADDR;
    i2c->oData->reg = 0x00;     //temp register
    i2c->oData->buff = 0x00;    //buffer doesn't matter for a read.

    while(i2c->cmd!=I2C_IDLE){
        I2Cdrv(i2c);
        if (i2c->cmd==I2C_ERR) break;
    }

        return i2c->oData->buff;
}

unsigned int I2CRead(I2C_DRV *i2c, unsigned int reg){
    
    i2c->cmd = I2C_READ;
    i2c->oData->addr = TEMP_ADDR;
    i2c->oData->reg = 0x00;         //temp register
    i2c->oData->buff = 0x00;        //buffer doesn't matter for a read.

    while(i2c->cmd!=I2C_IDLE){
        I2Cdrv(i2c);
        if (i2c->cmd==I2C_ERR) break;
    }

        return i2c->oData->buff;
}

/*=============================================================================
I2C Peripheral Initialization
=============================================================================*/
void I2Cinit(I2C_DRV *i2c)
{
    //This function sets up the dsPIC as the sole master device.
    //I2C Pins must be configured as open Drain. This is done in the
    //HardwareProfile.


    i2c->cmd=0;
    //i2c->oData=0;
    i2c->oData = &fanData;

    I2C1CONbits.A10M=0;     //Slave device has a 7 bit Address
//    I2C1CONbits.I2CSIDL=0;   // Continue module operation in Idle mode
    I2C1CONbits.SCLREL=1;   //Release Clock
    I2C1BRG=300;            //set I2C BAUD Rate to roughly 100kHz

    I2C1ADD=0;              //Not used (set to zero)
    //I2C1ADD=FANCNTRL_ADDR;  //Set the Slave Address
    I2C1MSK=0;              //Disable Adress Masking

//    IPC4bits.SI2C1IP = 7;   // Set interrupt priority to 6
    I2C1CONbits.I2CEN=1;    //enable the i2C module
    IEC1bits.MI2C1IE = 1;   //Enable I2C1 Master Event Interrupts
    IFS1bits.MI2C1IF = 0;   //Clear I2C1 Interupt Flag


}// end of I2Cinit


/*=============================================================================
I2C Serial, STATE-MACHINE BASED DRIVER
=============================================================================*/
void I2Cdrv(I2C_DRV *i2c)
{

static int state=0, cntr=0, rtrycntr=0;

    switch(state)
    {
    case 0:
            if  (i2c->cmd == I2C_WRITE || i2c->cmd == I2C_READ)
                state=1;
            break;

	/*==================================*/
	/* Control/Address Phase            */
	/*==================================*/
    case 1:
            // Start Condition
            I2C1CONbits.SEN=1;
            state++;
            break;

    case 2:
        // Start Byte with device select id
        // I2C read/write operation begins with transmitting control byte first.
        // This control byte contains 8bits as shown below
        //  ----------------------------------------
        // | A6 | A5 | A4 | A3 | A2 | A1 | A0 | R/W |
        //  ----------------------------------------

            if(jDone==1){
                jDone=0;
                state++;
                I2C1TRN = ( ((i2c->oData->addr)&0x7F)<<1 );
            }
            break;

    	/*=============================*/
	/* Write Phase                 */
	/*=============================*/

     case 3:
       	// Send Register byte if ack is received. Else Retry
            if(jDone==1){
                jDone=0;
                if(I2C1STATbits.ACKSTAT==1) {   // Ack Not received, Retry
                    if(rtrycntr < MAX_RETRY)
                        state=18;
                    else
                        state=16; // Flag error and exit

                } else {
                    rtrycntr=0;
                    I2C1TRN = (i2c->oData->reg);
                    state++;
                }
            }
            break;

    case 4:
		// Send Data Byte if ack is received. Else Flag error and exit

            if(jDone==1){
                jDone=0;
                if(I2C1STATbits.ACKSTAT==1) {	// Ack Not received, Flag error and exit
                    state=16;

                } else if(i2c->cmd == I2C_READ){
                    state=5;

                } else {
                   I2C1TRN=(i2c->oData->buff);
                    state = 14;     //Done with Write stage
                }
            }
    	break;

	/*==================================*/
	/* Read Data Phase                  */
	/*==================================*/
    case 5:
            // Repeat Start
 		I2C1CONbits.RSEN=1;
		state++;
        break;

    case 6:
		// Re-send control byte with W/R=R
            if(jDone==1){
                jDone=0;
          	state++;
                I2C1TRN=( (0x0001)|((i2c->oData->addr)&0x7F)<<1);
            }
        break;

    case 7:
            // Check, if control byte went ok
	    if(jDone==1){
                jDone=0;
          	state++;

                if(I2C1STATbits.ACKSTAT==1) // Ack Not received, Flag error and exit
                    state=16;
            }
        break;

    case 8:
            // Receive Enable
            I2C1CONbits.RCEN=1;
            state++;
        break;

    case 9:
            // Receive data
	    if(jDone==1){
                jDone=0;
		state++;
                i2c->oData->buff=I2C1RCV;
		
                I2C1CONbits.ACKDT=1; // Send NACK
		I2C1CONbits.ACKEN=1;
            }
        break;

    case 10:
	    //wait for ACK to send
            if(jDone==1){
		jDone=0;
            	state=14;
            }
        break;


	/*==================================*/
	/* Stop Sequence			        */
	/*==================================*/
    case 14:
      	I2C1CONbits.PEN=1;
        state++;
        break;

    case 15:
 	    if(jDone==1)	{
			jDone=0;
			state=0;
			cntr=0;
			i2c->cmd=0;
		}
      	break;

	/*==================================*/
	/* Set Error     			        */
	/*==================================*/
    case 16:
       	I2C1CONbits.PEN=1;
      	state++;
        break;

    case 17:
 	    if(jDone==1)	{
			jDone=0;
			state=0;
			rtrycntr=0;
			cntr=0;
			i2c->cmd=0xFFFF;
		}
      	break;

	/*==================================*/
	/* Retry         			        */
	/*==================================*/
    case 18:
            I2C1CONbits.PEN=1;	//Initiate Stop condition on SDAx and SCLx pins
            state++;
            rtrycntr++;
            break;

    case 19:
 	    if(jDone==1){
                jDone=0;
                state=0;
                cntr=0;
            }
            break;

    }//end Switch

}//end i2cdriver
