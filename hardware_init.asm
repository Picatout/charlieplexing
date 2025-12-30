;;
; Copyright Jacques Deschênes 2025  
; This file is part of CharliePlexing-demo.asm  
;
;     CharliePlexing-demo.asm is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     CharliePlexing-demo.asm is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with CharliePlexing-demo.asm.  If not, see <http://www.gnu.org/licenses/>.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialisation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

    .module HW_INIT 


STACK_SIZE=128
STACK_EMPTY=RAM_SIZE-1 
DISPLAY_BUFFER_SIZE=128 ; horz pixels   

;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_END - STACK_SIZE - 1
free_ram_end: 
stack_full: .ds STACK_SIZE   ; control stack 
stack_unf: ; stack underflow ; control_stack bottom 


;--------------------------------------
    .area DATA (ABS)
	.org 8 
;--------------------------------------	

msec: .blkw 1 ; milliseconds counter  
mx_step: .blkb 1 ; multiplexer step 
anim_delay: .blkb 1 ; animation speed delay, multiple of 12 msec 
anim_timer: .blkb 1 ; animation cowntdown timer, mulitple of 12 msec  
anim_step: .blkb 1 ; animation table step  
anim_addr: .blkw 1 ; animation table address
flags:: .blkb 1 ; various boolean flags
seedx: .blkw 1  ; xorshift 16 seed x  used by RND() function 
seedy: .blkw 1  ; xorshift 16 seed y  used by RND() function

	.org 0x100

free_ram: ; from here RAM free up to free_ram_end 


	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	iret 

;------------------------------
; TIMER 4 is used to maintain 
; timers and ticks 
; interrupt interval is 1 msec 
;--------------------------------
Timer4UpdateHandler:
	clr TIM4_SR
	ldw x, msec 
	incw x 
	ldw msec, x 
; multiplexer control 	
	call leds_off 
	ld a,mx_step 
	inc a
	cp a,#12
	jrmi 1$ 
	clr a
; animation control 
; check if animation is active 	
	btjf flags,#F_ANIM,1$
; decrement anim_timer
	dec anim_timer
	jrne 1$ 
	bres flags, #F_ANIM  
1$: ld mx_step, a 
	clrw x 
	ld a,anim_step 
	ld xl,a
	sllw x  
	addw x,anim_addr
	ldw x,(x)
    ld a, mx_step 
	tnz a 
	jreq 3$ 
2$:	srlw x 
	dec a 
	jrne 2$
3$: srLw x 
	jrnc 9$ 
	ld a,mx_step 
	call led_on 
9$:
	iret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    peripherals initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;----------------------------------------
; inialize MCU clock 
; HSI no divisor 
; FMSTR=16Mhz 
;----------------------------------------
clock_init:	
	clr CLK_CKDIVR 
	ret

;---------------------------------
; TIM4 is configured to generate an 
; interrupt every 1.66 millisecond 
;----------------------------------
timer4_init:
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
	bres TIM4_CR1,#TIM4_CR1_CEN 
	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
	bset TIM4_IER,#TIM4_IER_UIE
	ret

;------------------------
; suspend execution 
; input:
;   a    pause in multiple of 12 msec  
;-------------------------
pause:
	ld anim_timer,a  
	bset flags,#F_ANIM  
1$: wfi 	
	btjt flags,#F_ANIM,1$ 
	ret 



;-------------------------------------
;  initialization entry point 
;-------------------------------------
cold_start:
;set stack 
	ldw y,0 ; for seedy 
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
    call clock_init 
;-------------------------------
; SWIM DELAY
; give time for MCU programming 
; about 4 seconds at 16MHZ Fmstr  
;-------------------------------
    ld a,#0
1$: ldw x,#0xffff 
2$: decw x 
    jrne 2$ 
    dec a 
    jrne 1$ 
;----------------------    
	call timer4_init ; msec ticks timer 
	rim ; enable interrupts
	ldw x, msec  
	call set_seed 
	ldw x,#msec 
	ldw anim_addr,x 
jra . 	 
	jp animation  


;--------------------------------
; all LEDs off 
;--------------------------------
leds_off: 
    clr PA+GPIO_DDR ; input mode 
    clr PA+GPIO_CR1 ; no pull up  
    clr PB+GPIO_DDR ; input mode 
    clr PB+GPIO_CR1 ; no pull up 
    ret 

;-------------------------------
; set LED on 
; input:  A LED number {0..11}
;-------------------------------
led_on:
    ld xl,a 
    ld a,#6 
    mul x,a 
    addw x,#leds_table  
    ldw y,x ; table entry address 
    ldw x,(x) ; anode port address
; set anode as output push pull 
    ld a,(4,y) ; get anode bit mask 
    or a,(GPIO_CR1,X)
    ld (GPIO_CR1,X),a  ; push pull 
    ld (GPIO_DDR,X),a  ; output mode 
    ld (GPIO_ODR,x),a  ; anode output high 
; set cathode output pseudo open drain 
    addw y,#2 ; table cathode port address field  
    ldw x,y 
    ldw x,(x) ; cathode port address 
    ld a,(3,y) ; cathode bit mask
    or a,(GPIO_DDR,X) 
    ld (GPIO_DDR,X),a ; output mode 
    ld a,(3,y)
    cpl a 
    and a, (GPIO_ODR,X)
    ld (GPIO_ODR,X),a ; output low 
    ret 


;---------------------------------------------------
; LED pinout table 
; anode port, cathode port 
; anode bit_mask ->| cathode bit_mask  
;---------------------------------------------------
leds_table:
; LED 0  PA2 ->| PA0
.WORD  PA,PA ; anode port, cathode port  
.BYTE  (1<<2),(1<<0)  ; anode bit_mask, cathode bit_mask  
; LED 1  PA2 ->| PB6
.WORD PA,PB 
.BYTE (1<<2),(1<<6) ;  
;LED 2  PA2 ->| PB5
.WORD PA,PB  
.BYTE (1<<2),(1<<5) ;  
; LED 3  PA0 ->| PA2  
.WORD PA,PA 
.BYTE (1<<0),(1<<2) ; 
; LED 4  PA0 ->| PB6 
.WORD PA,PB 
.BYTE (1<<0),(1<<6) 
; LED 5  PA0 ->| PB5 
.WORD PA,PB 
.BYTE (1<<0),(1<<5) ; 
; LED 6   PB6  ->| PA2
.WORD PB,PA 
.BYTE (1<<6),(1<<2)
; LED 7  PB6 ->| PA0 
.WORD PB,PA 
.BYTE (1<<6),(1<<0)
; LED 8   PB6 ->| PB5 
.WORD PB,PB  
.BYTE (1<<6),(1<<5)
; LED 9  PB5 ->| PA2 
.WORD PB,PA 
.BYTE (1<<5),(1<<2)
; LED 10  PB5 ->| PA 0 
.WORD PB,PA  
.BYTE (1<<5),(1<<0)
; LED 11   PB5 ->| PB6 
.WORD PB,PB 
.BYTE (1<<5),(1<<6)



