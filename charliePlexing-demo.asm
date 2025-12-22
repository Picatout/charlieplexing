
;-------------------------
; CharliePlexing demo 
; MCU: STM8L001J3 
;-------------------------

    .include "config.inc"
 

demo:
    ld a,#255
    push a  
0$:
    callr leds_off 
    pop a 
    inc a 
    cp a,#12 
    jreq demo 
    push a 
    callr led_on 
    callr delay 
    jra 0$ 
    ret 

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


delay:
    ld a,#100
    clrw x 
1$: 
    decw x 
    jrne 1$ 
    dec a 
    jrne 1$
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
