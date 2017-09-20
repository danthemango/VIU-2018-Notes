;============================================-=
; File:
       .file "scada.s" 
; Behaviour: 
;      reads input from serial port
;      if '0' then write 0x00 to port A and echo '0' back on serial line 
;      else if '1' write 0xFF to port A and echo '1' back on serial line
;      else if '2' re-enter BUFFALO monitor

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

again:   jsr INCHAR

         cmpa #0x30
         bne notClear

         #echo '0' and clead led
         jsr OUTA
         ldaa #OFFLED
         staa PORTA,x
         bra again

notClear: 
         cmpa #0x31
         bne notSet

         #echo '1' and set led
         jsr OUTA
         ldaa #ONLED
         staa PORTA,x
         bra again
notSet: 
         cmpa #0x32
         bne notReset 

         # reset 
         jsr INCHAR ; remove the ENTER from input stream
         swi

notReset: 
         # default
         bra again


.end
