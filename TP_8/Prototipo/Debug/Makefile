###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = PIC16F648A
COMPILER = "MPASM (Proteus)"
TARGET = Debug
SHELL = C:\WINDOWS\system32\cmd.exe

## Tools general options
ASMFLAGS=/q+ /p16f648a
LDFLAGS=/x /p16f648a

## Processing Tools
ASM=MPASMWIN.exe
LD=mplink.exe
LIB=mplib.exe
#  C:/Users/Admin/AppData/Local/Temp/7802bb256d914358ba8bfc91d794e809/PIC16F648A/Debug/Debug.cof: TOOL=LD
#     C:/Users/Admin/AppData/Local/Temp/7802bb256d914358ba8bfc91d794e809/PIC16F648A/Debug/main.o: TOOL=ASM
#        C:/Users/Admin/AppData/Local/Temp/7802bb256d914358ba8bfc91d794e809/PIC16F648A/main.asm

# Build tree:
all:	Debug

Debug:	Debug.cof

Debug.cof:	main.o 
	$(LD) $(LDFLAGS) /o "./Debug.cof" 16f648a_g.lkr "main.o"

main.o:	../main.asm 
	$(ASM) /e"./main.err" /l"./main.lst" /o"main.o" $(ASMFLAGS)  "..\main.asm"

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf ./main.err
	rm -rf ./main.hex
	rm -rf ./main.lst

# cleanup - delete all generated files
clean:	tidy
	rm -rf Debug.cof
	rm -rf main.o
