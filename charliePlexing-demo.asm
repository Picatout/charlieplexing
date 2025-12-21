
;-------------------------
; metronome 
; MCU: STM8L001J3 
;-------------------------

    .include "config.inc"
 
    XSAVE=1
    REPCNT=3
    VAR_SIZE=3
metronome:
    _vars VAR_SIZE 
    call oled_init 
    call display_clear 
    ld a,#BIG 
    call select_font
    ldw y,#prompt 
    call put_string 
;-------------------
; test values 
;-------------------
    ldw x,#180 
    ldw bpm,x 
;--------------------
    call display 
    jra .  
.if 0 
; read switch and display loop 
1$: ld a,#3 
    ld (REPCNT,sp),a 
    call read_mcp9701 
    ld a,#VREF10 ; 3.3*10 ref. voltage 
    call mul16x8
    ldw y,#1024 
    divw x,y
2$:
    ld a,#10
    call mul16x8  
    ldw (XSAVE,sp),x
    dec (REPCNT,sp)
    jreq 4$    
    ldw x,y
    ld a,#10 
    call mul16x8  
    ldw y,#1024 
    divw x,y
    addw x,(XSAVE,sp)
    jra 2$ 
4$:  
    ldw x,(XSAVE,sp)
    subw x,#ZERO_OFS*10      
    ld a,#SLOPE10 
    div x,a
    sllw y 
    cpw y,#SLOPE10 
    jrmi 5$
    incw x
5$:
MEGA_FONT=0
.if MEGA_FONT
    call itoa
    ldw x,#0x304
    call put_mega_string
    ldw y,#celcius 
    ldw x,#0x0334
    call put_mega_string  
.else 
    pushw x  
    call itoa
    ld a,#2 
    _straz line
    ld a,#2 
    _straz col  
    call put_string 
    ldw y,#celcius 
    call put_string 
    popw x 
    ld a,#9
    mul x,a 
    ld a,#5 
    div x,a 
    addw x,#32
    call itoa 
    ld a,#3 
    _straz line
    ld a,#2 
    _straz col  
    call put_string 
    ldw y,#fahrenheit
    call put_string 
.endif 
    ld a,#50 
    call pause 
    jp 1$  
.endif 

;-------------------------
; display repetions 
; high intensity duration 
; low intensiti duration 
;-------------------------
display:
    ldw y,#bpm_str 
    call put_string
    clrw x 
    ldw x,bpm 
    ld a,#0  
    call put_int  
    ret 

;------------------------
; input:
;    x   
;    a 
; output:
;    X   X*A 
;------------------------
mul16x8:
    _strxz acc16 
    mul x,a 
    pushw x 
    _ldxz acc16 
    swapw x 
    mul x,a 
    clr a 
    rlwa x 
    addw x,(1,sp)
    _drop 2 
    ret 

prompt: .asciz "metronome\n"
bpm_str: .asciz  "\nBMP: "

