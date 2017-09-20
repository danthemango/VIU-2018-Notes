;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 3.0.4 m68hc1x-20030430
;;; Command:	/usr/lib/gcc-lib/m6811-elf/3.0.4/cc1 -lang-c -D__GNUC__=3 -D__GNUC_MINOR__=0 -D__GNUC_PATCHLEVEL__=4 -Dmc68hc1x -D__mc68hc1x__ -D__mc68hc1x -D__CHAR_UNSIGNED__ -D__OPTIMIZE_SIZE__ -D__OPTIMIZE__ -D__STDC_HOSTED__=1 -D__HAVE_SHORT_INT__ -D__INT__=16 -D__INT_MAX__=32767 -Dmc6811 -DMC6811 -Dmc68hc11 main.c -quiet -dumpbase main.c -mshort -Os -fomit-frame-pointer -o main.s
;;; Compiled:	Wed Mar 24 11:47:01 2004
;;; (META)compiled by GNU C version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk).
;;;-----------------------------------------
	.file	"main.c"
	.mode mshort
	.mode mlong-double
	.sect	.text
	.globl	_start
	.type	_start,@function
_start:
	ldx	#4096
	bset	0,x, #64
	ldx	#4128
	ldab	#64
	stab	0,x
	ldx	#4110
	ldd	0,x
	addd	#800
	ldx	#4120
	std	0,x
	ldx	#4131
	ldab	#64
	stab	0,x
.L5:
	ldx	#4131
	ldab	0,x
	andb	#64
	beq	.L5
	ldab	#64
	stab	0,x
	ldx	#4120
	ldd	0,x
	addd	#1200
	std	0,x
.L8:
	ldx	#4131
	ldab	0,x
	andb	#64
	beq	.L8
	ldab	#64
	stab	0,x
	ldx	#4120
	ldd	0,x
	addd	#800
	std	0,x
	bra	.L5
.Lfe1:
	.size	_start,.Lfe1-_start
	.ident	"GCC: (GNU) 3.0.4 m68hc1x-20030430"
