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
; Assumptions:
; Restriction:
; Register and Memory Usage:
;---------------------------------------------
_start: 
               lds #_stack    ; initialize SP
               ldaa #0x7e
               staa 0x00e2
               ldx #icLight
               xgdx
               std 0x00e3

               ldaa #0x01
               staa 0x1021 ; TCTL2

               ldaa #0x01
               staa 0x1022 ; TMSK1
               
               ldaa #0x01   ; TFLG1
               staa 0x1023

               cli
loop:	       jmp loop

icLight:
               ldaa #0x40 
               staa 0x1000

               ldaa #0x01   ; TFLG1
               staa 0x1023

xicLight:     rti

;-----------------------------------------
;         Data Area

;-----------------------------------------

.end
