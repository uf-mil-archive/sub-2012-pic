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
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf
else
IMAGE_TYPE=production
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf
endif
# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}
# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ${OBJECTDIR}/_ext/1386115845/heap_3.o ${OBJECTDIR}/_ext/812168374/mavg.o ${OBJECTDIR}/_ext/1147412712/queue.o ${OBJECTDIR}/_ext/1147412712/tasks.o ${OBJECTDIR}/_ext/812168374/main.o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ${OBJECTDIR}/_ext/812168374/simplequeue.o ${OBJECTDIR}/_ext/495416742/port.o ${OBJECTDIR}/_ext/812168374/adc.o ${OBJECTDIR}/_ext/812168374/taskParser.o ${OBJECTDIR}/_ext/1147412712/list.o ${OBJECTDIR}/_ext/812168374/taskUART.o ${OBJECTDIR}/_ext/812168374/messages.o


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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf

MP_PROCESSOR_OPTION=33FJ128MC802
MP_LINKER_FILE_OPTION=,-Tp33FJ128MC802.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
.PHONY: ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o
${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION) -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1,-g,-I".."
else
.PHONY: ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o
${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -omf=elf -c -mcpu=$(MP_PROCESSOR_OPTION) -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -o ${OBJECTDIR}/_ext/495416742/portasm_dsPIC.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-I".."
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
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
${OBJECTDIR}/_ext/1386115845/heap_3.o: ../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1386115845 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1386115845/heap_3.o.d -o ${OBJECTDIR}/_ext/1386115845/heap_3.o ../../FreeRTOS/Source/portable/MemMang/heap_3.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
endif
${OBJECTDIR}/_ext/812168374/mavg.o: ../source/mavg.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mavg.o.d -o ${OBJECTDIR}/_ext/812168374/mavg.o ../source/mavg.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
endif
${OBJECTDIR}/_ext/1147412712/queue.o: ../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/queue.o.d -o ${OBJECTDIR}/_ext/1147412712/queue.o ../../FreeRTOS/Source/queue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
endif
${OBJECTDIR}/_ext/1147412712/tasks.o: ../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/tasks.o.d -o ${OBJECTDIR}/_ext/1147412712/tasks.o ../../FreeRTOS/Source/tasks.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
endif
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
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
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
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
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/simplequeue.o.d -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
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
${OBJECTDIR}/_ext/495416742/port.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/495416742/port.o.d -o ${OBJECTDIR}/_ext/495416742/port.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp
endif
${OBJECTDIR}/_ext/812168374/adc.o: ../source/adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/adc.o.d -o ${OBJECTDIR}/_ext/812168374/adc.o ../source/adc.c  
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
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskParser.o.d -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
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
${OBJECTDIR}/_ext/1147412712/list.o: ../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/list.o.d -o ${OBJECTDIR}/_ext/1147412712/list.o ../../FreeRTOS/Source/list.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskUART.o.d -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
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
	${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/messages.o.d -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
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
else
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
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
${OBJECTDIR}/_ext/1386115845/heap_3.o: ../../FreeRTOS/Source/portable/MemMang/heap_3.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1386115845 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1386115845/heap_3.o.d -o ${OBJECTDIR}/_ext/1386115845/heap_3.o ../../FreeRTOS/Source/portable/MemMang/heap_3.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1386115845/heap_3.o.d > ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${CP} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp ${OBJECTDIR}/_ext/1386115845/heap_3.o.d 
	${RM} ${OBJECTDIR}/_ext/1386115845/heap_3.o.tmp
endif
${OBJECTDIR}/_ext/812168374/mavg.o: ../source/mavg.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/mavg.o.d -o ${OBJECTDIR}/_ext/812168374/mavg.o ../source/mavg.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/812168374/mavg.o.d > ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${CP} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp ${OBJECTDIR}/_ext/812168374/mavg.o.d 
	${RM} ${OBJECTDIR}/_ext/812168374/mavg.o.tmp
endif
${OBJECTDIR}/_ext/1147412712/queue.o: ../../FreeRTOS/Source/queue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/queue.o.d -o ${OBJECTDIR}/_ext/1147412712/queue.o ../../FreeRTOS/Source/queue.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/queue.o.d > ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp ${OBJECTDIR}/_ext/1147412712/queue.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/queue.o.tmp
endif
${OBJECTDIR}/_ext/1147412712/tasks.o: ../../FreeRTOS/Source/tasks.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/tasks.o.d -o ${OBJECTDIR}/_ext/1147412712/tasks.o ../../FreeRTOS/Source/tasks.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/tasks.o.d > ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp ${OBJECTDIR}/_ext/1147412712/tasks.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/tasks.o.tmp
endif
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
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
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskPublisher.o.d -o ${OBJECTDIR}/_ext/812168374/taskPublisher.o ../source/taskPublisher.c  
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
${OBJECTDIR}/_ext/812168374/simplequeue.o: ../source/simplequeue.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/simplequeue.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/simplequeue.o.d -o ${OBJECTDIR}/_ext/812168374/simplequeue.o ../source/simplequeue.c  
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
${OBJECTDIR}/_ext/495416742/port.o: ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/495416742 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/495416742/port.o.d -o ${OBJECTDIR}/_ext/495416742/port.o ../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC/port.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/495416742/port.o.d > ${OBJECTDIR}/_ext/495416742/port.o.tmp
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.d 
	${CP} ${OBJECTDIR}/_ext/495416742/port.o.tmp ${OBJECTDIR}/_ext/495416742/port.o.d 
	${RM} ${OBJECTDIR}/_ext/495416742/port.o.tmp
endif
${OBJECTDIR}/_ext/812168374/adc.o: ../source/adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/adc.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/adc.o.d -o ${OBJECTDIR}/_ext/812168374/adc.o ../source/adc.c  
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
${OBJECTDIR}/_ext/812168374/taskParser.o: ../source/taskParser.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskParser.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskParser.o.d -o ${OBJECTDIR}/_ext/812168374/taskParser.o ../source/taskParser.c  
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
${OBJECTDIR}/_ext/1147412712/list.o: ../../FreeRTOS/Source/list.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/1147412712 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/1147412712/list.o.d -o ${OBJECTDIR}/_ext/1147412712/list.o ../../FreeRTOS/Source/list.c  
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@sed -e 's/\"//g' -e 's/\\$$/__EOL__/g' -e 's/\\ /__ESCAPED_SPACES__/g' -e 's/\\/\//g' -e 's/__ESCAPED_SPACES__/\\ /g' -e 's/__EOL__$$/\\/g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp}
else 
	@sed -e 's/\"//g' ${OBJECTDIR}/_ext/1147412712/list.o.d > ${OBJECTDIR}/_ext/1147412712/list.o.tmp
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${CP} ${OBJECTDIR}/_ext/1147412712/list.o.tmp ${OBJECTDIR}/_ext/1147412712/list.o.d 
	${RM} ${OBJECTDIR}/_ext/1147412712/list.o.tmp
endif
${OBJECTDIR}/_ext/812168374/taskUART.o: ../source/taskUART.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/taskUART.o.d 
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/taskUART.o.d -o ${OBJECTDIR}/_ext/812168374/taskUART.o ../source/taskUART.c  
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
	${MP_CC} $(MP_EXTRA_CC_PRE)  -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -DMPLAB_DSPIC_PORT -I"../include" -I"../../Microchip/Include" -I"../../FreeRTOS/Source/include" -I"../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -mlarge-code -mlarge-data -O1 -MMD -MF ${OBJECTDIR}/_ext/812168374/messages.o.d -o ${OBJECTDIR}/_ext/812168374/messages.o ../source/messages.c  
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
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf  -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -o dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf ${OBJECTFILES}        -Wl,--defsym=__MPLAB_BUILD=1,--heap=8094,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1
else
dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf  -mcpu=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf ${OBJECTFILES}        -Wl,--defsym=__MPLAB_BUILD=1,--heap=8094,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION)
	${MP_CC_DIR}/pic30-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/DepthApp.X.${IMAGE_TYPE}.elf -omf=elf
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
