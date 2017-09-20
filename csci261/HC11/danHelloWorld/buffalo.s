;============================================-=
; File:
       .file "buffalo.s" 
; Behaviour: 
;      Prints Hello World and waits for the user to enter a character
;      before terminating.
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU 
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

   ldx #PROMPT
   jsr OUTSTRGO
   jsr INCHAR
   swi

;----------------------------------------------
;            Data (in Text section)
;----------------------------------------------
PROMPT: .asciz "Hello World (press any key to continue)"

.end
