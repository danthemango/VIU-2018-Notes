;============================================-=
; File:
       .file "wave.s" 
; Behaviour: 
;      Generates a 1KHz square wave with a 40% duty cycle
;      using polling   (see text page 366)
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2002
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

set outa, 0xffb8
set out1byt, 0xffbb
set out1bsp, 0xffbe
set outcrlf, 0xffc4

_start:               
reduce: 
      ldaa count
      jsr outa
      ;jsr outcrlf
      dec count
      dec num
      bne reduce

end:    swi

startchar:     .byte 'a'
endchar:       .byte 'z'
count:   .byte 9

.end
