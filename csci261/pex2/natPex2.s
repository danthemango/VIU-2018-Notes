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

set OUTA, 0xFFB8

set TCNT , 0x100E
set NUMINT , 0x3 		; counter set to 100ms (3 x 32.77ms)
set DIFF , 0xD34		; Diff, number of counts for 1.69 ms (3380 counts) 0d34	
set TFLG2 , 0x1025

_start:               
         
			ldaa #30
			jsr countertimer
		
			ldaa #'z'
			jsr OUTA
			
			ldaa #0x0
			staa COUNT
		
			swi          

timer: 			ldy #NUMINT
				jsr tofClr
				ldd TCNT
				addd #DIFF
				bcc tLoop1
				iny
		
tLoop1:			cpy #0x0
				beq tLoop2

tLoop3: 		tst TFLG2
				bpl tLoop3
				jsr tofClr
				dey
				bne tLoop1

tLoop2: 		cpd TCNT
				bhi tLoop2	

xtimer:			rts
	
tofClr: 		ldaa #0x80
				staa TFLG2
xtofClr:		rts

counttimer:		staa TMAX

ctloop:			ldaa TMAX
				cmpa TCOUNT
				beq xcounttimer
				jsr timer
				inc TCOUNT
				jmp ctloop
			
xcounttimer:	rts

reactcounter:	jsr timer
				inc RCOUNT

xreactcounter:	rts

TCOUNT: .byte 0
TMAX: .byte 0
RCOUNT: .byte 0

.end



