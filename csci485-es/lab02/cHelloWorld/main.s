;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 3.3.6-m68hc1x-20060122
;;; Command:	/usr/lib/gcc-lib/m68hc11/3.3.6-m68hc1x-20060122/cc1 -quiet -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=6 -Dmc68hc1x -D__mc68hc1x__ -D__mc68hc1x -D__HAVE_SHORT_INT__ -D__INT__=16 -Dmc6811 -DMC6811 -Dmc68hc11 main.c -quiet -dumpbase main.c -mshort -auxbase main -Os -fomit-frame-pointer -o main.s
;;; Compiled:	Thu Sep 21 02:49:09 2017
;;; (META)compiled by GNU C version 6.3.0 20170221.
;;;-----------------------------------------
	.file	"main.c"
	.mode mshort
	; extern	wstr
	; extern	strStr
	; extern	wcrlf
	.sect	.text
	.globl	_start
	.type	_start,@function
_start:
; Begin inline assembler code
#APP
	lds #_stack
; End of inline assembler code
#NO_APP
	ldd	#strStr
	bsr	wstr
	bsr	wcrlf
	ldab	#88
	stab	strStr+1
	ldd	#strStr
	bsr	wstr
	bsr	wcrlf
; Begin inline assembler code
#APP
	swi
; End of inline assembler code
#NO_APP
	rts
	.size	_start, .-_start
; Begin inline assembler code
#APP
	strStr: .ascii "Hello World" 
 .byte 0x4 

	.ident	"GCC: (GNU) 3.3.6-m68hc1x-20060122"
