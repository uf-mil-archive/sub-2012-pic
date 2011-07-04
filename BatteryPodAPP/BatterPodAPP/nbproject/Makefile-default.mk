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
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf
else
IMAGE_TYPE=production
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf
endif
# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}
# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ${OBJECTDIR}/_ext/1386115845/heap_3.o ${OBJECTDIR}/_ext/812168374/mavg.o ${OBJECTDIR}/_ext/1295770447/ICMP.o ${OBJECTDIR}/_ext/812168374/main.o ${OBJECTDIR}/_ext/1295770447/NBNS.o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ${OBJECTDIR}/_ext/812168374/mcp4821.o ${OBJECTDIR}/_ext/1295770447/StackTsk.o ${OBJECTDIR}/_ext/1295770447/Helpers.o ${OBJECTDIR}/_ext/812168374/simplequeue.o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ${OBJECTDIR}/_ext/495416742/port.o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ${OBJECTDIR}/_ext/812168374/Tick.o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ${OBJECTDIR}/_ext/1295770447/HTTP2.o ${OBJECTDIR}/_ext/812168374/taskUART.o ${OBJECTDIR}/_ext/812168374/messages.o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ${OBJECTDIR}/_ext/1295770447/IP.o ${OBJECTDIR}/_ext/1295770447/ARP.o ${OBJECTDIR}/_ext/1147412712/queue.o ${OBJECTDIR}/_ext/1295770447/UDP.o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ${OBJECTDIR}/_ext/1147412712/tasks.o ${OBJECTDIR}/_ext/812168374/buzzer.o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ${OBJECTDIR}/_ext/812168374/taskParser.o ${OBJECTDIR}/_ext/812168374/taskADC.o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o ${OBJECTDIR}/_ext/1147412712/list.o ${OBJECTDIR}/_ext/1295770447/TCP.o ${OBJECTDIR}/_ext/1295770447/DNS.o ${OBJECTDIR}/_ext/1295770447/MPFS2.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

OS_ORIGINAL="MINGW32_NT-6.1"
OS_CURRENT="$(shell uname -s)"
############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
MP_CC=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin\\pic30-gcc.exe
# MP_BC is not defined
MP_AS=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin\\pic30-as.exe
MP_LD=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin\\pic30-ld.exe
MP_AR=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin\\pic30-ar.exe
# MP_BC is not defined
MP_CC_DIR=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin
# MP_BC_DIR is not defined
MP_AS_DIR=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin
MP_LD_DIR=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin
MP_AR_DIR=C:\\Program\ Files\ \(x86\)\\Microchip\\MPLAB\ C30\\bin
# MP_BC_DIR is not defined
.build-conf: ${BUILD_SUBPROJECTS}
ifneq ($(OS_CURRENT),$(OS_ORIGINAL))
	@echo "***** WARNING: This make file contains OS dependent code. The OS this makefile is being run is different from the OS it was created in."
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
.PHONY: ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o
${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o: ../source/MergeBoardWebPage.s  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -c -mcpu=33FJ128MC804 -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o ../source/MergeBoardWebPage.s  -Wa,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1,-g,-I".."
.PHONY: ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o
${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${MP_CC}  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -c -mcpu=33FJ128MC804 -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1,-g,-I".."
else
.PHONY: ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o
${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o: ../source/MergeBoardWebPage.s  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${MP_CC}  -omf=elf -c -mcpu=33FJ128MC804 -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o ../source/MergeBoardWebPage.s  -Wa,--defsym=__MPLAB_BUILD=1,-I".."
.PHONY: ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o
${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${MP_CC}  -omf=elf -c -mcpu=33FJ128MC804 -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" -o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1,-I".."
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp}
endif
${OBJECTDIR}/_ext/1386115845/heap_3.o: ../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1386115845 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1386115845/heap_3.o.d -o ${OBJECTDIR}/_ext/1386115845/heap_3.o ../../FreeRTOS/Source/portable/MemMang/heap_3.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/mavg.o: ../source/mavg.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mavg.o.d -o ${OBJECTDIR}/_ext/812168374/mavg.o ../source/mavg.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/ICMP.o: ../../Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/ICMP.o.d -o ${OBJECTDIR}/_ext/1295770447/ICMP.o ../../Microchip/TCPIP\ Stack/ICMP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/ICMP.o.d > ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/ICMP.o.d > ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/NBNS.o: ../../Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/NBNS.o.d -o ${OBJECTDIR}/_ext/1295770447/NBNS.o ../../Microchip/TCPIP\ Stack/NBNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/NBNS.o.d > ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/NBNS.o.d > ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskPublisher.o: ../source/taskPublisher.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp4821.o.d -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/StackTsk.o: ../../Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d -o ${OBJECTDIR}/_ext/1295770447/StackTsk.o ../../Microchip/TCPIP\ Stack/StackTsk.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d > ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d > ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/Helpers.o: ../../Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/Helpers.o.d -o ${OBJECTDIR}/_ext/1295770447/Helpers.o ../../Microchip/TCPIP\ Stack/Helpers.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/Helpers.o.d > ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/Helpers.o.d > ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/simplequeue.o.d -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/blockingDelay.o: ../source/blockingDelay.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d -o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ../source/blockingDelay.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp}
endif
${OBJECTDIR}/_ext/495416742/port.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/495416742/port.o.d -o ${OBJECTDIR}/_ext/495416742/port.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o: ../source/CustomHTTPApp.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d -o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ../source/CustomHTTPApp.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/Tick.o: ../source/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/Tick.o.d -o ${OBJECTDIR}/_ext/812168374/Tick.o ../source/Tick.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskTCPIP.o: ../source/taskTCPIP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d -o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ../source/taskTCPIP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/HTTP2.o: ../../Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d -o ${OBJECTDIR}/_ext/1295770447/HTTP2.o ../../Microchip/TCPIP\ Stack/HTTP2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d > ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d > ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskUART.o.d -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/messages.o: ../source/messages.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/messages.o.d -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/I2C_FanControl.o: ../source/I2C_FanControl.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d -o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ../source/I2C_FanControl.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d > ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d > ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/IP.o: ../../Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/IP.o.d -o ${OBJECTDIR}/_ext/1295770447/IP.o ../../Microchip/TCPIP\ Stack/IP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/IP.o.d > ${OBJECTDIR}/_ext/1295770447/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/IP.o.d > ${OBJECTDIR}/_ext/1295770447/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/ARP.o: ../../Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/ARP.o.d -o ${OBJECTDIR}/_ext/1295770447/ARP.o ../../Microchip/TCPIP\ Stack/ARP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/ARP.o.d > ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/ARP.o.d > ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp}
endif
${OBJECTDIR}/_ext/1147412712/queue.o: ../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/queue.o.d -o ${OBJECTDIR}/_ext/1147412712/queue.o ../../FreeRTOS/Source/queue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/UDP.o: ../../Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/UDP.o.d -o ${OBJECTDIR}/_ext/1295770447/UDP.o ../../Microchip/TCPIP\ Stack/UDP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/UDP.o.d > ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/UDP.o.d > ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/HallSwitches.o: ../source/HallSwitches.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d -o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ../source/HallSwitches.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d > ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d > ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp}
endif
${OBJECTDIR}/_ext/1147412712/tasks.o: ../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/tasks.o.d -o ${OBJECTDIR}/_ext/1147412712/tasks.o ../../FreeRTOS/Source/tasks.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/buzzer.o: ../source/buzzer.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/buzzer.o.d -o ${OBJECTDIR}/_ext/812168374/buzzer.o ../source/buzzer.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/buzzer.o.d > ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/buzzer.o.d > ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskParser.o.d -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskADC.o: ../source/taskADC.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskADC.o.d -o ${OBJECTDIR}/_ext/812168374/taskADC.o ../source/taskADC.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskADC.o.d > ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskADC.o.d > ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/ENC28J60.o: ../../Microchip/TCPIP\ Stack/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d -o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o ../../Microchip/TCPIP\ Stack/ENC28J60.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d > ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d > ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp}
endif
${OBJECTDIR}/_ext/1147412712/list.o: ../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/list.o.d -o ${OBJECTDIR}/_ext/1147412712/list.o ../../FreeRTOS/Source/list.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/TCP.o: ../../Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/TCP.o.d -o ${OBJECTDIR}/_ext/1295770447/TCP.o ../../Microchip/TCPIP\ Stack/TCP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/TCP.o.d > ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/TCP.o.d > ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/DNS.o: ../../Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/DNS.o.d -o ${OBJECTDIR}/_ext/1295770447/DNS.o ../../Microchip/TCPIP\ Stack/DNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/DNS.o.d > ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/DNS.o.d > ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/MPFS2.o: ../../Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d -o ${OBJECTDIR}/_ext/1295770447/MPFS2.o ../../Microchip/TCPIP\ Stack/MPFS2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d > ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d > ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp}
endif
else
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d > ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.tmp}
endif
${OBJECTDIR}/_ext/1386115845/heap_3.o: ../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1386115845 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1386115845/heap_3.o.d -o ${OBJECTDIR}/_ext/1386115845/heap_3.o ../../FreeRTOS/Source/portable/MemMang/heap_3.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/mavg.o: ../source/mavg.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mavg.o.d -o ${OBJECTDIR}/_ext/812168374/mavg.o ../source/mavg.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/ICMP.o: ../../Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/ICMP.o.d -o ${OBJECTDIR}/_ext/1295770447/ICMP.o ../../Microchip/TCPIP\ Stack/ICMP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/ICMP.o.d > ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/ICMP.o.d > ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/main.o.d > ${OBJECTDIR}/_ext/812168374/main.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/main.o.tmp ${OBJECTDIR}/_ext/812168374/main.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/NBNS.o: ../../Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/NBNS.o.d -o ${OBJECTDIR}/_ext/1295770447/NBNS.o ../../Microchip/TCPIP\ Stack/NBNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/NBNS.o.d > ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/NBNS.o.d > ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskPublisher.o: ../source/taskPublisher.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d > ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp4821.o.d -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mcp4821.o.d > ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/StackTsk.o: ../../Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d -o ${OBJECTDIR}/_ext/1295770447/StackTsk.o ../../Microchip/TCPIP\ Stack/StackTsk.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d > ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d > ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/Helpers.o: ../../Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/Helpers.o.d -o ${OBJECTDIR}/_ext/1295770447/Helpers.o ../../Microchip/TCPIP\ Stack/Helpers.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/Helpers.o.d > ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/Helpers.o.d > ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/simplequeue.o.d -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/simplequeue.o.d > ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/blockingDelay.o: ../source/blockingDelay.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d -o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ../source/blockingDelay.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d > ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.tmp}
endif
${OBJECTDIR}/_ext/495416742/port.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/495416742/port.o.d -o ${OBJECTDIR}/_ext/495416742/port.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o: ../source/CustomHTTPApp.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d -o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ../source/CustomHTTPApp.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d > ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/Tick.o: ../source/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/Tick.o.d -o ${OBJECTDIR}/_ext/812168374/Tick.o ../source/Tick.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/Tick.o.d > ${OBJECTDIR}/_ext/812168374/Tick.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskTCPIP.o: ../source/taskTCPIP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d -o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ../source/taskTCPIP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d > ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/HTTP2.o: ../../Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d -o ${OBJECTDIR}/_ext/1295770447/HTTP2.o ../../Microchip/TCPIP\ Stack/HTTP2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d > ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d > ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskUART.o.d -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskUART.o.d > ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/messages.o: ../source/messages.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/messages.o.d -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/messages.o.d > ${OBJECTDIR}/_ext/812168374/messages.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/messages.o.tmp ${OBJECTDIR}/_ext/812168374/messages.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/messages.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/I2C_FanControl.o: ../source/I2C_FanControl.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d -o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ../source/I2C_FanControl.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d > ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d > ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/IP.o: ../../Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/IP.o.d -o ${OBJECTDIR}/_ext/1295770447/IP.o ../../Microchip/TCPIP\ Stack/IP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/IP.o.d > ${OBJECTDIR}/_ext/1295770447/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/IP.o.d > ${OBJECTDIR}/_ext/1295770447/IP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/ARP.o: ../../Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/ARP.o.d -o ${OBJECTDIR}/_ext/1295770447/ARP.o ../../Microchip/TCPIP\ Stack/ARP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/ARP.o.d > ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/ARP.o.d > ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.tmp}
endif
${OBJECTDIR}/_ext/1147412712/queue.o: ../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/queue.o.d -o ${OBJECTDIR}/_ext/1147412712/queue.o ../../FreeRTOS/Source/queue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/UDP.o: ../../Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/UDP.o.d -o ${OBJECTDIR}/_ext/1295770447/UDP.o ../../Microchip/TCPIP\ Stack/UDP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/UDP.o.d > ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/UDP.o.d > ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/HallSwitches.o: ../source/HallSwitches.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d -o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ../source/HallSwitches.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d > ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d > ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.tmp}
endif
${OBJECTDIR}/_ext/1147412712/tasks.o: ../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/tasks.o.d -o ${OBJECTDIR}/_ext/1147412712/tasks.o ../../FreeRTOS/Source/tasks.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/buzzer.o: ../source/buzzer.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/buzzer.o.d -o ${OBJECTDIR}/_ext/812168374/buzzer.o ../source/buzzer.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/buzzer.o.d > ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/buzzer.o.d > ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskParser.o.d -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskParser.o.d > ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.tmp}
endif
${OBJECTDIR}/_ext/812168374/taskADC.o: ../source/taskADC.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskADC.o.d -o ${OBJECTDIR}/_ext/812168374/taskADC.o ../source/taskADC.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/taskADC.o.d > ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/taskADC.o.d > ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/ENC28J60.o: ../../Microchip/TCPIP\ Stack/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d -o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o ../../Microchip/TCPIP\ Stack/ENC28J60.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d > ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d > ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.tmp}
endif
${OBJECTDIR}/_ext/1147412712/list.o: ../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/list.o.d -o ${OBJECTDIR}/_ext/1147412712/list.o ../../FreeRTOS/Source/list.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/TCP.o: ../../Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/TCP.o.d -o ${OBJECTDIR}/_ext/1295770447/TCP.o ../../Microchip/TCPIP\ Stack/TCP.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/TCP.o.d > ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/TCP.o.d > ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/DNS.o: ../../Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/DNS.o.d -o ${OBJECTDIR}/_ext/1295770447/DNS.o ../../Microchip/TCPIP\ Stack/DNS.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/DNS.o.d > ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/DNS.o.d > ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.tmp}
endif
${OBJECTDIR}/_ext/1295770447/MPFS2.o: ../../Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d -o ${OBJECTDIR}/_ext/1295770447/MPFS2.o ../../Microchip/TCPIP\ Stack/MPFS2.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d > ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d > ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${CP} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.tmp}
endif
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC}  -omf=elf  -mcpu=33FJ128MC804  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -o dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf ${OBJECTFILES}       -Wl,--defsym=__MPLAB_BUILD=1,--heap=8094,--no-check-sections,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem,-Tp33FJ128MC804.gld,--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1
else
dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC}  -omf=elf  -mcpu=33FJ128MC804  -o dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf ${OBJECTFILES}       -Wl,--defsym=__MPLAB_BUILD=1,--heap=8094,--no-check-sections,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem,-Tp33FJ128MC804.gld
	${MP_CC_DIR}\\pic30-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.elf -omf=elf
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
