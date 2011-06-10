#include "motor.h"
#include "p33FJ128MC804.h"
#include "taskTCPIP.h"
#include "mcp4821.h"


// Minimum PWM duty cycle due to deadtime is 6%, max 94%

MotorData BROLMotorData;

void (*controller)(void) = NULL;
MotorData *hMotorData = NULL;

Q6_26 MTR_FTable[101];
Q6_26 MTR_RTable[101];

void PWMInit(void);
void motorSetupTimer(void);
void BrushedDCOpenLoop(void);
inline void EnableMotorInterrupts(void);
inline void DisableMotorInterrupts(void);
void BROLInit(void);
void GetMotorDataFromEROM(MotorData** motor);

void MotorInit(void)
{
    // Pull in settings from EROM
    GetMotorDataFromEROM(&hMotorData);

    // Initialize the DAC and the comparator here

    DisableMotorInterrupts();

    PWMInit();  // Initialize the PWM module

    // Charge the boot straps. This leaves the low side fets turned on.
    ChargeBootStraps();
    
    // Now start firing controller events
    EnableMotorInterrupts();

    return;
}

void PWMInit(void)
{
    PWM1CON1 = 0x0033;      // PWM outputs, configure them into
                            // complimentary pairs
    P1DTCON1 = 0x0000;      // Deadtime clock period is Tcy
    P1DTCON1bits.DTA = 20;  // This sets up a 500ns dead time
    P1DTCON2 = 0x0000;      // Dead times are all coming from unit A

    // This formula is correct for free running PWM mode
    // PxTPER = (Fcy / (Fpwm*PxTMR Prescalar)) - 1
    // To run at the frequency we want (below the hydrophone but above audible)
    // we need a 1:1 prescalar.
    P1TPER = GetInstructionClock()/FPWM - 1;
    P1TCONbits.PTOPS = 9;   // Set's interrupt rate to 1/10 the PWM frequency
    P1OVDCON = 0x0000;      // Override controls the output pins
                            // clear all the outputs to low
    P1DC1 = 0;              // Initialize the duty cycle registers
    P1DC2 = 0;              // to off
    P1DC3 = 0;
    P1SECMP = 0;
    PWM1CON2 = 0x0000;      // 1:1 postscalar on the special event trigger for A/D
                            // Synchronized updates, override on clock boundaries


    P1TCONbits.PTEN = 1;    // Start PWM module (all pins are still off due to override)

    return;
}

void BrushedDCOpenLoop(void)
{
    QS7_8 x0;
    QS7_8 xdel0;
    INT16 direction;
    QS7_8 unsDesired;
    INT16 index;
    Q6_26 interpV;
    INT16 duty;

    /* If the reference input has changed, we calculate a new PWM reference.
     * The required PWM duty cycle is calculated by taking the percentage of
     * rail voltage we need to output, and then mapping this into the PWM duty
     * cycle range. First, we do a table lookup to get the desired voltage
     */
    if(BROLMotorData.Flags & MTR_FLAGMASK_REFCHANGED)
    {

        // Get the unsigned value and the direction flag
        direction = (INT16)(BROLMotorData.ReferenceInput & 0x8000);
        unsDesired = (BROLMotorData.ReferenceInput & 0x7FFF);


        // Check for 0 reference, no interpolation
        if(unsDesired == 0)
        {
            BROLMotorData.ReferenceDuty = 0;
            goto REFDONE;
        }
        
        // Check for saturating a table, no interpolation
        if(unsDesired >= MTR_100PERC_Q7_8)
        {
            // The tables hold Q6_26 voltages. The VRail is a Q6_10.
            // The result will be a QX_16 percentage, and we multiply this
            // by the max range of the PWM duty cycle, then shift away the
            // fractional portion.
            if(direction != 0)  // Reverse 
            {
                BROLMotorData.ReferenceDuty = 
                (INT16)
                (((MTR_RTable[100] / BROLMotorData.VRail) * MTR_MAX_DUTY) >> 16);
            }
            else    // Forward
            {
                BROLMotorData.ReferenceDuty =
                (INT16)
                (((MTR_FTable[100] / BROLMotorData.VRail) * MTR_MAX_DUTY) >> 16);
            }

            goto REFDONE;
        }

        // The point isn't on a table boundary, interpolation is necessary
        // The reference input is in QS7_8. So.. eliminate the sign and
        // shift to find the correct table index.
        index = (INT16)(unsDesired >> 8);

        // unsDesired and x0 should be in the same format so subtraction works.
        x0 = index << 8;  // The lower table entry, in QS7_8
        xdel0 = unsDesired - x0;

        // QS7_8 xdel1 = 256; // Table entries are always 1 << 8 apart.

        // Now check the sign to use the proper table
        if(direction != 0)  // Reverse
        {
            // Interpolate to get the right voltage - the result should be in Q6_26 format
            // (Q6_26 / Q7_8)= QX_18*Q7_8 = QX_26
            interpV = MTR_RTable[index] +
                (xdel0*((MTR_RTable[index+1] - MTR_RTable[index]) >> 8));

            BROLMotorData.ReferenceDuty =
                (INT16)
                (((interpV / BROLMotorData.VRail) * MTR_MAX_DUTY) >> 16);
        }
        else    // Forward
        {
            // Interpolate to get the right voltage - the result should be in Q6_26 format
            // (Q6_26 / Q7_8)= QX_18*Q7_8 = QX_26
            interpV = MTR_FTable[index] +
                (xdel0*((MTR_FTable[index+1] - MTR_FTable[index]) >> 8));

            BROLMotorData.ReferenceDuty =
            (INT16)
            (((interpV / BROLMotorData.VRail) * MTR_MAX_DUTY) >> 16);
        }

REFDONE:  
        // Clamp the reference value between
        // the acceptable PWM range which is limited by hardware
        if(BROLMotorData.ReferenceDuty > MTR_MAX_PWM_PERC)
            BROLMotorData.ReferenceDuty = MTR_MAX_PWM_PERC;
        else if(BROLMotorData.ReferenceDuty < MTR_MIN_PWM_PERC
                && BROLMotorData.ReferenceDuty != 0)
            BROLMotorData.ReferenceDuty = MTR_MIN_PWM_PERC;

        // Calculate the actual voltage being put out
        BROLMotorData.PresentOutput =
                ((((UINT32)BROLMotorData.ReferenceDuty << 16) / MTR_MAX_DUTY *
                BROLMotorData.VRail) >> 16);

        // Set the required direction sign - this helps with slew later
        if(direction != 0)
            BROLMotorData.ReferenceDuty *= -1;

        //Clear the reference changed flag
        hMotorData->Flags &= ~MTR_FLAGMASK_REFCHANGED;        
    }

     if(hMotorData->ReferenceDuty != hMotorData->PresentDuty)
    {
        // Motor speed is changing. Use the slew to find the new
        // duty cycle
        duty = hMotorData->PresentDuty;
        if(hMotorData->ReferenceDuty < hMotorData->PresentDuty)
        {
            duty -= hMotorData->MaxSlew;
            hMotorData->PresentDuty = (duty < hMotorData->ReferenceDuty)
                    ? hMotorData->ReferenceDuty : duty;
        }
        else
        {
            duty += hMotorData->MaxSlew;
            hMotorData->PresentDuty = (duty > hMotorData->ReferenceDuty)
                    ? hMotorData->ReferenceDuty : duty;
        }

        // And set the direction overrides
        if( hMotorData->PresentDuty < 0)
        {
            duty = -1*hMotorData->PresentDuty;
            P1OVDCON = MTR_BACKWARD;
        }
        else
        {
            duty =  hMotorData->PresentDuty;
            P1OVDCON = MTR_FORWARD;
        }

        // Set the duty cycles correctly (absolute value of output)
        P1DC1 = duty;
        P1DC2 = duty;

        // Set the new ADC sampling point
        P1SECMP = duty / 2;
    }

    
   // LED = LED_OFF;    // End Measurement
}

void ChargeBootStraps(void)
{
    // Brushed motors have zero in their motortype flag
    if((hMotorData->Flags & MTR_FLAGMASK_MOTORTYPE) == 0)
    {
         P1OVDCON = 0x0005;    // Turn on low side fets so bootstraps can charge
    }
    else    // Brushless
    {
        P1OVDCON = 0x0015;    // Turn on low side fets so bootstraps can charge
    }
    
    // Pause for 50ms to let the bootstraps charge up
    BlockingDelayms(50);
    
    return;
}

inline void EnableMotorInterrupts(void)
{
    /* Clear the interrupt as a starting condition. */
    IFS3bits.PWM1IF = 0;

    /* Enable the interrupt. */
    IEC3bits.PWM1IE = 1;
}

inline void DisableMotorInterrupts(void)
{
    /* Disable the interrupt. */
    IEC3bits.PWM1IE = 0;

    /* Clear the interrupt just in case */
    IFS3bits.PWM1IF = 0;
}

static volatile INT16 mtrPWMIntCount = 0;
static volatile INT16 voltMonCount = 0;

void __attribute__((__interrupt__, auto_psv)) _MPWM1Interrupt( void )
{
    /* Clear the PWM interrupt. */
    IFS3bits.PWM1IF = 0;

    // This interrupt is called 1/10 of the frequency of the PWM. That is too
    // fast, but it's simplest divisor to work with. To slow down to the desired
    // rate, we use this counter. Desired is 1/20 of PWM, so every other interrupt
    // is valid.
    mtrPWMIntCount = (mtrPWMIntCount + 1) % 2;

    if(mtrPWMIntCount!= 0)
        return;

    //LED = LED_ON;   // Used for timing analysis with o-scope

    // Once per second force a reference calculation. This is in case
    // the motor command is long lived, and the battery voltage shifts, the
    // desired output is still generated.
    voltMonCount = (voltMonCount + 1) % MTR_TICK_RATE;
    if(voltMonCount == 0)
        hMotorData->Flags |= MTR_FLAGMASK_REFCHANGED;
    
    // No valid heartbeat, override the desired speed
    if((hMotorData->Flags & MTR_FLAGMASK_HEARTBEAT) != 0)
    {
        if((++hMotorData->InterruptCount) > HEARTBEAT_TIMEOUT_TICKS)
        {
            hMotorData->Flags  &= ~MTR_FLAGMASK_HEARTBEAT;  // Clear the heartbeat flag
            hMotorData->ReferenceInput = 0;
			hMotorData->Flags |= MTR_FLAGMASK_REFCHANGED;
            LostSubscribers();  // Turn off the publishing
        }
    }

    // This is an undervolt condition, override the desired speed
    if(hMotorData->MinVoltage > hMotorData->VRail)
    {
        hMotorData->Flags  |= MTR_FLAGMASK_UNDERVOLTAGE;
        hMotorData->ReferenceInput = 0;
		hMotorData->Flags |= MTR_FLAGMASK_REFCHANGED;
    }
    // Undervolt occurred, but the rail is back above minimum now.
    // Clear undervolt flag
    else if((hMotorData->Flags & MTR_FLAGMASK_UNDERVOLTAGE) != 0)
    {
        hMotorData->Flags &= ~MTR_FLAGMASK_UNDERVOLTAGE;
    }

    

    // Call the controller
    controller();
}

inline void FeedHeartbeat(void)
{
    hMotorData->InterruptCount = 0;
    hMotorData->Flags |= MTR_FLAGMASK_HEARTBEAT;
}

inline void ReferenceChanged(void)
{
    hMotorData->Flags |= MTR_FLAGMASK_REFCHANGED;
}

/*********************************************************************
 * Function:        void SaveMotorConfig(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Save the motor configuration
 *
 * Note:
 ********************************************************************/
void SaveMotorConfig(MotorData* mCfg)
{
    BYTE *p;
    UINT16 d, chk;
    BYTE appVers = APP_VERSION;

    p = (BYTE*)mCfg;
    d = MTR_EROM_BASE;

    // Calculate the checksum
    chk = CRC16Checksum(p, sizeof(MotorData));
    
    // Write the app version
    EROM_WriteBytes(d++, 1, &appVers);

    // Copy out the Motor Config
    EROM_WriteBytes(d, sizeof(MotorData), p);

    // Write the checksum
    EROM_WriteInt16((d + sizeof(MotorData)), chk);
}

void GetMotorDataFromEROM(MotorData** motor)
{    
    BYTE c;
    BYTE *p;
    UINT16 d, type;
    MotorData tmpData;  // Shadow copy to use when checking for valid EROM

    // First try to read in a valid motordata struct. If it doesn't exist,
    // or the checksum is invalid(power failure while programming), we build
    // and save the default template.
    p = (BYTE*)&tmpData;
    d = MTR_EROM_BASE;

    // Attempt to read in the config data from eeprom
    EROM_ReadBytes(d++, 1, &c);

    // Check if the application version matches
    if(c  == APP_VERSION)
    {
        EROM_ReadBytes(d, sizeof(MotorData), p);

        // The two bytes after the structure are the checksum
        INT16 savedChk = EROM_ReadInt16(d + sizeof(MotorData));

        if(CRC16Checksum(p, sizeof(MotorData)) != savedChk)
            goto CONFIG_DEFAULT_MOTOR;

        //DAC_SetOutput(((float)BROLMotorData.MaxCurrent) / pow(2,12));   // Set the DAC output voltage

        // It's a valid struct if we get here. Switch on the motor type
        type = (tmpData.Flags & MTR_FLAGMASK_MOTORCODE);
        switch(type)
        {
            case MTR_CODE_BRCL:
                break;

            default:
                memcpy((void *)&BROLMotorData, (void *)&tmpData, sizeof(MotorData));
                BROLInit();     // This directly operates on the global brushed open loop variable
                controller = &BrushedDCOpenLoop;// Set the controller callback
                *motor = &BROLMotorData;    // Set the handle to the correct instance
                break;
        }

        return;
    }

CONFIG_DEFAULT_MOTOR:
    // Clear the structure first, just in case
    memset(&BROLMotorData, 0x0, sizeof(MotorData));
    
    // It's a brushed open loop motor
    BROLMotorData.Flags |= (MTR_FLAGMASK_MOTORCODE & MTR_CODE_BROL);
    
    memcpypgm2ram(BROLMotorData.Manufacturer,
            (const void*) MTR_DEFAULT_MANUFACTURER,
            16);

    BROLMotorData.HardMaxVoltage = MTR_DEFAULT_HMAXV;
    BROLMotorData.MinVoltage = MTR_DEFAULT_MINV;
    BROLMotorData.MaxCurrent = MTR_DEFAULT_MAXCURRENT;
    BROLMotorData.MaxSlew = MTR_DEFAULT_MAXSLEW;

    // The default force curves are linear
    BROLMotorData.FCoeff[1] = 1.0f;
    BROLMotorData.RCoeff[1] = 1.0f;

    BROLInit();

    // Now save this as the default
    SaveMotorConfig(&BROLMotorData);

    //DAC_SetOutput(((float)BROLMotorData.MaxCurrent) / pow(2,12));   // Set the DAC output voltage
    controller = &BrushedDCOpenLoop;// Set the controller callback
    *motor = &BROLMotorData;    // Set the handle to the correct instance
}

// All that's left in brushed open-loop is to build the voltage tables
void BROLInit(void)
{
    INT16 i;
    float hMax;

    // HardMax is a Q6_10 in the structure, but we use Q6_26 in the
    // tables. This is for precision when dividing later.
    hMax = (float)(((Q6_26)BROLMotorData.HardMaxVoltage) << 16 );

    MTR_FTable[0] = 0;
    // Build the forward table
    for(i = 1; i <= 100; i++)
    {
        MTR_FTable[i] = 
               (Q6_26)(hMax*(BROLMotorData.FCoeff[5]*pow(i,5) +
                BROLMotorData.FCoeff[4]*pow(i,4) +
                BROLMotorData.FCoeff[3]*pow(i,3) +
                BROLMotorData.FCoeff[2]*pow(i,2) +
                BROLMotorData.FCoeff[1]*i +
                BROLMotorData.FCoeff[0]) / 100.0);
    }

    MTR_RTable[0] = 0;
    // Build the reverse table
    for(i = 1; i <= 100; i++)
    {
        MTR_RTable[i] = 
                (Q6_26)(hMax*(BROLMotorData.RCoeff[5]*pow(i,5) +
                BROLMotorData.RCoeff[4]*pow(i,4) +
                BROLMotorData.RCoeff[3]*pow(i,3) +
                BROLMotorData.RCoeff[2]*pow(i,2) +
                BROLMotorData.RCoeff[1]*i +
                BROLMotorData.RCoeff[0]) / 100.0);
    }
}

