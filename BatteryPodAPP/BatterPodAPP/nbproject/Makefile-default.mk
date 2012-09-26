#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1386115845/heap_3.o ${OBJECTDIR}/_ext/1147412712/list.o ${OBJECTDIR}/_ext/495416742/port.o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ${OBJECTDIR}/_ext/1147412712/queue.o ${OBJECTDIR}/_ext/1147412712/tasks.o ${OBJECTDIR}/_ext/1295770447/ARP.o ${OBJECTDIR}/_ext/1295770447/DNS.o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o ${OBJECTDIR}/_ext/1295770447/HTTP2.o ${OBJECTDIR}/_ext/1295770447/Helpers.o ${OBJECTDIR}/_ext/1295770447/ICMP.o ${OBJECTDIR}/_ext/1295770447/IP.o ${OBJECTDIR}/_ext/1295770447/MPFS2.o ${OBJECTDIR}/_ext/1295770447/NBNS.o ${OBJECTDIR}/_ext/1295770447/StackTsk.o ${OBJECTDIR}/_ext/1295770447/TCP.o ${OBJECTDIR}/_ext/1295770447/UDP.o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o ${OBJECTDIR}/_ext/812168374/Tick.o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ${OBJECTDIR}/_ext/812168374/buzzer.o ${OBJECTDIR}/_ext/812168374/main.o ${OBJECTDIR}/_ext/812168374/mavg.o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ${OBJECTDIR}/_ext/812168374/mcp4821.o ${OBJECTDIR}/_ext/812168374/messages.o ${OBJECTDIR}/_ext/812168374/simplequeue.o ${OBJECTDIR}/_ext/812168374/taskADC.o ${OBJECTDIR}/_ext/812168374/taskParser.o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ${OBJECTDIR}/_ext/812168374/taskUART.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1386115845/heap_3.o.d ${OBJECTDIR}/_ext/1147412712/list.o.d ${OBJECTDIR}/_ext/495416742/port.o.d ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d ${OBJECTDIR}/_ext/1147412712/queue.o.d ${OBJECTDIR}/_ext/1147412712/tasks.o.d ${OBJECTDIR}/_ext/1295770447/ARP.o.d ${OBJECTDIR}/_ext/1295770447/DNS.o.d ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d ${OBJECTDIR}/_ext/1295770447/Helpers.o.d ${OBJECTDIR}/_ext/1295770447/ICMP.o.d ${OBJECTDIR}/_ext/1295770447/IP.o.d ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d ${OBJECTDIR}/_ext/1295770447/NBNS.o.d ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d ${OBJECTDIR}/_ext/1295770447/TCP.o.d ${OBJECTDIR}/_ext/1295770447/UDP.o.d ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d ${OBJECTDIR}/_ext/812168374/Tick.o.d ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d ${OBJECTDIR}/_ext/812168374/buzzer.o.d ${OBJECTDIR}/_ext/812168374/main.o.d ${OBJECTDIR}/_ext/812168374/mavg.o.d ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d ${OBJECTDIR}/_ext/812168374/mcp4821.o.d ${OBJECTDIR}/_ext/812168374/messages.o.d ${OBJECTDIR}/_ext/812168374/simplequeue.o.d ${OBJECTDIR}/_ext/812168374/taskADC.o.d ${OBJECTDIR}/_ext/812168374/taskParser.o.d ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d ${OBJECTDIR}/_ext/812168374/taskUART.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1386115845/heap_3.o ${OBJECTDIR}/_ext/1147412712/list.o ${OBJECTDIR}/_ext/495416742/port.o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ${OBJECTDIR}/_ext/1147412712/queue.o ${OBJECTDIR}/_ext/1147412712/tasks.o ${OBJECTDIR}/_ext/1295770447/ARP.o ${OBJECTDIR}/_ext/1295770447/DNS.o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o ${OBJECTDIR}/_ext/1295770447/HTTP2.o ${OBJECTDIR}/_ext/1295770447/Helpers.o ${OBJECTDIR}/_ext/1295770447/ICMP.o ${OBJECTDIR}/_ext/1295770447/IP.o ${OBJECTDIR}/_ext/1295770447/MPFS2.o ${OBJECTDIR}/_ext/1295770447/NBNS.o ${OBJECTDIR}/_ext/1295770447/StackTsk.o ${OBJECTDIR}/_ext/1295770447/TCP.o ${OBJECTDIR}/_ext/1295770447/UDP.o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o ${OBJECTDIR}/_ext/812168374/Tick.o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ${OBJECTDIR}/_ext/812168374/buzzer.o ${OBJECTDIR}/_ext/812168374/main.o ${OBJECTDIR}/_ext/812168374/mavg.o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ${OBJECTDIR}/_ext/812168374/mcp4821.o ${OBJECTDIR}/_ext/812168374/messages.o ${OBJECTDIR}/_ext/812168374/simplequeue.o ${OBJECTDIR}/_ext/812168374/taskADC.o ${OBJECTDIR}/_ext/812168374/taskParser.o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ${OBJECTDIR}/_ext/812168374/taskUART.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33FJ128MC804
MP_LINKER_FILE_OPTION=,-Tp33FJ128MC804.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o: ../source/MergeBoardWebPage.s  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.ok ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" ../source/MergeBoardWebPage.s -o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o -omf=elf -p=$(MP_PROCESSOR_OPTION) --defsym=__MPLAB_BUILD=1 --defsym=__MPLAB_DEBUG=1 --defsym=__ICD2RAM=1 --defsym=__DEBUG=1 --defsym=__MPLAB_DEBUGGER_PK3=1 -g  -MD "${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d" -I".."$(MP_EXTRA_AS_POST)
	
else
${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o: ../source/MergeBoardWebPage.s  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.ok ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" ../source/MergeBoardWebPage.s -o ${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o -omf=elf -p=$(MP_PROCESSOR_OPTION) --defsym=__MPLAB_BUILD=1 -g  -MD "${OBJECTDIR}/_ext/812168374/MergeBoardWebPage.o.d" -I".."$(MP_EXTRA_AS_POST)
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/495416742 
	@${RM} ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.asm.d 
	@${RM} ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.ok ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d" "${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.asm.d" -t $(SILENT) -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION)  -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" -MMD -MF "${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d"  -o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.asm.d",--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-g,-I".."
	
else
${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/495416742 
	@${RM} ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.asm.d 
	@${RM} ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.ok ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d" "${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.asm.d" -t $(SILENT) -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION)  -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include/TCPIP Stack" -MMD -MF "${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.d"  -o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o.asm.d",-g,-I".."
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1386115845/heap_3.o: ../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1386115845 
	@${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.ok ${OBJECTDIR}/_ext/1386115845/heap_3.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1386115845/heap_3.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1386115845/heap_3.o.d" -o ${OBJECTDIR}/_ext/1386115845/heap_3.o ../../FreeRTOS/Source/portable/MemMang/heap_3.c  
	
${OBJECTDIR}/_ext/1147412712/list.o: ../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	@${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	@${RM} ${OBJECTDIR}/_ext/1147412712/list.o.ok ${OBJECTDIR}/_ext/1147412712/list.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1147412712/list.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1147412712/list.o.d" -o ${OBJECTDIR}/_ext/1147412712/list.o ../../FreeRTOS/Source/list.c  
	
${OBJECTDIR}/_ext/495416742/port.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/495416742 
	@${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	@${RM} ${OBJECTDIR}/_ext/495416742/port.o.ok ${OBJECTDIR}/_ext/495416742/port.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/495416742/port.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/495416742/port.o.d" -o ${OBJECTDIR}/_ext/495416742/port.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
	
${OBJECTDIR}/_ext/1147412712/queue.o: ../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	@${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.ok ${OBJECTDIR}/_ext/1147412712/queue.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1147412712/queue.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1147412712/queue.o.d" -o ${OBJECTDIR}/_ext/1147412712/queue.o ../../FreeRTOS/Source/queue.c  
	
${OBJECTDIR}/_ext/1147412712/tasks.o: ../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	@${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.ok ${OBJECTDIR}/_ext/1147412712/tasks.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1147412712/tasks.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1147412712/tasks.o.d" -o ${OBJECTDIR}/_ext/1147412712/tasks.o ../../FreeRTOS/Source/tasks.c  
	
${OBJECTDIR}/_ext/1295770447/ARP.o: ../../Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.ok ${OBJECTDIR}/_ext/1295770447/ARP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/ARP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/ARP.o.d" -o ${OBJECTDIR}/_ext/1295770447/ARP.o "../../Microchip/TCPIP Stack/ARP.c"  
	
${OBJECTDIR}/_ext/1295770447/DNS.o: ../../Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.ok ${OBJECTDIR}/_ext/1295770447/DNS.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/DNS.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/DNS.o.d" -o ${OBJECTDIR}/_ext/1295770447/DNS.o "../../Microchip/TCPIP Stack/DNS.c"  
	
${OBJECTDIR}/_ext/1295770447/ENC28J60.o: ../../Microchip/TCPIP\ Stack/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.ok ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d" -o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o "../../Microchip/TCPIP Stack/ENC28J60.c"  
	
${OBJECTDIR}/_ext/1295770447/HTTP2.o: ../../Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.ok ${OBJECTDIR}/_ext/1295770447/HTTP2.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/HTTP2.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/HTTP2.o.d" -o ${OBJECTDIR}/_ext/1295770447/HTTP2.o "../../Microchip/TCPIP Stack/HTTP2.c"  
	
${OBJECTDIR}/_ext/1295770447/Helpers.o: ../../Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.ok ${OBJECTDIR}/_ext/1295770447/Helpers.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/Helpers.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/Helpers.o.d" -o ${OBJECTDIR}/_ext/1295770447/Helpers.o "../../Microchip/TCPIP Stack/Helpers.c"  
	
${OBJECTDIR}/_ext/1295770447/ICMP.o: ../../Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.ok ${OBJECTDIR}/_ext/1295770447/ICMP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/ICMP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/ICMP.o.d" -o ${OBJECTDIR}/_ext/1295770447/ICMP.o "../../Microchip/TCPIP Stack/ICMP.c"  
	
${OBJECTDIR}/_ext/1295770447/IP.o: ../../Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.ok ${OBJECTDIR}/_ext/1295770447/IP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/IP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/IP.o.d" -o ${OBJECTDIR}/_ext/1295770447/IP.o "../../Microchip/TCPIP Stack/IP.c"  
	
${OBJECTDIR}/_ext/1295770447/MPFS2.o: ../../Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.ok ${OBJECTDIR}/_ext/1295770447/MPFS2.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/MPFS2.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/MPFS2.o.d" -o ${OBJECTDIR}/_ext/1295770447/MPFS2.o "../../Microchip/TCPIP Stack/MPFS2.c"  
	
${OBJECTDIR}/_ext/1295770447/NBNS.o: ../../Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.ok ${OBJECTDIR}/_ext/1295770447/NBNS.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/NBNS.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/NBNS.o.d" -o ${OBJECTDIR}/_ext/1295770447/NBNS.o "../../Microchip/TCPIP Stack/NBNS.c"  
	
${OBJECTDIR}/_ext/1295770447/StackTsk.o: ../../Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.ok ${OBJECTDIR}/_ext/1295770447/StackTsk.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/StackTsk.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/StackTsk.o.d" -o ${OBJECTDIR}/_ext/1295770447/StackTsk.o "../../Microchip/TCPIP Stack/StackTsk.c"  
	
${OBJECTDIR}/_ext/1295770447/TCP.o: ../../Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.ok ${OBJECTDIR}/_ext/1295770447/TCP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/TCP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/TCP.o.d" -o ${OBJECTDIR}/_ext/1295770447/TCP.o "../../Microchip/TCPIP Stack/TCP.c"  
	
${OBJECTDIR}/_ext/1295770447/UDP.o: ../../Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.ok ${OBJECTDIR}/_ext/1295770447/UDP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/UDP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/UDP.o.d" -o ${OBJECTDIR}/_ext/1295770447/UDP.o "../../Microchip/TCPIP Stack/UDP.c"  
	
${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o: ../source/CustomHTTPApp.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.ok ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d" -o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ../source/CustomHTTPApp.c  
	
${OBJECTDIR}/_ext/812168374/HallSwitches.o: ../source/HallSwitches.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.ok ${OBJECTDIR}/_ext/812168374/HallSwitches.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/HallSwitches.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/HallSwitches.o.d" -o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ../source/HallSwitches.c  
	
${OBJECTDIR}/_ext/812168374/I2C_FanControl.o: ../source/I2C_FanControl.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.ok ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d" -o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ../source/I2C_FanControl.c  
	
${OBJECTDIR}/_ext/812168374/Tick.o: ../source/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.ok ${OBJECTDIR}/_ext/812168374/Tick.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/Tick.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/Tick.o.d" -o ${OBJECTDIR}/_ext/812168374/Tick.o ../source/Tick.c  
	
${OBJECTDIR}/_ext/812168374/blockingDelay.o: ../source/blockingDelay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.ok ${OBJECTDIR}/_ext/812168374/blockingDelay.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/blockingDelay.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/blockingDelay.o.d" -o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ../source/blockingDelay.c  
	
${OBJECTDIR}/_ext/812168374/buzzer.o: ../source/buzzer.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.ok ${OBJECTDIR}/_ext/812168374/buzzer.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/buzzer.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/buzzer.o.d" -o ${OBJECTDIR}/_ext/812168374/buzzer.o ../source/buzzer.c  
	
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/main.o.ok ${OBJECTDIR}/_ext/812168374/main.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/main.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/main.o.d" -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
	
${OBJECTDIR}/_ext/812168374/mavg.o: ../source/mavg.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.ok ${OBJECTDIR}/_ext/812168374/mavg.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/mavg.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/mavg.o.d" -o ${OBJECTDIR}/_ext/812168374/mavg.o ../source/mavg.c  
	
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.ok ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d" -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
	
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.ok ${OBJECTDIR}/_ext/812168374/mcp4821.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/mcp4821.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/mcp4821.o.d" -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
	
${OBJECTDIR}/_ext/812168374/messages.o: ../source/messages.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/messages.o.ok ${OBJECTDIR}/_ext/812168374/messages.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/messages.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/messages.o.d" -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
	
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.ok ${OBJECTDIR}/_ext/812168374/simplequeue.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/simplequeue.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/simplequeue.o.d" -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
	
${OBJECTDIR}/_ext/812168374/taskADC.o: ../source/taskADC.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.ok ${OBJECTDIR}/_ext/812168374/taskADC.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskADC.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskADC.o.d" -o ${OBJECTDIR}/_ext/812168374/taskADC.o ../source/taskADC.c  
	
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.ok ${OBJECTDIR}/_ext/812168374/taskParser.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskParser.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskParser.o.d" -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
	
${OBJECTDIR}/_ext/812168374/taskPublisher.o: ../source/taskPublisher.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.ok ${OBJECTDIR}/_ext/812168374/taskPublisher.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskPublisher.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskPublisher.o.d" -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
	
${OBJECTDIR}/_ext/812168374/taskTCPIP.o: ../source/taskTCPIP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.ok ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d" -o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ../source/taskTCPIP.c  
	
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.ok ${OBJECTDIR}/_ext/812168374/taskUART.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskUART.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskUART.o.d" -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
	
else
${OBJECTDIR}/_ext/1386115845/heap_3.o: ../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1386115845 
	@${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.ok ${OBJECTDIR}/_ext/1386115845/heap_3.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1386115845/heap_3.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1386115845/heap_3.o.d" -o ${OBJECTDIR}/_ext/1386115845/heap_3.o ../../FreeRTOS/Source/portable/MemMang/heap_3.c  
	
${OBJECTDIR}/_ext/1147412712/list.o: ../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	@${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	@${RM} ${OBJECTDIR}/_ext/1147412712/list.o.ok ${OBJECTDIR}/_ext/1147412712/list.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1147412712/list.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1147412712/list.o.d" -o ${OBJECTDIR}/_ext/1147412712/list.o ../../FreeRTOS/Source/list.c  
	
${OBJECTDIR}/_ext/495416742/port.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/495416742 
	@${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	@${RM} ${OBJECTDIR}/_ext/495416742/port.o.ok ${OBJECTDIR}/_ext/495416742/port.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/495416742/port.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/495416742/port.o.d" -o ${OBJECTDIR}/_ext/495416742/port.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
	
${OBJECTDIR}/_ext/1147412712/queue.o: ../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	@${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.ok ${OBJECTDIR}/_ext/1147412712/queue.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1147412712/queue.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1147412712/queue.o.d" -o ${OBJECTDIR}/_ext/1147412712/queue.o ../../FreeRTOS/Source/queue.c  
	
${OBJECTDIR}/_ext/1147412712/tasks.o: ../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	@${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.ok ${OBJECTDIR}/_ext/1147412712/tasks.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1147412712/tasks.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1147412712/tasks.o.d" -o ${OBJECTDIR}/_ext/1147412712/tasks.o ../../FreeRTOS/Source/tasks.c  
	
${OBJECTDIR}/_ext/1295770447/ARP.o: ../../Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ARP.o.ok ${OBJECTDIR}/_ext/1295770447/ARP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/ARP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/ARP.o.d" -o ${OBJECTDIR}/_ext/1295770447/ARP.o "../../Microchip/TCPIP Stack/ARP.c"  
	
${OBJECTDIR}/_ext/1295770447/DNS.o: ../../Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/DNS.o.ok ${OBJECTDIR}/_ext/1295770447/DNS.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/DNS.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/DNS.o.d" -o ${OBJECTDIR}/_ext/1295770447/DNS.o "../../Microchip/TCPIP Stack/DNS.c"  
	
${OBJECTDIR}/_ext/1295770447/ENC28J60.o: ../../Microchip/TCPIP\ Stack/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.ok ${OBJECTDIR}/_ext/1295770447/ENC28J60.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/ENC28J60.o.d" -o ${OBJECTDIR}/_ext/1295770447/ENC28J60.o "../../Microchip/TCPIP Stack/ENC28J60.c"  
	
${OBJECTDIR}/_ext/1295770447/HTTP2.o: ../../Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/HTTP2.o.ok ${OBJECTDIR}/_ext/1295770447/HTTP2.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/HTTP2.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/HTTP2.o.d" -o ${OBJECTDIR}/_ext/1295770447/HTTP2.o "../../Microchip/TCPIP Stack/HTTP2.c"  
	
${OBJECTDIR}/_ext/1295770447/Helpers.o: ../../Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/Helpers.o.ok ${OBJECTDIR}/_ext/1295770447/Helpers.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/Helpers.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/Helpers.o.d" -o ${OBJECTDIR}/_ext/1295770447/Helpers.o "../../Microchip/TCPIP Stack/Helpers.c"  
	
${OBJECTDIR}/_ext/1295770447/ICMP.o: ../../Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/ICMP.o.ok ${OBJECTDIR}/_ext/1295770447/ICMP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/ICMP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/ICMP.o.d" -o ${OBJECTDIR}/_ext/1295770447/ICMP.o "../../Microchip/TCPIP Stack/ICMP.c"  
	
${OBJECTDIR}/_ext/1295770447/IP.o: ../../Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/IP.o.ok ${OBJECTDIR}/_ext/1295770447/IP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/IP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/IP.o.d" -o ${OBJECTDIR}/_ext/1295770447/IP.o "../../Microchip/TCPIP Stack/IP.c"  
	
${OBJECTDIR}/_ext/1295770447/MPFS2.o: ../../Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/MPFS2.o.ok ${OBJECTDIR}/_ext/1295770447/MPFS2.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/MPFS2.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/MPFS2.o.d" -o ${OBJECTDIR}/_ext/1295770447/MPFS2.o "../../Microchip/TCPIP Stack/MPFS2.c"  
	
${OBJECTDIR}/_ext/1295770447/NBNS.o: ../../Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/NBNS.o.ok ${OBJECTDIR}/_ext/1295770447/NBNS.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/NBNS.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/NBNS.o.d" -o ${OBJECTDIR}/_ext/1295770447/NBNS.o "../../Microchip/TCPIP Stack/NBNS.c"  
	
${OBJECTDIR}/_ext/1295770447/StackTsk.o: ../../Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/StackTsk.o.ok ${OBJECTDIR}/_ext/1295770447/StackTsk.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/StackTsk.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/StackTsk.o.d" -o ${OBJECTDIR}/_ext/1295770447/StackTsk.o "../../Microchip/TCPIP Stack/StackTsk.c"  
	
${OBJECTDIR}/_ext/1295770447/TCP.o: ../../Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/TCP.o.ok ${OBJECTDIR}/_ext/1295770447/TCP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/TCP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/TCP.o.d" -o ${OBJECTDIR}/_ext/1295770447/TCP.o "../../Microchip/TCPIP Stack/TCP.c"  
	
${OBJECTDIR}/_ext/1295770447/UDP.o: ../../Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1295770447 
	@${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.d 
	@${RM} ${OBJECTDIR}/_ext/1295770447/UDP.o.ok ${OBJECTDIR}/_ext/1295770447/UDP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1295770447/UDP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/1295770447/UDP.o.d" -o ${OBJECTDIR}/_ext/1295770447/UDP.o "../../Microchip/TCPIP Stack/UDP.c"  
	
${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o: ../source/CustomHTTPApp.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.ok ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o.d" -o ${OBJECTDIR}/_ext/812168374/CustomHTTPApp.o ../source/CustomHTTPApp.c  
	
${OBJECTDIR}/_ext/812168374/HallSwitches.o: ../source/HallSwitches.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/HallSwitches.o.ok ${OBJECTDIR}/_ext/812168374/HallSwitches.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/HallSwitches.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/HallSwitches.o.d" -o ${OBJECTDIR}/_ext/812168374/HallSwitches.o ../source/HallSwitches.c  
	
${OBJECTDIR}/_ext/812168374/I2C_FanControl.o: ../source/I2C_FanControl.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.ok ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/I2C_FanControl.o.d" -o ${OBJECTDIR}/_ext/812168374/I2C_FanControl.o ../source/I2C_FanControl.c  
	
${OBJECTDIR}/_ext/812168374/Tick.o: ../source/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/Tick.o.ok ${OBJECTDIR}/_ext/812168374/Tick.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/Tick.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/Tick.o.d" -o ${OBJECTDIR}/_ext/812168374/Tick.o ../source/Tick.c  
	
${OBJECTDIR}/_ext/812168374/blockingDelay.o: ../source/blockingDelay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/blockingDelay.o.ok ${OBJECTDIR}/_ext/812168374/blockingDelay.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/blockingDelay.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/blockingDelay.o.d" -o ${OBJECTDIR}/_ext/812168374/blockingDelay.o ../source/blockingDelay.c  
	
${OBJECTDIR}/_ext/812168374/buzzer.o: ../source/buzzer.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/buzzer.o.ok ${OBJECTDIR}/_ext/812168374/buzzer.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/buzzer.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/buzzer.o.d" -o ${OBJECTDIR}/_ext/812168374/buzzer.o ../source/buzzer.c  
	
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/main.o.ok ${OBJECTDIR}/_ext/812168374/main.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/main.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/main.o.d" -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
	
${OBJECTDIR}/_ext/812168374/mavg.o: ../source/mavg.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.ok ${OBJECTDIR}/_ext/812168374/mavg.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/mavg.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/mavg.o.d" -o ${OBJECTDIR}/_ext/812168374/mavg.o ../source/mavg.c  
	
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.ok ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d" -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
	
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.ok ${OBJECTDIR}/_ext/812168374/mcp4821.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/mcp4821.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/mcp4821.o.d" -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
	
${OBJECTDIR}/_ext/812168374/messages.o: ../source/messages.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/messages.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/messages.o.ok ${OBJECTDIR}/_ext/812168374/messages.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/messages.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/messages.o.d" -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
	
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.ok ${OBJECTDIR}/_ext/812168374/simplequeue.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/simplequeue.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/simplequeue.o.d" -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
	
${OBJECTDIR}/_ext/812168374/taskADC.o: ../source/taskADC.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskADC.o.ok ${OBJECTDIR}/_ext/812168374/taskADC.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskADC.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskADC.o.d" -o ${OBJECTDIR}/_ext/812168374/taskADC.o ../source/taskADC.c  
	
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.ok ${OBJECTDIR}/_ext/812168374/taskParser.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskParser.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskParser.o.d" -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
	
${OBJECTDIR}/_ext/812168374/taskPublisher.o: ../source/taskPublisher.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskPublisher.o.ok ${OBJECTDIR}/_ext/812168374/taskPublisher.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskPublisher.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskPublisher.o.d" -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
	
${OBJECTDIR}/_ext/812168374/taskTCPIP.o: ../source/taskTCPIP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.ok ${OBJECTDIR}/_ext/812168374/taskTCPIP.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskTCPIP.o.d" -o ${OBJECTDIR}/_ext/812168374/taskTCPIP.o ../source/taskTCPIP.c  
	
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/812168374 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	@${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.ok ${OBJECTDIR}/_ext/812168374/taskUART.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/812168374/taskUART.o.d" $(SILENT) -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../FreeRTOS/Source/include" -I"../../Microchip/Include" -I"../../Microchip/Include/TCPIP Stack" -mlarge-code -mlarge-data -O1 -MMD -MF "${OBJECTDIR}/_ext/812168374/taskUART.o.d" -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -o dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}        -Wl,--defsym=__MPLAB_BUILD=1,--heap=8094,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1
else
dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf -mcpu=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}        -Wl,--defsym=__MPLAB_BUILD=1,--heap=8094,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION)
	${MP_CC_DIR}\\pic30-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/BatterPodAPP.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -omf=elf
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
