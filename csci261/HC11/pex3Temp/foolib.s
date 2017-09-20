;======================
; Buff routine stubs
;======================

set OUTSTRGO, 0xffca
set OUTCRLF, 0xffc4

.global wstr
.global wcrlf

wcrlf:  jsr OUTCRLF
        rts

wstr:   xgdx
        jsr OUTSTRGO   
        rts

;===================
; soft registers
;===================
.sect softregs
.global _.d1
_.d1: .word
