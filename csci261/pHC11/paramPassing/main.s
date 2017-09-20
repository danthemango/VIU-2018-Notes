;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 3.0.4 m68hc1x-20021111
;;; Command:	/usr/lib/gcc-lib/m6811-elf/3.0.4/cc1 -lang-c -D__GNUC__=3 -D__GNUC_MINOR__=0 -D__GNUC_PATCHLEVEL__=4 -Dmc68hc1x -D__mc68hc1x__ -D__mc68hc1x -D__CHAR_UNSIGNED__ -D__OPTIMIZE_SIZE__ -D__OPTIMIZE__ -D__STDC_HOSTED__=1 -D__HAVE_SHORT_INT__ -D__INT__=16 -D__INT_MAX__=32767 -Dmc6811 -DMC6811 -Dmc68hc11 main.c -quiet -dumpbase main.c -mshort -Os -fomit-frame-pointer -o main.s
;;; Compiled:	Thu Mar 20 14:01:50 2003
;;; (META)compiled by GNU C version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk).
;;;-----------------------------------------
	.file	"main.c"
	.mode mshort
	.mode mlong-double
	; extern	foo
	.sect	.text
	.globl	_start
	.type	_start,@function
_start:
	ldab	#3
	pshb
	des
	ldab	#2
	pshb
	des
	ldab	#1
	bsr	foo
	clra
	puly
	puly
	rts
.Lfe1:
	.size	_start,.Lfe1-_start
	.globl	foo
	.type	foo,@function
foo:
	tsx
	addb	3,x
	subb	5,x
	clra
	rts
.Lfe2:
	.size	foo,.Lfe2-foo
	.ident	"GCC: (GNU) 3.0.4 m68hc1x-20021111"
