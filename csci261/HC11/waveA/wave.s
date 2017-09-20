;============================================-=
; File:
       .file "wave.s" 
; Behaviour: 
;      Generates a 1KHz square wave with a 40% duty cycle
;      using polling   (see text page 366)
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2002
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

set regbase, 0x1000
set porta, 0x0
set tcnt, 0x0e
set tflg1, 0x23
set tctl1, 0x20
set toc2, 0x18

set highTicks, 800             ; 400 us
set lowTicks, 1200             ; 600 us

set toggle, 0x40
set oc2, 0x40
set clear, 0x40

_start:               
        ldx #regbase           

        bset porta,x oc2       ; set OC2 pin to high (PA6)     

        ldaa #toggle           ; set successful compare action to toggle (pp 365)    
        staa tctl1,x          
    
        ldd tcnt,x             ; toggle OC2 pin after 400 us
        addd #highTicks
        std toc2,x

        ldaa #clear            ; clear OC2F (pp 348)
        staa tflg1,x

high:   brclr tflg1,x oc2 high ; loop until OC2F is set

        ldd toc2,x             ; toggle OC2 pin after 600 um
        addd #lowTicks
        std toc2,x

        ldaa #clear            ; clear OC2F (pp 348)
        staa tflg1,x

low:    brclr tflg1,x oc2 low  ; loop until OC2 flag is set

        ldaa #clear            ; clear OC2F (pp 348)
        staa tflg1,x          

        ldd toc2,x             ; toggle OC2 pin after 400us
        addd #highTicks
        std toc2,x

        bra high

        swi                    

.end
