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
; Modified by:
;      Daniel Guenther on 2016-03-10
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
               jsr setIRQ
               lds #_stack    ; initialize SP

               cli
loop:	         jmp loop

;---------------------------------------------
; Behaviour: 
;   IRQ setter
;   specifies where to jump to when IRQ detected
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;        none
;    Postcondition:
;        IRQ interrupts will jump to a subroutine (hardcoded)
;    Destroys:
;        I don't know, good luck
;---------------------------------------------

set jmpAddress, irqCount            ; address we want to jump to
set jmpOpcode, 0x7e                 ; the jmp opcode
   ; note: the following addresses are specific to the Buffalo Monitor
set jmpCommandPosition, 0xee        ; position where we need a jump command
set IRQjmpAddress, 0xef             ; where we want to put the address 

setIRQ:   
               psha                 ; save the D register
               pshb

               ldab #jmpOpcode      ; put the 'jmp' command in the jump table spot for IRQ
               stab jmpCommandPosition
               ldd #jmpAddress      ; put the address of our IRQ subrountine in the jump table
               std IRQjmpAddress

               pulb                 ; restore the D register
               pula
               rts

;-----------------------------------------
;         Data Area
;-----------------------------------------
COUNT: .byte  0

#set up dummy frame pointer
.global _.frame
_.frame: .word

.end
