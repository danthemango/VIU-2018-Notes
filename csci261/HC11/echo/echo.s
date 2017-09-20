;============================================-=
; File:
       .file "echo.s" 
; Behaviour: 
;      Echo a character through the SCI
; Assumptions:
;      Run on simulator or on Axiom board
;      with minicom set with correct comm. parameters	
; Board:
;      CME11-E9-EVBU
; Author:
;      Peter Walsh
;      Mar 2005
;============================================-=

set RBASE, 0x1000
set BAUD, 0x2b
set SCCR1, 0x2c
set SCCR2, 0x2d
set SCSR, 0x2e
set SCDR, 0x2f

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text
.global _start

_start:  lds #_stack
         jsr serialInit
again:   jsr serialRecieve
         jsr serialSend 
         bra again
         rts

;---------------------------------------------
; Behaviour: 
;    Initialize SCI
;       - 1200 baud
;       - 1 start bit, 8 data bits 1 stop bit
;	- no parity
; Assumptions:
;       none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroyed:
;       ccr
;---------------------------------------------
serialInit:   psha 
              ldaa #0x33
              staa RBASE+BAUD 
              ldaa #0x0
              staa RBASE+SCCR1
              ldaa #0xc
              staa RBASE+SCCR2
              pula
xserialInit:  rts

;---------------------------------------------
; Behaviour: 
;    Send an ASCII character through SCI
; Assumptions:
; Register and Memory Usage:
;    Precondition:
;       reg b contains character to be sent 
;    Postcondition:
;    Destroyed:
;       ccr
;---------------------------------------------
serialSend:   psha
serialSend1:  ldaa RBASE+SCSR
              bge serialSend1
              stab RBASE+SCDR
              pula
xserialSend:  rts

;---------------------------------------------
; Behaviour: 
;    Recieve an ASCII character through SCI
; Assumptions:
;    none
; Register and Memory Usage:
;    Precondition:
;       none
;    Postcondition:
;       returned character in reg low byte of d
;    Destroyed:
;       ccr
;---------------------------------------------
serialRecieve: 
               ldaa RBASE+SCSR
               bita #0x20
               beq serialRecieve
               ldab RBASE+SCDR
xserialReceive:rts

.end
