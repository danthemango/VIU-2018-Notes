;============================================-=
; File:
       .file "sigman.s" 
; Behaviour: 
;      Calculate sigma N and store the
;      result in SUM
; Assumptions:
;      N is a program constant > 0
; Board:
;      CME11-E9-EVBU 
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2002
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
      aba            ; acca:= acca + accb
      decb           ; decrement accb
      bne loop       ; if accb != 0 then goto loop
      staa SUM       ; store acca in memory referenced by SUM 
      swi
      #stop

;----------------------------------------------
;            Data Section
;----------------------------------------------
set N, 4
SUM: .byte 0

#set up dummy frame pointer
.global _.frame
_.frame: .word


.end
