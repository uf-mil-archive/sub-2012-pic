#include "motor.h"
#include "p33FJ128MC804.h"
#include <stdio.h>

// Minimum PWM duty cycle due to deadtime is 6%, max 94%

MotorData BROLMotorData =
{
    .ReferenceInput = 0,
    .MaxSlew = 250,
};

void (*controller)(void) = NULL;
MotorData *hMotorData = NULL;
BYTE MotorInited = FALSE;

INT16 MTR_FTable[101];
INT16 MTR_RTable[101];

void PWMInit(void);
void motorSetupTimer(void);
void BrushedDCOpenLoop(void);
inline void EnableMotorInterrupts(void);
inline void DisableMotorInterrupts(void);
void BROLInit(MotorData** motor);

inline BYTE ReadMotorTypeEE()
{
   BYTE result;
   EROM_ReadBytes(MTR_EROM_BASE, 1, &result);
   return result;
}

void MotorInit(void)
{
    PWMInit();  // Initialize the PWM module

    // Pull in settings from EROM
    switch(ReadMotorTypeEE())
    {
        case MTR_TYPE_BROL:
            BROLInit(&hMotorData);
            // Set the controller callback
            controller = &BrushedDCOpenLoop;
            break;

        default:
            return; // No motor settings, don't turn anything on
    }

    DisableMotorInterrupts();

    // Setup the controller timer
    motorSetupTimer();

/*
    // Charge the boot straps. This leaves the low side fets turned on.
    ChargeBootStraps();
    
    // Now start firing controller events
    EnableMotorInterrupts();
*/

    return;
}

void PWMInit(void)
{
    P1OVDCON = 0x0000;

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
    P1OVDCON = 0x0000;      // Override controls the output pins
                            // clear all the outputs to low
    P1DC1 = 0;              // Initialize the duty cycle registers
    P1DC2 = 0;              // to off
    P1DC3 = 0;
    P1SECMP = P1TPER;
    PWM1CON2 = 0x0F00;      // 1:16 postscalar on the special event trigger
                            // Synchronized updates, override on clock boundaries

    P1TCON = 0x8000;        // Start PWM module (all pins are still off due to override)

    return;
}

void BrushedDCOpenLoop(void)
{
    if(hMotorData->Flags.ReferenceChanged)
    {
        // If the reference has changed, do the table lookup
        // to find the new duty cycle
        INT16 index = hMotorData->ReferenceInput / 10;

        // Check for cases we don't interpolate
        if(index > -1 && index < 1)
        {
            hMotorData->ReferenceDuty = 0; 
            goto DONE;
        }

        if(index <= -100)
        {
            hMotorData->ReferenceDuty = MTR_RTable[100];
            goto DONE;
        }
        
        if(index >= 100)
        {
            hMotorData->ReferenceDuty = MTR_FTable[100];
            goto DONE;
        }
        
        // The point isn't on a table boundary, interpolation is necessary
        if(index < 0)
        {
            index = -1*index;     
            INT16 x0 = index * 10;
            INT16 x1 = (index + 1) * 10;
            INT16 xdel0 = -1*hMotorData->ReferenceInput - x0;
            hMotorData->ReferenceDuty =
                MTR_RTable[index] + 
                (xdel0*(MTR_RTable[index+1] - MTR_RTable[index]) / (x1 - x0));
        }
        else
        {
            INT16 x0 = index * 10;
            INT16 x1 = (index + 1) * 10;
            INT16 xdel0 = hMotorData->ReferenceInput - x0;
            hMotorData->ReferenceDuty =
                MTR_FTable[index] +
                (xdel0*(MTR_FTable[index+1] - MTR_FTable[index]) / (x1 - x0));
        }
        
DONE:   // Clear the reference changed flag
        hMotorData->Flags.ReferenceChanged = 0;
    }


    if(hMotorData->ReferenceDuty != hMotorData->PresentDuty)
    {
        // Motor speed is changing. Use the slew to find the new
        // duty cycle
        INT16 duty = hMotorData->PresentDuty;
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
            P1OVDCON = MTR_BR_BACKWARD;
        }
        else
        {
            duty =  hMotorData->PresentDuty;
            P1OVDCON = MTR_BR_FORWARD;
        }

        // Set the duty cycles correctly (absolute value of output)
        P1DC1 = duty;
        P1DC2 = duty;
    }
}

void ChargeBootStraps(void)
{
    const UINT16 delayTicks = (((GetInstructionClock() / 8)/1000) * 10) ;

    if(hMotorData->Flags.MotorType == MTR_TYPE_BROL
            || hMotorData->Flags.MotorType == MTR_TYPE_BRCL)
    {
         P1OVDCON = 0x0005;    // Turn on low side fets so bootstraps can charge
    }
    else
    {
        P1OVDCON = 0x0015;    // Turn on low side fets so bootstraps can charge
    }
    
    // Pause for 50ms to let the bootstraps charge up
    INT16 i = 0; TMR4 = 0;
    for(i = 0; i < 5; i++)
    {
        // Delays 10ms
        while(TMR4 < delayTicks);
    }
    
    return;
}

inline void EnableMotorInterrupts(void)
{
    /* Clear the interrupt as a starting condition. */
    IFS1bits.T4IF = 0;

    /* Enable the interrupt. */
    IEC1bits.T4IE = 1;
}

inline void DisableMotorInterrupts(void)
{
    /* Disable the interrupt. */
    IEC1bits.T4IE = 0;

    /* Clear the interrupt just in case */
    IFS1bits.T4IF = 0;
}

void motorSetupTimer(void)
{
    // Prescale is 8
    const UINT16 delayTime = (GetInstructionClock() / 8) / MTR_TICK_RATE;

    /* Prescale of 8. */
    T4CON = 0;
    TMR4 = 0;

    PR4 = delayTime;

    /* Setup timer 1 interrupt priority. */
    IPC6bits.T4IP = MTR_INT_PRIORITY;

    /* Setup the prescale value. */
    T4CONbits.TCKPS0 = 1;
    T4CONbits.TCKPS1 = 0;

    T4CONbits.TON = 1;  // Turn on the timer
}

void __attribute__((__interrupt__, auto_psv)) _T4Interrupt( void )
{
    /* Clear the timer interrupt. */
    IFS1bits.T4IF = 0;

    // No valid heartbeat, override the desired speed
    if((++(hMotorData->InterruptCount) > HEARTBEAT_TIMEOUT_TICKS) ||
       !(hMotorData->Flags.Heartbeat))
    {
        hMotorData->Flags.Heartbeat = 0;
        hMotorData->ReferenceInput = 0;
    }
    else if(hMotorData.MinVoltage > hMotorData.VRail)
    {
        hMotorData->Flags.UnderVoltage = 1;
        hMotorData->ReferenceInput = 0;
    }

    // Call the controller
    controller();
}

inline void FeedHeartbeat(void)
{
    if(hMotorData)
    {
        hMotorData->InterruptCount = 0;
        hMotorData->Flags.Heartbeat = 1;
    }
}

void BROLInit(MotorData** motor)
{
    
    BYTE result;
    INT16 address = 1;
    
    BROLMotorData.Flags.MotorType = MTR_TYPE_BROL;
            
    // The first byte after the motor type is this motor's address
    EROM_ReadBytes(address++, 1, &BROLMotorData.Address);
    // Next is the desired endianess
    EROM_ReadBytes(address++, 1, &result);
    BROLMotorData.Flags.Endianess = (result != 0) ? 1: 0;
    // Then the 2 byte max slew, stored little endian
    BROLMotorData.MaxSlew =  EROM_ReadInt16(address);
    address += sizeof(INT16);
    // Then the 2 byte max voltage
    BROLMotorData.MaxVoltage = EROM_ReadInt16(address);
    address += sizeof(INT16);
    // Then the 2 byte max current
    BROLMotorData.MaxCurrent = EROM_ReadInt16(address);
    address += sizeof(INT16);

    // Followed by 6 floats for the forward coefficients
    INT16 i;
    for(i = 0; i < 5; i++)
    {
        BROLMotorData.FCoeff[i] = EROM_ReadFloat(address);
        address += sizeof(float);
    }

    // And 6 floats for the reverse coefficients
    for(i = 0; i < 5; i++)
    {
        BROLMotorData.RCoeff[i] = EROM_ReadFloat(address);
        address += sizeof(float);
    }   

    float rangeScale = ((MTR_MAX_PERCENT - MTR_MIN_PERCENT) / 100.0) * MTR_MAX_DUTY;
    float offsetScale = (MTR_MIN_PERCENT / 100.0) * MTR_MAX_DUTY;

    MTR_FTable[0] = 0;
    // Build the forward table
    for(i = 1; i <= 100; i++)
    {
        MTR_FTable[i] = (INT16)(rangeScale*
                (BROLMotorData.FCoeff[5]*pow(i,5) +
                BROLMotorData.FCoeff[4]*pow(i,4) +
                BROLMotorData.FCoeff[3]*pow(i,3) +
                BROLMotorData.FCoeff[2]*pow(i,2) +
                BROLMotorData.FCoeff[1]*i +
                BROLMotorData.FCoeff[0])
                + offsetScale); 
    }

    MTR_RTable[0] = 0;
    // Build the reverse table
    for(i = 1; i <= 100; i++)
    {
        MTR_RTable[i] = (INT16)(rangeScale*
                (BROLMotorData.RCoeff[5]*pow(i,5) +
                BROLMotorData.RCoeff[4]*pow(i,4) +
                BROLMotorData.RCoeff[3]*pow(i,3) +
                BROLMotorData.RCoeff[2]*pow(i,2) +
                BROLMotorData.RCoeff[1]*i +
                BROLMotorData.RCoeff[0])
                + offsetScale);
    }

    *motor = &BROLMotorData;

    MotorInited = TRUE;
}

INT16 MotorGetAmpsString(MotorData* data, BYTE* buf)
{
    INT16 res;

    if(!data)
    {
        res = sprintf((CHAR8*)buf, "0.0");
    }
    else
    {
        float amps = data->Current*MTR_AMPS_SCALE;

        //res = sprintf((CHAR8*)buf, "%2.4f", amps);
    }
    
    return res;
}

INT16 MotorGetRailVoltsString(MotorData* data, BYTE* buf)
{
    INT16 res;

    if(!data)
    {
        res = sprintf((CHAR8*)buf, "0.0");
    }
    else
    {
        float volts = data->VRail*MTR_RAILVOLTS_SCALE;

        //res = sprintf((CHAR8*)buf, "%2.4f", volts);
    }

    return res;
}
