;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 3.0.4 m68hc1x-20020616
;;; Command:	/usr/lib/gcc-lib/m6811-elf/3.0.4/cc1 -lang-c -D__GNUC__=3 -D__GNUC_MINOR__=0 -D__GNUC_PATCHLEVEL__=4 -Dmc68hc1x -D__mc68hc1x__ -D__mc68hc1x -D__CHAR_UNSIGNED__ -D__OPTIMIZE_SIZE__ -D__OPTIMIZE__ -D__STDC_HOSTED__=1 -D__HAVE_SHORT_INT__ -D__INT__=16 -D__INT_MAX__=32767 -Dmc6811 -DMC6811 -Dmc68hc11 main.c -quiet -dumpbase main.c -mshort -Os -fomit-frame-pointer -o main.s
;;; Compiled:	Sat Feb  1 00:59:36 2003
;;; (META)compiled by GNU C version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk).
;;;-----------------------------------------
	.file	"main.c"
	.sect	.text
	.globl	main
	.type	main,@function
main:
; Begin inline assembler code
#APP
	cli
; End of inline assembler code
#NO_APP
.L2:
	bra	.L2
.Lfe1:
	.size	main,.Lfe1-main
	.globl	irqCount
	.type	irqCount,@function
irqCount:
	inc	COUNT
; Begin inline assembler code
#APP
	xirqCount:
; End of inline assembler code
#NO_APP
	rti
.Lfe2:
	.size	irqCount,.Lfe2-irqCount
	.comm	COUNT,1,1
	.ident	"GCC: (GNU) 3.0.4 m68hc1x-20020616"
