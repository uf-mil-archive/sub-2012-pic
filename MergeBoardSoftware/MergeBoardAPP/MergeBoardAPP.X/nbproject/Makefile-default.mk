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
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf
else
IMAGE_TYPE=production
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf
endif
# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}
# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ${OBJECTDIR}/_ext/812168374/main.o ${OBJECTDIR}/_ext/812168374/mcp4821.o


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
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -I"../include" -I"../../../Microchip/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -mlarge-code -mlarge-data -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
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
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -I"../include" -I"../../../Microchip/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -mlarge-code -mlarge-data -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
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
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${MP_CC} -g -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -I"../include" -I"../../../Microchip/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -mlarge-code -mlarge-data -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp4821.o.d -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
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
else
${OBJECTDIR}/_ext/812168374/mcp25XX640A.o: ../source/mcp25XX640A.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -I"../include" -I"../../../Microchip/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -mlarge-code -mlarge-data -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o.d -o ${OBJECTDIR}/_ext/812168374/mcp25XX640A.o ../source/mcp25XX640A.c  
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
${OBJECTDIR}/_ext/812168374/main.o: ../source/main.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/main.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -I"../include" -I"../../../Microchip/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -mlarge-code -mlarge-data -MMD -MF ${OBJECTDIR}/_ext/812168374/main.o.d -o ${OBJECTDIR}/_ext/812168374/main.o ../source/main.c  
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
${OBJECTDIR}/_ext/812168374/mcp4821.o: ../source/mcp4821.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/812168374 
	${RM} ${OBJECTDIR}/_ext/812168374/mcp4821.o.d 
	${MP_CC}  -omf=elf -x c -c -mcpu=33FJ128MC804 -Wall -I"../include" -I"../../../Microchip/include" -I"../../../FreeRTOS/Source/portable/MPLAB/PIC24_dsPIC" -I"../../../FreeRTOS/Source/include" -mlarge-code -mlarge-data -MMD -MF ${OBJECTDIR}/_ext/812168374/mcp4821.o.d -o ${OBJECTDIR}/_ext/812168374/mcp4821.o ../source/mcp4821.c  
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
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC}  -omf=elf  -mcpu=33FJ128MC804  -D__DEBUG -D__MPLAB_DEBUGGER_REAL_ICE=1 -o dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf ${OBJECTFILES}       -Wl,--defsym=__MPLAB_BUILD=1,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem,-Tp33FJ128MC804.gld,--defsym=__MPLAB_DEBUG=1,--defsym=__ICD2RAM=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_REAL_ICE=1
else
dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC}  -omf=elf  -mcpu=33FJ128MC804  -o dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf ${OBJECTFILES}       -Wl,--defsym=__MPLAB_BUILD=1,-L"..",-Map="$(BINDIR_)$(TARGETBASE).map",--report-mem,--report-mem,-Tp33FJ128MC804.gld
	${MP_CC_DIR}\\pic30-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/MergeBoardAPP.X.${IMAGE_TYPE}.elf -omf=elf
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
