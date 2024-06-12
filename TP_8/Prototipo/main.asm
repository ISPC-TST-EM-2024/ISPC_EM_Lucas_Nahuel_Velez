;============================================================
; Nombre del Archivo: p16f84.asm
; Fecha: 1/12/2019
; Autor: Cristian Gonzalo Vera
; Procesador: 16f84
; Referencia del circuito: 
;============================================================
; Copyright notice: Plantilla utilizada por IoT lab
;============================================================
; Descripcion del programa:
;
; 
;
;===========================
; configuracion de fusibles
;===========================
; Fusibles usados en __config directive:

;
; Micro. PIC16F84
; Osc XT
; Watchdog OFF
; Code protect ON
; Power-Up-Timer ON
;

; * _CP_ON Code protection ON/OFF
;   _CP_OFF
; * _PWRTE_ON Power-up timer ON/OFF
;   _PWRTE_OFF
;   _WDT_ON Watchdog timer ON/OFF
; * _WDT_OFF
;   _LP_OSC Low power crystal osccillator
; * _XT_OSC External parallel resonator
;   _HS_OSC High speed crystal resonator (8 to 10 MHz)
;   _RC_OSC Resistor/capacitor oscillator
;
;=========================
; setup y configuraciones
;=========================
      processor PIC16f648
;      LIST   P=PIC16F648
      #include <p16f648A.inc>
      __config _CP_ON & _CPD_OFF & _LVP_OFF & _BODEN_ON & _MCLRE_OFF & _PWRTE_ON & _WDTE_OFF & _INTOSC_OSC_NOCLKOUT
;=====================================================
; definicion de constantes
;=====================================================

z 	equ 02h 	;bandera de cero del registro de estados

;=====================================================
; Registros PIC
;=====================================================

status 	equ 03h 	;registro de estados
ptoa 	equ 05h 	;el puerto A está en la dirección 05 de la RAM
ptob 	equ 06h 	;el puerto B está en la dirección 06 de la RAM
trisa 	equ 85h 	;registro de configuración del puerto A
trisb 	equ 86h 	;registro de configuración del puerto B

;=====================================================
; variables en PIC RAM
;=====================================================

      cblock 0x20
      contb		;lleva el conteo de pulsaciones
      loops		;utilizado en retardos (milisegundos)
      loops2		;utilizado en retardos
      endc

;============================================================
; programa
;============================================================

Reset 	org 0   	;el vector de reset es la dirección 00
	goto Setup 	;se salta al inicio del programa
	
	;org 0x04               ;tratamiento de interrupcciones, en este programa no se utilizan.
	;goto interrupt

;
; subrutinas
;============================================================

	org 08h         ;inicio de subrutinas 
	 		;el programa empieza en la dirección de memoria 8

retardo 		;subrutina de retardo de 100 milisegundos
	 movlw D'100' 	;el registro loops contiene el número
	 movwf loops 	;de milisegundos del retardo
top2 	 movlw D'110' 	;
	 movwf loops2 	;
top 	 nop
	 nop
	 nop
	 nop
	 nop
	 nop
	 decfsz loops2 	;pregunta si terminó 1 ms
	 goto top
	 decfsz loops 	;pregunta si termina el retardo
	 goto top2
	 retlw 0
	
	
;
; main o principal
;============================================================

Setup
	 CLRF PORTA 		;Initialize PORTA by;setting;output data latches
	 MOVLW 0x07 		; comparadores modo off
	 MOVWF CMCON 		; para utilizar el puerto A como I/O
	 BCF STATUS, RP1
	 BSF STATUS, RP0 	;Selecciono el banco 1
	 MOVLW 0xFF 		
	 MOVWF TRISA 		; Se carga el puerto A como entrada, el pin 5 siempre es una entrada.
         MOVLW 0x00
	 MOVWF TRISB            ; Se carga el puerto B como salida 

	 bcf status,5 	;se ubica en el primer banco de memoria RAM
Loop	 clrf contb 	;inicia contador en cero
Ciclo 	 movf contb,w 	;el valor del contador pasa al registro W
	 movwf PORTB 	;pasa el valor de W al puerto A (display)
	 call retardo 	;retardo esperando que suelten la tecla
pulsa 	 btfsc PORTA,0 	;pregunta si el pulsador está oprimido
	 goto pulsa 	;si no lo está continúa revisándolo
	 call retardo 	;si está oprimido retarda 100 milisegundos
	 btfsc PORTA,0 	;para comprobar
	 goto pulsa 	;si no lo está vuelve a revisar
	 incf contb 	;si lo confirma incrementa el contador
	 movf contb,w 	;carga el registro W con el valor del conteo
	 xorlw 0ah 	;hace operación xor para ver si es igual a 0ah
	 btfsc status,z ;prueba si el contador llegó a 0ah (diez)
	 goto Loop 	;si es igual el contador se pone en ceros
	 goto Ciclo 	;si no llegó a diez incrementa normalmente

;============================================================
	 end ; END OF PROGRAM
;============================================================


;***************************************************************************
