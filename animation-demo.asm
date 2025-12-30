
;-------------------------
; CharliePlexing demo 
; MCU: STM8L001J3 
;-------------------------

    .include "config.inc"
 
;------------------------------------
; The 12 LEDs are scanned in sequence
; button up scan at LOW speed 
; button down scan at fast speed (POV)
; and because of persistance of vision 
; appears to be all on at same time.
;-------------------------------------
animation:
1$:
    ld a,#255
    push a
2$:

    jra 2$ 
    ret 

