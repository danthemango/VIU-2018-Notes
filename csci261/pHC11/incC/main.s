;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 2.95.3 20010315 (release)+m68hc1x-20010922
;;; Command:	/usr/local/lib/gcc-lib/m6811-elf/2.95.3/cc1 /tmp/ccazJmSD.i -quiet -dumpbase main.c -mshort -Os -fomit-frame-pointer -o main.s
;;; Compiled:	Tue Mar 19 18:50:39 2002
;;; (META)compiled by GNU C version 2.95.2 20000220 (Debian GNU/Linux).
;;;-----------------------------------------
	.file	"main.c"
gcc2_compiled.:
	; extern	foo
	.sect	.text
.globl main
	.type	 main,@function
main:
	ldab	#3
	bsr	foo
	clra
	clrb
	rts
.Lfe1:
	.size	 main,.Lfe1-main
.globl foo
	.type	 foo,@function
foo:
	incb
	clra
	rts
.Lfe2:
	.size	 foo,.Lfe2-foo
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)+m68hc1x-20010922"
