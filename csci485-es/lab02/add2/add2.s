;============================================-=
; File:
       .file "add2.s" 
; Behaviour: 
;      Add the contents of AA and BB and store result in CC
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2003
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

_start: 
          lds #_stack    ; initialize SP
          ldaa AA        ; load AA
          ldab BB        ; load BB
          jsr add2       ; call add2
          staa CC        ; save CC
          ;stop           ; use stop for wookie
          swi            ; use swi for gdb and buffalo


;---------------------------------------------
; Behaviour: 
;      Sum the contents of acca and accb
; Assumptions:
;      none
; Register and Memory Usage:
;    Precondition:
;      acca and accb are input parameters
;    Postcondition:
;         acca contains the sum
;    Destroyes:
;         ccr
;---------------------------------------------
add2:     aba
xadd2:    rts


;----------------------------------------------
;            Data (in Text section)
;----------------------------------------------
AA: .byte 3
BB: .byte 4
CC: .byte 0

.end
