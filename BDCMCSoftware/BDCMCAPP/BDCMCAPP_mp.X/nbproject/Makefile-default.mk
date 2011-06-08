#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile

# Environment
MKDIR=mkdir -p
RM=rm -f 
CP=cp 
# Macros
CND_CONF=default

ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf
else
IMAGE_TYPE=production
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf
endif
# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}
# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ${OBJECTDIR}/_ext/1757024747/port.o ${OBJECTDIR}/_ext/812168374/MotorWebPage.o ${OBJECTDIR}/_ext/1954962658/DHCP.o ${OBJECTDIR}/_ext/812168374/main.o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ${OBJECTDIR}/_ext/1954962658/MPFS2.o ${OBJECTDIR}/_ext/812168374/mcp4821.o ${OBJECTDIR}/_ext/812168374/simplequeue.o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ${OBJECTDIR}/_ext/1954962658/ARP.o ${OBJECTDIR}/_ext/812168374/Tick.o ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o ${OBJECTDIR}/_ext/1954962658/NBNS.o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ${OBJECTDIR}/_ext/190470153/list.o ${OBJECTDIR}/_ext/1954962658/UDP.o ${OBJECTDIR}/_ext/812168374/taskUART.o ${OBJECTDIR}/_ext/812168374/messages.o ${OBJECTDIR}/_ext/1954962658/ENC28J60.o ${OBJECTDIR}/_ext/190470153/tasks.o ${OBJECTDIR}/_ext/1954962658/DNS.o ${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o ${OBJECTDIR}/_ext/1954962658/StackTsk.o ${OBJECTDIR}/_ext/812168374/adc.o ${OBJECTDIR}/_ext/190470153/queue.o ${OBJECTDIR}/_ext/812168374/taskParser.o ${OBJECTDIR}/_ext/636803636/heap_3.o ${OBJECTDIR}/_ext/1954962658/Announce.o ${OBJECTDIR}/_ext/812168374/motor.o ${OBJECTDIR}/_ext/1954962658/TCP.o ${OBJECTDIR}/_ext/1954962658/HTTP2.o ${OBJECTDIR}/_ext/1954962658/ICMP.o ${OBJECTDIR}/_ext/1954962658/Helpers.o ${OBJECTDIR}/_ext/1954962658/IP.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

# Path to java used to run MPLAB X when this makefile was created
MP_JAVA_PATH=/usr/lib/jvm/ia32-java-6-sun-1.6.0.24/jre/bin/
OS_ORIGINAL="Linux"
OS_CURRENT="$(shell uname -s)"
############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
MP_CC=/opt/microchip/mplabc30/v3.24/bin/pic30-gcc
# MP_BC is not defined
MP_AS=/opt/microchip/mplabc30/v3.24/bin/pic30-as
MP_LD=/opt/microchip/mplabc30/v3.24/bin/pic30-ld
MP_AR=/opt/microchip/mplabc30/v3.24/bin/pic30-ar
# MP_BC is not defined
MP_CC_DIR=/opt/microchip/mplabc30/v3.24/bin
# MP_BC_DIR is not defined
MP_AS_DIR=/opt/microchip/mplabc30/v3.24/bin
MP_LD_DIR=/opt/microchip/mplabc30/v3.24/bin
MP_AR_DIR=/opt/microchip/mplabc30/v3.24/bin
# MP_BC_DIR is not defined
.build-conf: ${BUILD_SUBPROJECTS}
ifneq ($(OS_CURRENT),$(OS_ORIGINAL))
	@echo "***** WARNING: This make file contains OS dependent code. The OS this makefile is being run is different from the OS it was created in."
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf

MP_PROCESSOR_OPTION=33FJ128MC804
MP_LINKER_FILE_OPTION=,-Tp33FJ128MC804.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
.PHONY: ${OBJECTDIR}/_ext/812168374/MotorWebPage.o
${OBJECTDIR}/_ext/812168374/MotorWebPage.o: ../source/MotorWebPage.s  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION) -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/812168374/MotorWebPage.o ../source/MotorWebPage.s  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1,-g,-I".."
.PHONY: ${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o
${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1757024747 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION) -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1,-g,-I".."
else
.PHONY: ${OBJECTDIR}/_ext/812168374/MotorWebPage.o
${OBJECTDIR}/_ext/812168374/MotorWebPage.o: ../source/MotorWebPage.s  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION) -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/812168374/MotorWebPage.o ../source/MotorWebPage.s  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-I".."
.PHONY: ${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o
${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1757024747 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION) -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/1757024747/portasm_dsPIC.o ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-I".."
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
endif
${OBJECTDIR}/_ext/1757024747/port.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1757024747 
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1757024747/port.o.d -o ${OBJECTDIR}/_ext/1757024747/port.o ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1757024747/port.o.d > ${OBJECTDIR}/_ext/1757024747/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${CP} ${OBJECTDIR}/_ext/1757024747/port.o.tmp ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1757024747/port.o.d > ${OBJECTDIR}/_ext/1757024747/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${CP} ${OBJECTDIR}/_ext/1757024747/port.o.tmp ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/DHCP.o: ../../../Microchip/TCPIP\ Stack/DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/DHCP.o.d -o ${OBJECTDIR}/_ext/1954962658/DHCP.o ../../../Microchip/TCPIP\ Stack/DHCP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/DHCP.o.d > ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/DHCP.o.d > ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp
endif
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskPublisher.o: ../source/taskPublisher.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/MPFS2.o: ../../../Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d -o ${OBJECTDIR}/_ext/1954962658/MPFS2.o ../../../Microchip/TCPIP\ Stack/MPFS2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d > ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d > ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp
endif
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp4821.o.d -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
endif
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/simplequeue.o.d -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
endif
${OBJECTDIR}/_ext/812168374/blockingDelay.o: ../source/blockingDelay.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d -o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ../source/blockingDelay.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o: ../../../Microchip/TCPIP\ Stack/UDPPerformanceTest.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d -o ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o ../../../Microchip/TCPIP\ Stack/UDPPerformanceTest.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp
endif
${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o: ../source/CustomHTTPApp.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d -o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ../source/CustomHTTPApp.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/ARP.o: ../../../Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/ARP.o.d -o ${OBJECTDIR}/_ext/1954962658/ARP.o ../../../Microchip/TCPIP\ Stack/ARP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/ARP.o.d > ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/ARP.o.d > ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp
endif
${OBJECTDIR}/_ext/812168374/Tick.o: ../source/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/Tick.o.d -o ${OBJECTDIR}/_ext/812168374/Tick.o ../source/Tick.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o: ../../../Microchip/TCPIP\ Stack/TCPPerformanceTest.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d -o ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o ../../../Microchip/TCPIP\ Stack/TCPPerformanceTest.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/NBNS.o: ../../../Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/NBNS.o.d -o ${OBJECTDIR}/_ext/1954962658/NBNS.o ../../../Microchip/TCPIP\ Stack/NBNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/NBNS.o.d > ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/NBNS.o.d > ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskTCPIP.o: ../source/taskTCPIP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d -o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ../source/taskTCPIP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
endif
${OBJECTDIR}/_ext/190470153/list.o: ../../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/190470153 
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/190470153/list.o.d -o ${OBJECTDIR}/_ext/190470153/list.o ../../../FreeRTOS/Source/list.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/190470153/list.o.d > ${OBJECTDIR}/_ext/190470153/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/list.o.tmp ${OBJECTDIR}/_ext/190470153/list.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/190470153/list.o.d > ${OBJECTDIR}/_ext/190470153/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/list.o.tmp ${OBJECTDIR}/_ext/190470153/list.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/UDP.o: ../../../Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/UDP.o.d -o ${OBJECTDIR}/_ext/1954962658/UDP.o ../../../Microchip/TCPIP\ Stack/UDP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/UDP.o.d > ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/UDP.o.d > ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskUART.o.d -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
endif
${OBJECTDIR}/_ext/812168374/messages.o: ../source/messages.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/messages.o.d -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/ENC28J60.o: ../../../Microchip/TCPIP\ Stack/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d -o ${OBJECTDIR}/_ext/1954962658/ENC28J60.o ../../../Microchip/TCPIP\ Stack/ENC28J60.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d > ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d > ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp
endif
${OBJECTDIR}/_ext/190470153/tasks.o: ../../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/190470153 
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/190470153/tasks.o.d -o ${OBJECTDIR}/_ext/190470153/tasks.o ../../../FreeRTOS/Source/tasks.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/190470153/tasks.o.d > ${OBJECTDIR}/_ext/190470153/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/190470153/tasks.o.d > ${OBJECTDIR}/_ext/190470153/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/DNS.o: ../../../Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/DNS.o.d -o ${OBJECTDIR}/_ext/1954962658/DNS.o ../../../Microchip/TCPIP\ Stack/DNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/DNS.o.d > ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/DNS.o.d > ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/StackTsk.o: ../../../Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d -o ${OBJECTDIR}/_ext/1954962658/StackTsk.o ../../../Microchip/TCPIP\ Stack/StackTsk.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d > ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d > ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp
endif
${OBJECTDIR}/_ext/812168374/adc.o: ../source/adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/adc.o.d -o ${OBJECTDIR}/_ext/812168374/adc.o ../source/adc.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/adc.o.d > ${OBJECTDIR}/_ext/812168374/adc.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/adc.o.tmp ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/adc.o.d > ${OBJECTDIR}/_ext/812168374/adc.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/adc.o.tmp ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.tmp
endif
${OBJECTDIR}/_ext/190470153/queue.o: ../../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/190470153 
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/190470153/queue.o.d -o ${OBJECTDIR}/_ext/190470153/queue.o ../../../FreeRTOS/Source/queue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/190470153/queue.o.d > ${OBJECTDIR}/_ext/190470153/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/queue.o.tmp ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/190470153/queue.o.d > ${OBJECTDIR}/_ext/190470153/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/queue.o.tmp ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskParser.o.d -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
endif
${OBJECTDIR}/_ext/636803636/heap_3.o: ../../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/636803636 
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/636803636/heap_3.o.d -o ${OBJECTDIR}/_ext/636803636/heap_3.o ../../../FreeRTOS/Source/portable/MemMang/heap_3.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/636803636/heap_3.o.d > ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/636803636/heap_3.o.d > ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/Announce.o: ../../../Microchip/TCPIP\ Stack/Announce.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/Announce.o.d -o ${OBJECTDIR}/_ext/1954962658/Announce.o ../../../Microchip/TCPIP\ Stack/Announce.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/Announce.o.d > ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/Announce.o.d > ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp
endif
${OBJECTDIR}/_ext/812168374/motor.o: ../source/motor.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/motor.o.d -o ${OBJECTDIR}/_ext/812168374/motor.o ../source/motor.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/motor.o.d > ${OBJECTDIR}/_ext/812168374/motor.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/motor.o.tmp ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/motor.o.d > ${OBJECTDIR}/_ext/812168374/motor.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/motor.o.tmp ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/TCP.o: ../../../Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/TCP.o.d -o ${OBJECTDIR}/_ext/1954962658/TCP.o ../../../Microchip/TCPIP\ Stack/TCP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/TCP.o.d > ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/TCP.o.d > ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/HTTP2.o: ../../../Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d -o ${OBJECTDIR}/_ext/1954962658/HTTP2.o ../../../Microchip/TCPIP\ Stack/HTTP2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d > ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d > ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/ICMP.o: ../../../Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/ICMP.o.d -o ${OBJECTDIR}/_ext/1954962658/ICMP.o ../../../Microchip/TCPIP\ Stack/ICMP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/ICMP.o.d > ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/ICMP.o.d > ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/Helpers.o: ../../../Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/Helpers.o.d -o ${OBJECTDIR}/_ext/1954962658/Helpers.o ../../../Microchip/TCPIP\ Stack/Helpers.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/Helpers.o.d > ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/Helpers.o.d > ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/IP.o: ../../../Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/IP.o.d -o ${OBJECTDIR}/_ext/1954962658/IP.o ../../../Microchip/TCPIP\ Stack/IP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/IP.o.d > ${OBJECTDIR}/_ext/1954962658/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/IP.o.d > ${OBJECTDIR}/_ext/1954962658/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp
endif
else
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
endif
${OBJECTDIR}/_ext/1757024747/port.o: ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1757024747 
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1757024747/port.o.d -o ${OBJECTDIR}/_ext/1757024747/port.o ../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1757024747/port.o.d > ${OBJECTDIR}/_ext/1757024747/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${CP} ${OBJECTDIR}/_ext/1757024747/port.o.tmp ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1757024747/port.o.d > ${OBJECTDIR}/_ext/1757024747/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${CP} ${OBJECTDIR}/_ext/1757024747/port.o.tmp ${OBJECTDIR}/_ext/1757024747/port.o.d 
	${RM} ${OBJECTDIR}/_ext/1757024747/port.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/DHCP.o: ../../../Microchip/TCPIP\ Stack/DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/DHCP.o.d -o ${OBJECTDIR}/_ext/1954962658/DHCP.o ../../../Microchip/TCPIP\ Stack/DHCP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/DHCP.o.d > ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/DHCP.o.d > ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp ${OBJECTDIR}/_ext/1954962658/DHCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DHCP.o.tmp
endif
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskPublisher.o: ../source/taskPublisher.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/MPFS2.o: ../../../Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d -o ${OBJECTDIR}/_ext/1954962658/MPFS2.o ../../../Microchip/TCPIP\ Stack/MPFS2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d > ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d > ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp ${OBJECTDIR}/_ext/1954962658/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/MPFS2.o.tmp
endif
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp4821.o.d -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
endif
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/simplequeue.o.d -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
endif
${OBJECTDIR}/_ext/812168374/blockingDelay.o: ../source/blockingDelay.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d -o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ../source/blockingDelay.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o: ../../../Microchip/TCPIP\ Stack/UDPPerformanceTest.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d -o ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o ../../../Microchip/TCPIP\ Stack/UDPPerformanceTest.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDPPerformanceTest.o.tmp
endif
${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o: ../source/CustomHTTPApp.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d -o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ../source/CustomHTTPApp.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/ARP.o: ../../../Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/ARP.o.d -o ${OBJECTDIR}/_ext/1954962658/ARP.o ../../../Microchip/TCPIP\ Stack/ARP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/ARP.o.d > ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/ARP.o.d > ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp ${OBJECTDIR}/_ext/1954962658/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ARP.o.tmp
endif
${OBJECTDIR}/_ext/812168374/Tick.o: ../source/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/Tick.o.d -o ${OBJECTDIR}/_ext/812168374/Tick.o ../source/Tick.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o: ../../../Microchip/TCPIP\ Stack/TCPPerformanceTest.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d -o ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o ../../../Microchip/TCPIP\ Stack/TCPPerformanceTest.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d > ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCPPerformanceTest.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/NBNS.o: ../../../Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/NBNS.o.d -o ${OBJECTDIR}/_ext/1954962658/NBNS.o ../../../Microchip/TCPIP\ Stack/NBNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/NBNS.o.d > ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/NBNS.o.d > ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp ${OBJECTDIR}/_ext/1954962658/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/NBNS.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskTCPIP.o: ../source/taskTCPIP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d -o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ../source/taskTCPIP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
endif
${OBJECTDIR}/_ext/190470153/list.o: ../../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/190470153 
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/190470153/list.o.d -o ${OBJECTDIR}/_ext/190470153/list.o ../../../FreeRTOS/Source/list.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/190470153/list.o.d > ${OBJECTDIR}/_ext/190470153/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/list.o.tmp ${OBJECTDIR}/_ext/190470153/list.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/190470153/list.o.d > ${OBJECTDIR}/_ext/190470153/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/list.o.tmp ${OBJECTDIR}/_ext/190470153/list.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/list.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/UDP.o: ../../../Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/UDP.o.d -o ${OBJECTDIR}/_ext/1954962658/UDP.o ../../../Microchip/TCPIP\ Stack/UDP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/UDP.o.d > ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/UDP.o.d > ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp ${OBJECTDIR}/_ext/1954962658/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/UDP.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskUART.o.d -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
endif
${OBJECTDIR}/_ext/812168374/messages.o: ../source/messages.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/messages.o.d -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/ENC28J60.o: ../../../Microchip/TCPIP\ Stack/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d -o ${OBJECTDIR}/_ext/1954962658/ENC28J60.o ../../../Microchip/TCPIP\ Stack/ENC28J60.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d > ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d > ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ENC28J60.o.tmp
endif
${OBJECTDIR}/_ext/190470153/tasks.o: ../../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/190470153 
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/190470153/tasks.o.d -o ${OBJECTDIR}/_ext/190470153/tasks.o ../../../FreeRTOS/Source/tasks.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/190470153/tasks.o.d > ${OBJECTDIR}/_ext/190470153/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/190470153/tasks.o.d > ${OBJECTDIR}/_ext/190470153/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp ${OBJECTDIR}/_ext/190470153/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/tasks.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/DNS.o: ../../../Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/DNS.o.d -o ${OBJECTDIR}/_ext/1954962658/DNS.o ../../../Microchip/TCPIP\ Stack/DNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/DNS.o.d > ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/DNS.o.d > ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp ${OBJECTDIR}/_ext/1954962658/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/DNS.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/StackTsk.o: ../../../Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d -o ${OBJECTDIR}/_ext/1954962658/StackTsk.o ../../../Microchip/TCPIP\ Stack/StackTsk.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d > ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d > ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp ${OBJECTDIR}/_ext/1954962658/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/StackTsk.o.tmp
endif
${OBJECTDIR}/_ext/812168374/adc.o: ../source/adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/adc.o.d -o ${OBJECTDIR}/_ext/812168374/adc.o ../source/adc.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/adc.o.d > ${OBJECTDIR}/_ext/812168374/adc.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/adc.o.tmp ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/adc.o.d > ${OBJECTDIR}/_ext/812168374/adc.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/adc.o.tmp ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.tmp
endif
${OBJECTDIR}/_ext/190470153/queue.o: ../../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/190470153 
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/190470153/queue.o.d -o ${OBJECTDIR}/_ext/190470153/queue.o ../../../FreeRTOS/Source/queue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/190470153/queue.o.d > ${OBJECTDIR}/_ext/190470153/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/queue.o.tmp ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/190470153/queue.o.d > ${OBJECTDIR}/_ext/190470153/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/190470153/queue.o.tmp ${OBJECTDIR}/_ext/190470153/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/190470153/queue.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskParser.o.d -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
endif
${OBJECTDIR}/_ext/636803636/heap_3.o: ../../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/636803636 
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/636803636/heap_3.o.d -o ${OBJECTDIR}/_ext/636803636/heap_3.o ../../../FreeRTOS/Source/portable/MemMang/heap_3.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/636803636/heap_3.o.d > ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/636803636/heap_3.o.d > ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp ${OBJECTDIR}/_ext/636803636/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/636803636/heap_3.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/Announce.o: ../../../Microchip/TCPIP\ Stack/Announce.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/Announce.o.d -o ${OBJECTDIR}/_ext/1954962658/Announce.o ../../../Microchip/TCPIP\ Stack/Announce.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/Announce.o.d > ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/Announce.o.d > ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp ${OBJECTDIR}/_ext/1954962658/Announce.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Announce.o.tmp
endif
${OBJECTDIR}/_ext/812168374/motor.o: ../source/motor.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/812168374/motor.o.d -o ${OBJECTDIR}/_ext/812168374/motor.o ../source/motor.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/motor.o.d > ${OBJECTDIR}/_ext/812168374/motor.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/motor.o.tmp ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/motor.o.d > ${OBJECTDIR}/_ext/812168374/motor.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/motor.o.tmp ${OBJECTDIR}/_ext/812168374/motor.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/motor.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/TCP.o: ../../../Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/TCP.o.d -o ${OBJECTDIR}/_ext/1954962658/TCP.o ../../../Microchip/TCPIP\ Stack/TCP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/TCP.o.d > ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/TCP.o.d > ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp ${OBJECTDIR}/_ext/1954962658/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/TCP.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/HTTP2.o: ../../../Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d -o ${OBJECTDIR}/_ext/1954962658/HTTP2.o ../../../Microchip/TCPIP\ Stack/HTTP2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d > ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d > ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp ${OBJECTDIR}/_ext/1954962658/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/HTTP2.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/ICMP.o: ../../../Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/ICMP.o.d -o ${OBJECTDIR}/_ext/1954962658/ICMP.o ../../../Microchip/TCPIP\ Stack/ICMP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/ICMP.o.d > ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/ICMP.o.d > ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp ${OBJECTDIR}/_ext/1954962658/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/ICMP.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/Helpers.o: ../../../Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/Helpers.o.d -o ${OBJECTDIR}/_ext/1954962658/Helpers.o ../../../Microchip/TCPIP\ Stack/Helpers.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/Helpers.o.d > ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/Helpers.o.d > ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp ${OBJECTDIR}/_ext/1954962658/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/Helpers.o.tmp
endif
${OBJECTDIR}/_ext/1954962658/IP.o: ../../../Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1954962658 
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -fno-short-double -Wall -DMPLAB_DSPIC_PORT -D__C30__ -I"../include" -I"../../../Microchip/Include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -I"../../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -msmart-io=2 -MMD -MF ${OBJECTDIR}/_ext/1954962658/IP.o.d -o ${OBJECTDIR}/_ext/1954962658/IP.o ../../../Microchip/TCPIP\ Stack/IP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1954962658/IP.o.d > ${OBJECTDIR}/_ext/1954962658/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1954962658/IP.o.d > ${OBJECTDIR}/_ext/1954962658/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp ${OBJECTDIR}/_ext/1954962658/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1954962658/IP.o.tmp
endif
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf  -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -o dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf ${OBJECTFILES}        -Wl,--defsym=__MPLAB_BUILD=1,--heap=5120,--stack=4096,--no-check-sections,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1
else
dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf  -mcpu=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf ${OBJECTFILES}        -Wl,--defsym=__MPLAB_BUILD=1,--heap=5120,--stack=4096,--no-check-sections,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION)
	${MP_CC_DIR}/pic30-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/BDCMCAPP_mp.X.${IMAGE_TYPE}.elf -omf=elf
endif


# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf:
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
