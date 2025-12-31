
;-------------------------
; CharliePlexing demo 
; MCU: STM8L001J3 
;-------------------------

    .include "config.inc"
 ;-----------------------
 ; commands constants
 ;-----------------------
 CPY=0
 INC=1
 DEC=2
 RST=3
 SPD=4 
 RND=7 

;------------------------------------
; The 12 LEDs are scanned in sequence
; button up scan at LOW speed 
; button down scan at fast speed (POV)
; and because of persistance of vision 
; appears to be all on at same time.
;-------------------------------------
animation:
    ldw x,#random
    ldw anim_table,x
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
    ld a,anim_select 
    ld xl,a 
    sllw x 
    addw x,anim_table 
    ldw x,(x)
    ld a,xh 
    swap a 
    and a,#0xF ; command  
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
    ld a,xh 
    and a,#0xF
    ld xh,a 
    ldw led_set,x 
    jra 1$
6$: ;inc_step
    inc anim_step 
    jra 5$ 
7$: ;dec_step
    dec anim_step 
    jra 5$ 
8$: ;reset_step
    clr anim_step 
    jra 5$
9$: ;set_speed
    ld a,xl 
    ld anim_delay,a 
    inc anim_step 
    jra 1$ 
10$: ;random_set
    call lfsr
    ldw led_set,x 
    jra 1$ 
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
    ldw anim_select,x 
    clr mx_step
    clr anim_step  
list_top:  
    ret 

;------------------------
; list of animations 
; selected by btn1 & btn2 
;------------------------
anim_list: 
.word  random  
.word  double_sweep   
.word  0 

;--------------------------------------------------
;  structure of animation table 
;  bits 0..11 led_set 
;  bits 12..15 command 
;  COMMANDS:
;    0    copy bits 0..11 to variable led_set
;    1    copy bits 0..11 to variable led_set and increment anim_step 
;    2    copy bits 0..11 to variable led_set and decrement anim_step
;    3    copy bits 0..11 to variable led_set and reset anim_step 
;    4    set pause delay, bits 0..7 -> anim_delay 
;    5    reserved
;    6    reserved  
;    7    copy a random value to variable led_set  
;    8..15   reserved 
;-------------------------------------------------- 

; random animation
; LEDs selected at random  
random: 
.word 0x4053
.word 0x70000


; double sweep animation 
; 2 LEDS going in opposite direction
double_sweep:
.word 0x4030
.word  0x1801
.word  0x1402 
.word  0x1204 
.word  0x1108
.word  0x1090 
.word  0x1060 
.word  0x1090
.word  0x1108 
.word  0x1204 
.word  0x3402



