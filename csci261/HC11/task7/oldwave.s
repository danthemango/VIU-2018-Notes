;============================================-=
; File:
       .file "wave.s" 
; Behaviour: 
; a HC11 assembly language program that produces a 30% duty cycle
; square wave on PA6, using interrupts
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2002
;      Modified by Daniel Guenther on 2016-03-11
;        to make the wave functions run as interrupts
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

set regbase, 0x1000
set porta, 0x0
set tcnt, 0x0e
set tctl1, 0x20
set tmsk1, 0x22
set tflg1, 0x23
set toc2, 0x18

set highTicks, 600             ; 300 us
set lowTicks, 1400             ; 700 us

set toggle, 0x40
set oc2, 0x40
set clear, 0x40
set set, 0x40

set jmpOpcode, 0x7e
set toc2JT, 0xde                 ; toc2 jump table address
set OUTA, 0xffb8

_start: 
         ldx #regbase              

         bset porta,x oc2        ; set OC2 pin to high (PA6)     

         ldy #toc2JT             ; put "jmp high" in the jump table for OC2
         ldaa #jmpOpcode
         staa 0,y
         ldd #high
         std 1,y

         ldaa #toggle            ; set successful compare action to toggle (pp 365)    
         staa tctl1,x          
    
         ldd tcnt,x              ; toggle OC2 pin after 400 us
         addd #highTicks
         std toc2,x

         ldaa #oc2               ; set OC2I (mask)
         oraa tmsk1,x
         staa tmsk1,x
         ldaa #oc2               ; clear OC2F (pp 348)
         staa tflg1,x

         ldaa #'a'
         jsr OUTA

loop:    jmp loop                ; endless loop


high:    
         ldd toc2,x              ; toggle OC2 pin after 600 um
         addd #lowTicks
         std toc2,x
         
         ;ldy #toc2JT             ; put "jmp low" in the jump table for OC2
         ldaa #jmpOpcode
         staa 0,y
         ldd #low
         std 1,y

         ldaa #clear             ; clear OC2F (pp 348)
         staa tflg1,x

         ldaa #'a'
         jsr OUTA

         rti

low:     
         ldd toc2,x              ; toggle OC2 pin after 400us
         addd #highTicks
         std toc2,x

         ldaa #clear             ; clear OC2F (pp 348)
         staa tflg1,x          
         
         ;ldy #toc2JT             ; put "jmp high" in the jump table for OC2
         ldaa #jmpOpcode
         staa 0,y
         ldd #high
         std 1,y

         ldaa #'a'
         jsr OUTA

         rti

.end
