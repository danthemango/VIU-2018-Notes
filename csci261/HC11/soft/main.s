;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 3.3.5-m68hc1x-20050129
;;; Command:	/usr/lib/gcc-lib/m6811-elf/3.3.5-m68hc1x-20050129/cc1 -quiet -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=5 -Dmc68hc1x -D__mc68hc1x__ -D__mc68hc1x -D__HAVE_SHORT_INT__ -D__INT__=16 -Dmc6811 -DMC6811 -Dmc68hc11 main.c -quiet -dumpbase main.c -mshort -auxbase main -Os -o main.s
;;; Compiled:	Thu Mar 17 13:40:24 2005
;;; (META)compiled by GNU C version 3.2.
;;;-----------------------------------------
	.file	"main.c"
	.mode mshort
	; extern	foo
	.sect	.text
	.globl	_start
	.type	_start,@function
_start:
	ldx	*_.frame
	pshx
	sts	*_.frame
	ldab	#3
	pshb
	des
	ldab	#2
	pshb
	des
	ldab	#1
	bsr	foo
	clra
	pulx
	pulx
	pulx
	stx	*_.frame
	rts
	.size	_start, .-_start
	.globl	foo
	.type	foo,@function
foo:
	ldx	*_.frame
	pshx
	sts	*_.frame
	ldx	*_.frame
	addb	6,x
	subb	8,x
	clra
	pulx
	stx	*_.frame
	rts
	.size	foo, .-foo
	.ident	"GCC: (GNU) 3.3.5-m68hc1x-20050129"
