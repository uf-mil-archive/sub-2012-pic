#ifndef TASKTCPIP_H
#define TASKTCPIP_H

// FreeRTOS includes
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "croutine.h"

#include "TCPIP Stack/TCPIP.h"

void xTCPIPTaskInit(void);
// the main task handler for TCPIP functions
void taskTCPIP(void* pvParameter);

// size of the stack for this task
#define STACK_SIZE_TCPIP		(configMINIMAL_STACK_SIZE * 3)

// handle for the task
extern xTaskHandle hTCPIPTask;

void SaveAppConfig(APP_CONFIG* appCfg);
void  DelayMs(WORD time);

typedef struct
{
    NODE_INFO  TXDestNode;
    UDP_SOCKET TXSocket;
    UDP_PORT   TXRemotePort;
    UDP_SOCKET RXSocket;
    UDP_PORT   RXPort;
}UDPConfigData;

extern UDPConfigData gUDPConfig;

#endif // TASKTCPIP_H
