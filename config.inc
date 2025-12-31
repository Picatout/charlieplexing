;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;-----------------------
;  version  
;  information 
;-----------------------
	MAJOR=1
	MINOR=0
	REV=0


; master clock frequency in Mhz 
	FMSTR=16
; TIMER 4 delay boolean flag 
	F_PAUSE=7 ; when set pause in active  
	F_BTN1=0  ; set when switch 1 is down 
	F_BTN2=1  ; set when switch 2 is down
	 
; buttons ports 
	BTN1_PORT = PC
	BTN1_BIT = 0  ; (pin 7)
	BTN2_PORT = PC 
	BTN2_BIT = 1  ; (pin 8)
	 
	.include "inc/gen_macros.inc" 
	.include "inc/stm8l001j3.inc"
	.include "stm8l001j3_vec.asm" 
	.include "hardware_init.asm"



