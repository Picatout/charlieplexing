
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
 INV_BIT=(1<<15)

;------------------------------------
; The 12 LEDs are scanned in sequence
; button up scan at LOW speed 
; button down scan at fast speed (POV)
; and because of persistance of vision 
; appears to be all on at same time.
;-------------------------------------
animation:
;initialize with first animation 
    ldw x,#random 
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
    jra 5$
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
.word  random  
.word  double_sweep   
.word  clockwise 
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
;    3    copy bits 0..11 to variable led_set and reset anim_step 
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
.word  0x3402+INV_BIT

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
 .word 0x3800

;---------------------------
; both side expand and close 
;---------------------------
butterfly:
 .word 0x4010
 .word 0x1104
 .word 0x138E
 .word 0x17DF
 .word 0x1FFF
 .word 0x338E

