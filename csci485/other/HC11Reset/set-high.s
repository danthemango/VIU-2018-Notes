;============================================-=
; File:
      .file "set-high.s"
; Behaviour: 
;
; Board:
;     CME11-E9-EVBU
; Author/Date:
;     Daniel Guenther
;==========================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text 
.global _start

set regbase, 0x1000                    ; addresses of HC11 registers
set porta, 0x0
set tcnt, 0x0e       
set toc2, 0x18
set tctl2, 0x21
set tmsk1, 0x22
set tflg1, 0x23
set TCNT , 0x100E
set TFLG2 , 0x1025

set toggle, 0x40

set PA0, 0x01
set PA1, 0x02
set PA2, 0x04
set PA3, 0x08
set PA4, 0x10
set PA5, 0x20
set PA6, 0x40
set PA7, 0x80
set AllPorts, 0xFF
set clear, 0x40
set set, 0x40

set jmpOpcode, 0x7e
set toc2JT, 0xde                 ; toc2 jump table address
set OUTSTRG, 0xffc7
set OUTA, 0xffb8

_start: 
         ldx #regbase              
         bclr porta,x 0xff        ; set all ports to low

         ldx #resetting
         jsr OUTSTRG

         jsr sleepSecond

         ldx #regbase              
         bset porta,x 0xff        ; set all ports to high
         swi

resetting: .asciz "resetting\4"

;---------------------------------------------
; Behaviour: 
;     sleepSecond
;     waits for one second 
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Destroys:
;        ccr
;---------------------------------------------
; used for sleepSecond
set secondOverflows , 30 	            ; number of overflows in under one second (30 x 32.77ms)
set secondDifference, 33950		      ; number of cycles for the difference (16.98ms, or 33950 cycles) 

sleepSecond:   
            pshy                       ; save registers from previous subroutine
            psha
            pshb

            ldaa #0x80                 ; clear TOF
				staa TFLG2

            ldy #secondOverflows       ; Reg Y = num. clock overflows in a second  
				ldd TCNT                   ; Reg D = TCNT + num. cycles in a second MOD overflows
				addd #secondDifference     

				bcc checkOF                ; increment Y if D overflowed from addition
				iny
		
checkOF:                               ; check Over Flow:
            cpy #0x0                   ; skip to cycle count once overflow count = 0
				beq checkCyc               

checkTOF:	                           ; check Timer Overflow Flag
            tst TFLG2                  ; loop until overflow
				bpl checkTOF

            psha
            ldaa #0x80                 ; clear TOF
				staa TFLG2
            pula

				dey                        ; decrement the number of overflows
				bne checkTOF               ; if overflows != 0, goto checkTOF

checkCyc:	cpd TCNT                   ; loop until TCNT = Reg D (remainder cycles)
				bhi checkCyc	
                                       
                                       ; job done:
            pulb                       ; put saved registers back in place before return
            pula
            puly

xsleepSecond:		
            rts

.end

