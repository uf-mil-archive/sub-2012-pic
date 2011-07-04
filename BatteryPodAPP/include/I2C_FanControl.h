////////////////////////////////////////////////////////////////////////////////
// I2C Fan Controller (header)                       Authored by:   Paul Launier
////////////////////////////////////////////////////////////////////////////////
#ifndef I2C_FanControl_H
#define I2C_FanControl_H

#include "HardwareProfile.h"
#include "GenericTypeDefs.h"

#define MAX_RETRY   1000

// FAN CONTROLLER ADDRESS
#define FANCNTRL_ADDR 0x48
#define TEMP_ADDR 0x18


// I2C DRIVER COMMAND DEFINITION
#define I2C_IDLE        0  
#define I2C_WRITE       1      
#define I2C_READ        2    
#define I2C_ERR        0xFFFF

#define FANRPM(a)   (3968/(a/60))-1

//Fan Controller Registers
#define FANSPEED    0x00        //Fan speed
#define FANCOUNT    0x16
#define FANDAC      0x06
#define FANTACH     0x0C
#define FANCON      0x02       // MODE:  (Operating Mode)
                                //      00 = Software full-on (default)
                                //      01 = Software off/shutdown
                                //      10 = Closed-loop operation (mergeboard)
                                //      11 = Open-loop operation
                                // VOLTAGE:  (Fan/Tachometer Voltage)
                                //      0 = 5V
                                //      1 = 12V (default / mergeboard)
                                // SCALE: (Prescaler Division)
                                //      000 = Divide by 1
                                //      001 = Divide by 2
                                //      010 = Divide by 4 (default/mergeboard)
                                //      011 = Divide by 8 
                                //      100 = Divide by 16

// I2C DATA OBJECT
typedef struct { 
        unsigned int reg;     // Register where data will be written
        unsigned int buff;    // data buffer for read and write data
        unsigned int addr;     // slave Address
}I2C_FAN_DATA;

// I2C DRIVER OBJECT
typedef struct { 
        unsigned int cmd;       // command input (Read/Write)
	I2C_FAN_DATA *oData;    // i2c data object
        void (*init)(void *);   // function pointer to initialization
        void (*drive)(void *);   // function pointer to Driver
        }I2C_DRV; 

#define I2C_FANDRV_DEFAULTS { 0,\
        (I2C_FAN_DATA *)0,\
        (void (*)(void *))I2Cinit,\
        (void (*)(void *))I2Cdrv}

#define I2C_DRV_DEFAULTS { 0,\
        (I2C_DATA *)0,\
        (void (*)(void *))I2Cinit,\
        (void (*)(void *))I2Cdrv}  


extern I2C_DRV i2cfan;
extern I2C_FAN_DATA fanData;
extern unsigned int jDone;


void __attribute__((interrupt, no_auto_psv)) _MI2C1Interrupt(void);
void __attribute__((interrupt, no_auto_psv)) _SI2C1Interrupt(void);
void FanFullOn(I2C_DRV *i2c);
void FanFullOff(I2C_DRV *i2c);
void FanOpenLoop(I2C_DRV *i2c);
void FanClosedLoop(I2C_DRV *i2c);
unsigned int FanReadTach(I2C_DRV *i2c);
void FanSetRPM(I2C_DRV *i2c, unsigned int rpm);
unsigned int I2CRead(I2C_DRV *i2c, unsigned int reg);
void I2Cinit(I2C_DRV *i2c);
void I2Cdrv(I2C_DRV *i2c);

#endif //end I2C_FanControl_H
