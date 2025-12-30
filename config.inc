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
	F_DELAY=0 ; when reset pause exit 
	F_ANIM=1 ; when set animation step to next stage 

; buttons ports 
	BTN1_PORT = PC
	BTN1_BIT = 0  ; (pin 7)
	BTN2_PORT = PC 
	BTN2_BIT = 1  ; (pin 8)
	 
	.include "inc/gen_macros.inc" 
	.include "inc/stm8l001j3.inc"
	.include "stm8l001j3_vec.asm" 
	.include "hardware_init.asm"
	.include "xor32.asm"



