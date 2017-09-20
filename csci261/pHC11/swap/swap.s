;============================================-=
; File:
       .file "swap.s" 
; Behaviour: 
;      Swap the contents of AA and BB
; Assumptions:
;      none
; Board:
;      CME11-E9-EVBU 
; Author/Date:
;      Peter Walsh Feb 2001
;      Revised Feb 2002
;      Revised Jan 2003 
;==========================================-=

;----------------------------------------
;            Text Section (code and data)
;----------------------------------------
.global _start
.sect .text

_start: 
          lds #_stack    ; initialize SP
          ldaa AA        ; load AA
          ldab BB        ; load BB
          jsr swapab     ; call swapab
          staa AA        ; save AA
          stab BB        ; save BB
          swi          

;---------------------------------------------
; Behaviour:
;      Swap the contents of acca and accb
; Assumptions:
;      none
; Register and Memory Usage:
;    Precondition:
;      acca and accb are input parameters
;    Postcondition:
;         acca and accb output parameters
;    Destroyes:
;         none
;---------------------------------------------
swapab:   psha
          pshb
          pula
          pulb
xswapab:  rts

;----------------------------------------------
;            Data (in the text section)
;----------------------------------------------

AA: .byte 3
BB: .byte 4

#set up dummy frame pointer
.global _.frame
_.frame: .word


.end
