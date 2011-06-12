There are three types of linker scripts in this directory. The following decribe the three types and samples of each are included with the bootloader source code.

There are the user application linker scripts to be used to compile the user's application.
   p24FJ128GA010 - EBLE Application.gld
   p24HJ256GP610 - ELBE Application.gld
   p33FJ256GP710 - ELBE Application.gld


There are the linker scripts for compiling the bootloader without debugging. These are the scripts that will normally be used for compiling the bootloader.
   p24FJ128GA010_ENC_LDR.gld
   p24HJ256GP610_ENC_LDR.gld
   p33FJ256GP710_ENC_LDR.gld


There are linker scripts for compiling the bootloader with debuggin print statements. These scripts would typically be used for integrating new features ito the bootloader. These scripts are required when enabling the "#define ldr_debug" directive in the bootloader.
   p24FJ128GA010_ENC_LDR_debug.gld
   p24HJ256GP610_ENC_LDR_debug.gld
   p33FJ256GP710_ENC_LDR_debug.gld


