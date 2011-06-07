#ifndef TASKTCPIP_H
#define TASKTCPIP_H

// FreeRTOS includes
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "croutine.h"

#include "TCPIP Stack/TCPIP.h"

#include "mcp25XX640A.h"
#include "messages.h"
#include "adc.h"

// size of the stack for this task
#define STACK_SIZE_TCPIP            (configMINIMAL_STACK_SIZE * 3)
#define UDP_QUEUE_SIZE              10

#define UDP_DEFAULT_PORT          50000

#define UDP_CONN_TIMEOUT            10  // No data for 10s will close a connection 

typedef struct
{
    UDP_PORT   Port;    // Only communicate through 1 port
}UDPConfigData;

typedef struct
{
    NODE_INFO Controller;       // Pulled from a packet with a matching local controller id
    UDP_SOCKET Socket;
}UDPData;


// handle for the task
extern xTaskHandle hTCPIPTask;
extern UDPConfigData gUDPConfig;
extern UDPData gUDPData;

void xTCPIPTaskInit(void);
// the main task handler for TCPIP functions
void taskTCPIP(void* pvParameter);
void SaveAppConfig(APP_CONFIG* appCfg);
void DelayMs(WORD time);    // This is a FreeRTOS delay call (sleeps the task)
void UDPSend(BYTE* data, portBASE_TYPE length, portBASE_TYPE sender, portBASE_TYPE shouldFree);
void UDPSendFromISR(BYTE* data, portBASE_TYPE length,  portBASE_TYPE sender, portBASE_TYPE shouldFree);
void UDPCreateConnection(NODE_INFO remote, INT16 port);
void UDPCloseConnection(INT16 connectionNumber);

#endif // TASKTCPIP_H
