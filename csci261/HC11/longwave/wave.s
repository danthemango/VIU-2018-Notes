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
set toc2, 0x18
set tctl1, 0x20
set tmsk1, 0x22
set tflg1, 0x23

set highTicks, 600             ; 300 us
set lowTicks, 1400             ; 700 us

set toggle, 0x40
set oc2, 0x40
set clear, 0x40
set set, 0x40

set jmpOpcode, 0x7e
set toc2JT, 0xdc                 ; toc2 jump table address

 ; useful subroutines
set OUTA, 0xffb8
set OUT1BSP, 0xffbe
set OUT2BSP, 0xffc1
set OUTCRLF, 0xffc4

_start: 

         cli

         ldx #regbase              

         bset porta,x oc2        ; set OC2 pin to high (PA6)     

         ldy #toc2JT             ; put "jmp wInterrupt" in the jump table for OC2
         ldaa #jmpOpcode
         staa 0,y
         ldd #wInterrupt
         std 1,y

         ldaa #toggle            ; set successful compare action to toggle (pp 365)    
         staa tctl1,x          
    
         ldd tcnt,x              ; toggle OC2 pin after 300 us
         addd #highTicks
         std toc2,x

         ldaa #oc2               ; clear OC2F (pp 348)
         staa tflg1,x
         ldaa #oc2               ; set OC2I (mask)
         oraa tmsk1,x
         staa tmsk1,x

         ldaa #0x1
         staa isHigh


loop:    
         jmp loop                ; endless loop

end:     
         swi

wInterrupt: ; the wave interrupt:
         ldaa isHigh ; if(isHigh) goto setLow 
         cmpa #0x1
         beq setLow

setHigh:
         ldaa #0x1
         staa isHigh

         ldx #regbase            ; toggle OC2 pin after 300 us
         ldd tcnt,x
         std toc2,x
         jmp afterSet

setLow: ;set the timing to low
         ldaa #0x0
         staa isHigh

         ldx #regbase
         ldd tcnt,x              ; toggle OC2 pin after 700 um
         std toc2,x

afterSet: 
         ldaa #clear             ; clear OC2F (pp 348)
         staa tflg1,x

         rti

isHigh: .byte 0x0 ; is 1 if the previous jump was set high, 0 otherwise

.end
