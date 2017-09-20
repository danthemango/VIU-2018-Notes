;============================================-=
; File:
       .file "scada.s" 
; Behaviour: 
;      reads input from serial port
;      if '0' then write 0x00 to port A  
;      else if '1' write 0xFF to port A 
;      else if '2' re-enter BUFFALO monitor
;      else if '3' 

; Assumptions:
;      none
; Destroys:
;      a, x
; Board:
;      CME11-E9-EVBU
; Author:
;      Peter Walsh
;============================================-=

set RBASE, 0x1000

set PORTA, 0x0
set ONLED, 0xff
set OFFLED, 0x0
set ONSTATE, 0x35
set OFFSTATE, 0x34
set INCHAR, 0xffcd
set OUTA, 0xffb8
set CRLF, 0xffc4


;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text
.global _start

_start:  lds #_stack

         ldx #RBASE
         ldaa #OFFLED
         staa PORTA,x
         ldaa #OFFSTATE
         staa state

again:   jsr INCHAR

         cmpa #0x30
         bne setLed

         #clead led
         ldaa #OFFLED
         staa PORTA,x
         ldaa #OFFSTATE
         staa state
         bra again

setLed: 
         cmpa #0x31
         bne resetBuffalo

         #set led
         ldaa #ONLED
         staa PORTA,x
         ldaa #ONSTATE
         staa state
         bra again

resetBuffalo: 
         cmpa #0x32
         bne GetState 

         #  reset Buffalo
         jsr INCHAR ; remove the ENTER from input stream
         swi

GetState: 
         cmpa #0x33
         bne default

         # get state
         ldaa state
         jsr OUTA
         bra again

default: 
         ; default
         bra again

;----------------------------------------------
;            Data (in the text section)
;----------------------------------------------

state: .byte

.end
