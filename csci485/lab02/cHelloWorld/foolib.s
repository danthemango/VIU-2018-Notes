;======================
; Buff routine stubs
;======================

set OUTSTRGO, 0xffca
set OUTCRLF, 0xffc4

.global wstr
.global xwstr

.global wcrlf

wcrlf:  jsr OUTCRLF
        rts

wstr:   pshy     ; save y 
        pshx     ; save x
        xgdx
        pshx     ; save d
        tpa      ; save ccr
        psha

        jsr OUTSTRGO   

        pula    
        tap      ; restore ccr
        pulx     ; restore d
        xgdx
        pulx     ; restore x
        puly     ; restore y
xwstr:  rts

;===================
; soft registers
;===================
.sect softregs
.global _.d1
_.d1: .word
