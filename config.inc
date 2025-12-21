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

	I2C_PORT=PC

	SCL_BIT=1  ;pin 8 
	SDA_BIT=0  ;pin 7

; buttons ports 
	BTN_PORT = PB
	BTN_UP = 6 
	BTN_DOWN = 3 
	 
; ss1306 device ID 
	OLED_DEVID = 0x78 

	.include "../../inc/ascii.inc"
	.include "../../inc/gen_macros.inc" 
	.include "../../inc/stm8l001j3.inc"
	.include "stm8l001j3_vec.asm" 
	.include "hardware_init.asm"
	.include "../../i2c.asm"
	.include "../../oled_128_64.asm"
	.include "../../oled-font.asm"
	.include "../../display.asm"




