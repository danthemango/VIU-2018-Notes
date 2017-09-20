;============================================-=
; File:
       .file "add2.s" 
; Behaviour: 
;     From midterm 2005 ... provided without comments
;     Note... I used add2 as my starting point hence the filename add2.s
; Assumptions:
; Board:
;      CME11-E9-EVBU
; Author/Date:
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

_start: 
          lds #_stack    ; initialize SP
strt:
          ldaa #3
          psha 
          ldaa #3
          psha 
          jsr add2s      ; call add2s
          ins            ; caller cleans the stack
          ins 
          swi            ; use swi for gdb and buffalo


;---------------------------------------------
; Behaviour: 
;     see specification from midterm
; Assumptions:
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroyes:
;---------------------------------------------
add2s:    pshx 
          tsx
          ldaa 4,x
          adda 5,x
          pulx
xadd2s:   rts


;----------------------------------------------
;            Data (in Text section)
;----------------------------------------------

.end
