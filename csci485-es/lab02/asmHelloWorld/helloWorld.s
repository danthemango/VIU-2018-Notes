;================================================
; File
   .file "helloWorld.s"
; prints hello world
; Daniel Guenther
; 2017-09-19
;================================================

.sect .text
.global _start

; useful subroutines
set OUTLHLF, 0xffb2
set OUTRHLF, 0xffb5
set OUTA, 0xffb8
set OUT1BYT, 0xffbb
set OUT1BSP, 0xffbe
set OUT2BSP, 0xffc1
set OUTSTRG, 0xffc7
set OUTSTRGO, 0xffca
set OUTCRLF, 0xffc4

;end of string byte
set eot, 0x4                           

_start:
            ldx #helloWorld
            jsr OUTSTRG

end: 
            swi

helloWorld:       .asciz "Hello World"
.byte eot

; set up dummy frame pointer
.global _.frame
_.frame: .word

.end
