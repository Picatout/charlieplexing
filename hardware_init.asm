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

ticks: .blkw 1 ; 1.664 milliseconds ticks counter (see Timer4UpdateHandler)
delay_timer: .blkb 1 ; 60 hertz timer   
acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
flags:: .blkb 1 ; various boolean flags

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
; interrupt interval is 1.664 msec 
;--------------------------------
Timer4UpdateHandler:
	clr TIM4_SR 
	_ldxz ticks
	incw x 
	_strxz ticks
; decrement delay_timer on ticks mod 10==0
	ld a,#10
	div x,a 
	tnz a
	jrne 9$
1$:	 
	btjf flags,#F_DELAY,9$  
	dec delay_timer 
	jrne 9$ 
	bres flags,#F_DELAY   
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
;   A     n/60 seconds  
;-------------------------
pause:
	_straz delay_timer 
	bset flags,#F_DELAY 
1$: wfi 	
	btjt flags,#F_DELAY,1$ 
	ret 


beep:

    ret 
    
;-------------------------------------
;  initialization entry point 
;-------------------------------------
cold_start:
;set stack 
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
    call clock_init 
;----------------------
; SWIM DELAY  
;----------------------
    ld a,#0
1$: ldw x,#0xffff 
2$: decw x 
    jrne 2$ 
    dec a 
    jrne 1$ 
;----------------------    
	call timer4_init ; msec ticks timer 
;	rim ; enable interrupts
	jp demo 






