
;-------------------------
; CharliePlexing demo 
; MCU: STM8L001J3 
;-------------------------

    .include "config.inc"
 
demo:
; set pins 5,6 as output push pull 
; PB5,PB6
    ld a, #(1<<5)|(1<<6)
    ld PB+GPIO_DDR,a  ; output mode 
    ld PB+GPIO_CR1,a  ; push pull output 
; set pin 1,2 as output push pull
; PA0,PA2 
; PA0 used as common for the 3 LEDs 
    ld a,#(1<<0)|(1<<2)
    ld PA+GPIO_DDR,a ; output mode      
    ld PA+GPIO_CR1,a ; push pull output 
    bset PA+GPIO_ODR,#0 ; output high 
    callr leds_off ; 3 LEDs off

1$: ; cycle 3 LEDs 
    bres PA+GPIO_ODR,#2 ; PA2 low LED1 on 
    callr delay 
    bset PA+GPIO_ODR,#2 ; PA2 high, LED1 off 
    bres PB+GPIO_ODR,#6  ; PB6 low , LED2 on 
    callr delay 
    bset PB+GPIO_ODR,#6 ; PB6 high, LED2 off 
    bres PB+GPIO_ODR,#5 ; PB5 low , LED3 on 
    callr delay 
    call leds_off  
    jra 1$ 
    ret 

leds_off: 
    bset PA+GPIO_ODR,#2 ; output low  
    bset PB+GPIO_ODR,#5 ; output low 
    bset PB+GPIO_ODR,#6 ; output low 
    ret 

delay:
    ld a,#15
    clrw x 
1$: 
    decw x 
    jrne 1$ 
    dec a 
    jrne 1$
    ret 
