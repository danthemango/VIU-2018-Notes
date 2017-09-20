;============================================-=
; File:
       .file "main.s" 
; Behaviour: 
;      main function to test iolib.s
; Assumptions:
;      STR is the address of the start of a string.
;      The string under test can be a maximum of 30 characters including
;      the terminator. 
; Board:
;      CME11-E9-EVBU (with the PW link HACK)
; Author:
;      Peter Walsh
;============================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text
.global _start
.global _.frame

;---------------------------------------------
; Behaviour: 
;    Returns the address of STR.
;    This subroutine is for testing only (used by cew testbench) 
; Assumptions:
;    none
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      none
;    Postcondition:
;      accd contains the returned value 
;    Destroyed:
;      ccr
;---------------------------------------------
malloc:        ldd #STR
xmalloc:               rts

_start:
               lds #_stack    ; initialize SP
               jsr malloc
               
smc:           
               swi            ; return control to debugger



;----------------------------------------------
;            Data Section
;----------------------------------------------
STR: .asciz "01233210" ; reserves a total of 30 bytes (8 +1 (\n) +21)
.space 21, 1

;----------------------------------------------
;            Soft Registers
;----------------------------------------------
.sect softregs
_.frame: .word 0x1234

.end
