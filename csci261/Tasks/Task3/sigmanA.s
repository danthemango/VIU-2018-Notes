;============================================-=
; File:
       .file "sigman.s" 
; Behaviour: 
;      Calculate sigma N and store the
;      result in SUM
; Assumptions:
;      N is a program constant >= 0
; Board:
;      CME11-E9-EVBU 
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2002
;
;      modified by Daniel Guenther
;      CSCI261, Section 2
;      Task 4.a
;      2016-02-11
;============================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text
.global _start

_start: 
      clra           ; clear acca
      ldab #N        ; load accb with the value of N
loop:
      beq end
      aba            ; acca:= acca + accb
      decb           ; decrement accb
      bne loop       ; if accb != 0 then goto loop
end:  staa SUM       ; store acca in memory referenced by SUM 
      stop

;----------------------------------------------
;            Data Section
;----------------------------------------------
set N, 4
SUM: .byte 0

.end
