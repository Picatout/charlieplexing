;;
; Copyright Jacques Deschênes 2025,2026  
; This file is part of animation-demo.asm  
;
;     animation-demo.asm is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     animation-demo.asm is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with animation-demo.asm.  If not, see <http://www.gnu.org/licenses/>.
;;

;-------------------------
; CharliePlexing demo 
; MCU: STM8L001J3 
;-------------------------

    .include "config.inc"
 ;-----------------------
 ; commands constants
 ;-----------------------
 CPY=0  ; copy bit set 
 INC=1  ; copy bit set and increment anim_step
 DEC=2  ; copy bit set and decrement anim_step 
 RST=3  ; reset anim_step to 0 
 SPD=4  ; set animation delay 
 RND=7  ; random bit set 
 INV_BIT=(1<<15) ; invert bit set before copying 

;------------------------------------
; animation client for charlieplexr 
;-------------------------------------
animation:
;initialize with first animation 
    ldw x,#swing 
    ldw anim_table,x
    ld a,(1,x)
    ld anim_delay,a
1$:
; check for button down 
    btjf flags,#F_BTN1,2$
    call next_anim 
    jra 3$  
2$: btjf flags,#F_BTN2,4$
    call prev_anim 
3$: ; wait button release 
    ld a,#3 
    and a,flags 
    jrne 3$
4$:     
    clrw x 
    ld a,anim_step 
    ld xl,a 
    sllw x 
    addw x,anim_table 
    ldw x,(x)
    ld a,xh 
    swap a 
    and a,#0x7 ; command  
    cp a,#CPY 
    jreq 5$ ; copy_set
    cp a,#INC 
    jreq 6$ ; inc_step
    cp a,#DEC 
    jreq 7$ ;dec_step 
    cp a,#RST
    jreq 8$ ;reset_step
    cp a,#SPD 
    jreq 9$ ;set_speed
    cp a,#RND 
    jreq 10$ ;random_set 
    jra 12$ ; bad command ignored 
5$: ; copy_set
    tnzw x 
    jrpl 52$
    cplw x 
52$:
    ld a,xh 
    and a,#0xF
    ld xh,a 
    ldw led_set,x 
    jra 12$
6$: ;inc_step
    inc anim_step 
    jra 5$ 
7$: ;dec_step
    dec anim_step 
    jra 5$ 
8$: ;reset_step
    clr anim_step 
    jra 1$
9$: ;set_speed
    ld a,xl 
    ld anim_delay,a 
    inc anim_step 
    jra 1$ 
10$: ;random_set
    call lfsr
    ldw led_set,x 
12$: ; animation delay 
    ld a,anim_delay 
    call pause 
    jra 1$
    ret 

;-----------------------
; select next animation 
; in anim_list  
;-----------------------
next_anim:
    call leds_off 
    clr led_set ; disable actual animation 
    inc anim_select
    ld a, anim_select
    clrw x 
    ld xl,a 
    sllw x 
    addw x,#anim_list 
    ldw x,(x)
    jrne new_anim  
    dec anim_select 
9$:  
    ret 

;--------------------------
; select previous animation 
; in anim_list 
;--------------------------
prev_anim:
    call leds_off 
    clr led_set ; disable actual animation 
    tnz anim_select 
    jreq list_top 
    dec anim_select
    ld a, anim_select
    clrw x 
    ld xl,a 
    sllw x 
    addw x,#anim_list 
    ldw x,(x)
new_anim:
    ldw anim_table,x 
    clr mx_step
    clr anim_step  
list_top:  
    ret 

;------------------------
; list of animations 
; selected by btn1 & btn2 
;------------------------
anim_list:
.word  swing  
.word  random  
.word  double_sweep   
.word  clockwise
.word  fill  
.word  butterfly 
.word  0 

;--------------------------------------------------
;  structure of animation table 
;  bits 0..11 led_set 
;  bits 12..15 command 
;  COMMANDS:
;    0    copy bits 0..11 to variable led_set
;    1    copy bits 0..11 to variable led_set and increment anim_step 
;    2    copy bits 0..11 to variable led_set and decrement anim_step
;    3    reset animation to step 0 
;    4    set pause delay, bits 0..7 -> anim_delay 
;    5    reserved 
;    6    reserved  
;    7    copy a random value to variable led_set  
;    if bit 3 of command is set then led_set is inverted
;-------------------------------------------------- 

; random animation
; LEDs selected at random  
random: 
.word 0x4020
.word 0x7000


; double sweep animation 
; 2 LEDS going in opposite direction
double_sweep:
.word 0x4005
.word  0x1801
.word  0x1402 
.word  0x1204 
.word  0x1108
.word  0x1090 
.word  0x1060 
.word  0x1090
.word  0x1108 
.word  0x1204 
.word  0x1402
.word  0x1801+INV_BIT
.word  0x1402+INV_BIT 
.word  0x1204+INV_BIT 
.word  0x1108+INV_BIT
.word  0x1090+INV_BIT 
.word  0x1060+INV_BIT 
.word  0x1090+INV_BIT
.word  0x1108+INV_BIT 
.word  0x1204+INV_BIT 
.word  0x1402+INV_BIT
.word  0x3000 ; loop back  

;------------------------
; 1 LED running clockwise 
;------------------------
clockwise:
 .word 0x4005
 .word 0x1001
 .word 0x1002
 .word 0x1004
 .word 0x1008
 .word 0x1010
 .word 0x1020
 .word 0x1040
 .word 0x1080
 .word 0x1100
 .word 0x1200
 .word 0x1400
 .word 0x1800
 .word 0x3000 ; loop back 

;---------------------------
; both side expand and close 
;---------------------------
butterfly:
 .word 0x4010
 .word 0x1104
 .word 0x138E
 .word 0x17DF
 .word 0x1FFF
 .word 0x138E
 .word 0x3000  ; loop back 

;----------------------------
; fill
;----------------------------
fill:
 .word 0x4010
 .word 0x1020
 .word 0x1070
 .word 0x10F0
 .word 0x11F8
 .word 0x13FC 
 .word 0x17FE 
 .word 0x1FFF
 .word 0x17FE
 .word 0x13FC 
 .word 0x11F8
 .word 0x10F0 
 .word 0x1070
 .word 0x1020
 .word 0x1000
 .word 0x3000 ; loop back 

;----------------------------
; swing 
; like a pandulum 
;---------------------------
swing:
 .word 0x4015  
 .word 0x1001  ; 1
 .word 0x4010
 .word 0x1002  ; 2
 .word 0x4008
 .word 0x1004  ; 3
 .word 0x4004
 .word 0x1008  ; 4 
 .word 0x4002
 .word 0x1010  ; 5 
 .word 0x1020  ; 6
 .word 0x4004 
 .word 0x1040  ; 7 
 .word 0x4008  
 .word 0x1080  ; 8 
 .word 0x4010  
 .word 0x1100  ; 9 
 .word 0x4015  
 .word 0x1200  ; 10 
 .word 0x4015   
 .word 0x1400  ; 11 
 .word 0x4015  
 .word 0x1800  ; 12 
 .word 0x1400  ; 11 
 .word 0x4015  
 .word 0x1200  ;10 
 .word 0x4010   
 .word 0x1100  ; 9
 .word 0x4008   
 .word 0x1080  ; 8  
 .word 0x4004  
 .word 0x1040  ; 7 
 .word 0x4004  
 .word 0x1020  ; 6
 .word 0x4004  
 .word 0x1010  ; 5
 .word 0x4008   
 .word 0x1008  ; 4 
 .word 0x4010  
 .word 0x1004  ; 3 
 .word 0x4015  
 .word 0x1002  ; 2 
 .word 0x3000  ; loop back 
