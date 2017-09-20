;============================================-=
; File:
       .file "bHelloWorld.s" 
; Behaviour: 
;      Prints Hello World and waits for the user to enter a character
;      before terminating.
; Assumptions:
;      Availability of Buffalo monitor's I/O routines
; Board:
;      CME11-E9-EVBU (with PW linker hack)
; Author/Date:
;      Peter Walsh Mar 2003
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

set OUTSTRGO, 0xffca
set INCHAR, 0xffcd
set eot, 0x4

_start:
   lds #_stack     ; init. SP
   ldx #PROMPT     ; get starting address of prompt
   jsr OUTSTRGO    ; write Hello World
   jsr INCHAR      ; wait for the user to type a char
   swi

;----------------------------------------------
;            Data (in Text section)
;----------------------------------------------
PROMPT: .asciz "Hello World (press any key to continue)"
.byte eot

.end
