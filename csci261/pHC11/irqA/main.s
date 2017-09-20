;============================================-=
; File:
       .file "main.s" 
; Behaviour: 
;      Store in COUNT the  number of IRQs interrupts generated.
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU (with the PW link HACK)
; Author:
;      Peter Walsh
;============================================-=

;----------------------------------------------
;            Text Section (code)
;----------------------------------------------
.sect .text
.global _start

;---------------------------------------------
; Behaviour: 
;    Interrupt Service Routine
;    Store in COUNT the number of times this routine is invoked.
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;       COUNT is incremented by 1
;    Destroys:
;       none
;---------------------------------------------
irqCount:
               ldaa COUNT
               inca
               staa COUNT
xirqCount:     rti

_start: 
               lds #_stack    ; initialize SP

               cli
loop:	       jmp loop
;-----------------------------------------
;         Data Area

;-----------------------------------------
COUNT: .byte  0

.end
