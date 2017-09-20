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

set numCount, 0xffff ; number of times we are going to let the count exceed
set highTicks, 60000            
set lowTicks, 60000            

set toggle, 0x40
set oc2, 0x40
set clear, 0x40

set OUTA, 0xffb8

_start:               
        ldd #numCount
        std count
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
        
        pshx
        ldx count     ; decrement count
        dex
        stx count
        pulx

        bne high     ; only escape when count is 0

        pshx         ; set count to the max
        ldx #0xffff
        stx count
        pulx

        ldd #numCount

        ldd toc2,x             ; toggle OC2 pin after 600 um
        addd #lowTicks
        std toc2,x

        ldaa #clear            ; clear OC2F (pp 348)
        staa tflg1,x

        ldaa #'a' ; print a
        jsr OUTA

low:    brclr tflg1,x oc2 low  ; loop until OC2 flag is set

        ldaa #clear            ; clear OC2F (pp 348)
        staa tflg1,x          

        ldd toc2,x             ; toggle OC2 pin after 400us
        addd #highTicks
        std toc2,x

        bra high

        swi                    

count:   .word numCount
tmp:     .word 0x0000

.end

