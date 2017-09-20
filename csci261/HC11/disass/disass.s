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
loop:ldx #0x0100
     clra
     clrb
     addd 0,x
     dex 
     bne loop
     swi

;----------------------------------------------
;            Data Section
;----------------------------------------------

.end
