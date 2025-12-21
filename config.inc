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
	F_DELAY=0 
	F_STATE=1 ; 0 = low, 1 = high intensity 

; buttons ports 
	BTN_PORT = PA
	BTN_PIN = 2  
	 
	.include "inc/gen_macros.inc" 
	.include "inc/stm8l001j3.inc"
	.include "stm8l001j3_vec.asm" 
	.include "hardware_init.asm"




