;;;-----------------------------------------
;;; Start MC68HC11 gcc assembly output
;;; gcc compiler 3.3.6-m68hc1x-20060122
;;; Command:	/usr/lib/gcc-lib/m68hc11/3.3.6-m68hc1x-20060122/cc1 -quiet -I. -I../../gel-hc1x-1.6.1/include/asm-m68hc11/arch-cme11 -I../../gel-hc1x-1.6.1/include -D__GNUC__=3 -D__GNUC_MINOR__=3 -D__GNUC_PATCHLEVEL__=6 -Dmc68hc1x -D__mc68hc1x__ -D__mc68hc1x -D__HAVE_SHORT_INT__ -D__INT__=16 -Dmc6811 -DMC6811 -Dmc68hc11 helloWorld.c -quiet -dumpbase helloWorld.c -m68hc11 -mshort -auxbase-strip helloWorld -g -Os -Wall -Wmissing-prototypes -o helloWorld.s
;;; Compiled:	Thu Sep 21 12:11:28 2017
;;; (META)compiled by GNU C version 6.3.0 20170221.
;;;-----------------------------------------
	.file	"helloWorld.c"
	.mode mshort
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.sect	.text
.Ltext0:
	; extern	_io_ports
	; extern	cop_optional_reset
	; extern	serial_flush
	; extern	serial_init
	; extern	serial_print
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Hello World\n\004"
	.sect	.text
	.globl	main
	.type	main,@function
main:
.LFB33:
.LM1:
	ldx	*_.frame
	pshx
	sts	*_.frame
.LM2:
.LM3:
	ldab	#48
.LBB2:
	stab	_io_ports+43
.LM4:
	clr	_io_ports+44
.LM5:
	ldab	#12
	stab	_io_ports+45
.LM6:
.LBE2:
	ldd	#.LC0
	bsr	serial_print
.LM7:
	clra
	clrb
	pulx
	stx	*_.frame
	rts
.LFE33:
	.size	main, .-main
.Letext0:
	.section	.debug_line
	.4byte	.LELT0-.LSLT0
.LSLT0:
	.2byte	0x2
	.4byte	.LELTP0-.LASLTP0
.LASLTP0:
	.byte	0x1
	.byte	0x1
	.byte	0xf6
	.byte	0xf5
	.byte	0xa
	.byte	0x0
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x1
	.ascii	"../../gel-hc1x-1.6.1/include/asm-m68hc11"
	.byte	0
	.byte	0x0
	.string	"helloWorld.c"
	.uleb128 0x0
	.uleb128 0x0
	.uleb128 0x0
	.string	"interrupts.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.string	"sio.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.string	"ports_def.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.byte	0x0
.LELTP0:
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM1
	.byte	0x24
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM2
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM3
	.byte	0x4
	.uleb128 0x3
	.byte	0x30
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM4
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM5
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM6
	.byte	0x4
	.uleb128 0x1
	.byte	0x3
	.sleb128 -33
	.byte	0x1
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM7
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.Letext0
	.byte	0x0
	.uleb128 0x1
	.byte	0x1
.LELT0:
	.section	.debug_info
	.4byte	0x34d
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.Ldebug_line0
	.4byte	.Letext0
	.4byte	.Ltext0
	.4byte	.LC70
	.4byte	.LC71
	.4byte	.LC72
	.byte	0x1
	.uleb128 0x2
	.4byte	.LC33
	.byte	0x2
	.byte	0x25
	.4byte	0x30
	.uleb128 0x3
	.byte	0x2
	.4byte	0x36
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x5
	.4byte	0x205
	.4byte	.LC73
	.byte	0x40
	.byte	0x2
	.byte	0x29
	.uleb128 0x6
	.4byte	.LC1
	.byte	0x2
	.byte	0x2a
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.4byte	.LC2
	.byte	0x2
	.byte	0x2b
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.4byte	.LC3
	.byte	0x2
	.byte	0x2c
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.4byte	.LC4
	.byte	0x2
	.byte	0x2d
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x6
	.4byte	.LC5
	.byte	0x2
	.byte	0x2e
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x6
	.4byte	.LC6
	.byte	0x2
	.byte	0x2f
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xa
	.uleb128 0x6
	.4byte	.LC7
	.byte	0x2
	.byte	0x30
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x6
	.4byte	.LC8
	.byte	0x2
	.byte	0x31
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xe
	.uleb128 0x6
	.4byte	.LC9
	.byte	0x2
	.byte	0x32
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x6
	.4byte	.LC10
	.byte	0x2
	.byte	0x33
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x12
	.uleb128 0x6
	.4byte	.LC11
	.byte	0x2
	.byte	0x34
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x6
	.4byte	.LC12
	.byte	0x2
	.byte	0x37
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x16
	.uleb128 0x6
	.4byte	.LC13
	.byte	0x2
	.byte	0x3a
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x6
	.4byte	.LC14
	.byte	0x2
	.byte	0x3d
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x1a
	.uleb128 0x6
	.4byte	.LC15
	.byte	0x2
	.byte	0x40
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x6
	.4byte	.LC16
	.byte	0x2
	.byte	0x43
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x1e
	.uleb128 0x6
	.4byte	.LC17
	.byte	0x2
	.byte	0x46
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x6
	.4byte	.LC18
	.byte	0x2
	.byte	0x49
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x22
	.uleb128 0x6
	.4byte	.LC19
	.byte	0x2
	.byte	0x4c
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x6
	.4byte	.LC20
	.byte	0x2
	.byte	0x4f
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x26
	.uleb128 0x6
	.4byte	.LC21
	.byte	0x2
	.byte	0x52
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x6
	.4byte	.LC22
	.byte	0x2
	.byte	0x55
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x2a
	.uleb128 0x6
	.4byte	.LC23
	.byte	0x2
	.byte	0x58
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.uleb128 0x6
	.4byte	.LC24
	.byte	0x2
	.byte	0x5b
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x2e
	.uleb128 0x6
	.4byte	.LC25
	.byte	0x2
	.byte	0x5e
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x6
	.4byte	.LC26
	.byte	0x2
	.byte	0x61
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x32
	.uleb128 0x6
	.4byte	.LC27
	.byte	0x2
	.byte	0x64
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0x6
	.4byte	.LC28
	.byte	0x2
	.byte	0x67
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x36
	.uleb128 0x6
	.4byte	.LC29
	.byte	0x2
	.byte	0x6a
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x6
	.4byte	.LC30
	.byte	0x2
	.byte	0x6d
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x3a
	.uleb128 0x6
	.4byte	.LC31
	.byte	0x2
	.byte	0x70
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x3c
	.uleb128 0x6
	.4byte	.LC32
	.byte	0x2
	.byte	0x73
	.4byte	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x3e
	.byte	0x0
	.uleb128 0x2
	.4byte	.LC34
	.byte	0x2
	.byte	0x75
	.4byte	0x38
	.uleb128 0x7
	.4byte	0x2e3
	.4byte	.LC68
	.byte	0x2
	.byte	0x2
	.byte	0x79
	.uleb128 0x8
	.4byte	.LC35
	.sleb128 0
	.uleb128 0x8
	.4byte	.LC36
	.sleb128 1
	.uleb128 0x8
	.4byte	.LC37
	.sleb128 2
	.uleb128 0x8
	.4byte	.LC38
	.sleb128 3
	.uleb128 0x8
	.4byte	.LC39
	.sleb128 4
	.uleb128 0x8
	.4byte	.LC40
	.sleb128 5
	.uleb128 0x8
	.4byte	.LC41
	.sleb128 6
	.uleb128 0x8
	.4byte	.LC42
	.sleb128 7
	.uleb128 0x8
	.4byte	.LC43
	.sleb128 8
	.uleb128 0x8
	.4byte	.LC44
	.sleb128 9
	.uleb128 0x8
	.4byte	.LC45
	.sleb128 10
	.uleb128 0x8
	.4byte	.LC46
	.sleb128 11
	.uleb128 0x8
	.4byte	.LC47
	.sleb128 12
	.uleb128 0x8
	.4byte	.LC48
	.sleb128 13
	.uleb128 0x8
	.4byte	.LC49
	.sleb128 14
	.uleb128 0x8
	.4byte	.LC50
	.sleb128 15
	.uleb128 0x8
	.4byte	.LC51
	.sleb128 16
	.uleb128 0x8
	.4byte	.LC52
	.sleb128 17
	.uleb128 0x8
	.4byte	.LC53
	.sleb128 18
	.uleb128 0x8
	.4byte	.LC54
	.sleb128 19
	.uleb128 0x8
	.4byte	.LC55
	.sleb128 20
	.uleb128 0x8
	.4byte	.LC56
	.sleb128 21
	.uleb128 0x8
	.4byte	.LC57
	.sleb128 22
	.uleb128 0x8
	.4byte	.LC58
	.sleb128 23
	.uleb128 0x8
	.4byte	.LC59
	.sleb128 24
	.uleb128 0x8
	.4byte	.LC60
	.sleb128 25
	.uleb128 0x8
	.4byte	.LC61
	.sleb128 26
	.uleb128 0x8
	.4byte	.LC62
	.sleb128 27
	.uleb128 0x8
	.4byte	.LC63
	.sleb128 28
	.uleb128 0x8
	.4byte	.LC64
	.sleb128 29
	.uleb128 0x8
	.4byte	.LC65
	.sleb128 30
	.uleb128 0x8
	.4byte	.LC66
	.sleb128 31
	.uleb128 0x8
	.4byte	.LC67
	.sleb128 32
	.byte	0x0
	.uleb128 0x2
	.4byte	.LC68
	.byte	0x2
	.byte	0x9c
	.4byte	0x210
	.uleb128 0x9
	.4byte	0x316
	.byte	0x1
	.4byte	.LC74
	.byte	0x1
	.byte	0x11
	.4byte	0x316
	.4byte	.LFB33
	.4byte	.LFE33
	.byte	0x1
	.byte	0x59
	.uleb128 0xa
	.4byte	0x31d
	.4byte	.LBB2
	.4byte	.LBE2
	.byte	0x0
	.uleb128 0xb
	.string	"int"
	.byte	0x2
	.byte	0x5
	.uleb128 0xc
	.byte	0x1
	.4byte	.LC75
	.byte	0x3
	.byte	0x2d
	.byte	0x1
	.byte	0x2
	.uleb128 0xd
	.4byte	0x332
	.4byte	0x332
	.uleb128 0xe
	.byte	0x0
	.uleb128 0xf
	.4byte	0x337
	.uleb128 0x10
	.4byte	.LC69
	.byte	0x1
	.byte	0x8
	.uleb128 0x11
	.4byte	.LC76
	.byte	0x4
	.byte	0x2a
	.4byte	0x34b
	.byte	0x1
	.byte	0x1
	.uleb128 0xf
	.4byte	0x327
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x15
	.byte	0x0
	.uleb128 0x27
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x1d
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.4byte	0x17
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x351
	.4byte	0x2ee
	.string	"main"
	.4byte	0x0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,"MS",@progbits,1
.LC47:
	.string	"SPI_VECTOR"
.LC3:
	.string	"res2_handler"
.LC52:
	.string	"TIMER_OUTPUT4_VECTOR"
.LC50:
	.string	"TIMER_OVERFLOW_VECTOR"
.LC23:
	.string	"capture2_handler"
.LC61:
	.string	"XIRQ_VECTOR"
.LC69:
	.string	"unsigned char"
.LC51:
	.string	"TIMER_OUTPUT5_VECTOR"
.LC2:
	.string	"res1_handler"
.LC33:
	.string	"interrupt_t"
.LC49:
	.string	"ACC_OVERFLOW_VECTOR"
.LC24:
	.string	"capture1_handler"
.LC25:
	.string	"rtii_handler"
.LC35:
	.string	"RES0_VECTOR"
.LC16:
	.string	"timer_overflow_handler"
.LC1:
	.string	"res0_handler"
.LC46:
	.string	"SCI_VECTOR"
.LC36:
	.string	"RES1_VECTOR"
.LC29:
	.string	"illegal_handler"
.LC73:
	.string	"interrupt_vectors"
.LC71:
	.string	"/home/student/guenthdd/csci485/lab02/helloWorld"
.LC58:
	.string	"TIMER_INPUT1_VECTOR"
.LC70:
	.string	"helloWorld.c"
.LC37:
	.string	"RES2_VECTOR"
.LC32:
	.string	"reset_handler"
.LC57:
	.string	"TIMER_INPUT2_VECTOR"
.LC62:
	.string	"SWI_VECTOR"
.LC26:
	.string	"irq_handler"
.LC10:
	.string	"res9_handler"
.LC31:
	.string	"cop_clock_handler"
.LC38:
	.string	"RES3_VECTOR"
.LC56:
	.string	"TIMER_INPUT3_VECTOR"
.LC66:
	.string	"RESET_VECTOR"
.LC28:
	.string	"swi_handler"
.LC14:
	.string	"acc_input_handler"
.LC9:
	.string	"res8_handler"
.LC39:
	.string	"RES4_VECTOR"
.LC74:
	.string	"main"
.LC72:
	.string	"GNU C 3.3.6-m68hc1x-20060122"
.LC67:
	.string	"MAX_VECTORS"
.LC48:
	.string	"ACC_INPUT_VECTOR"
.LC40:
	.string	"RES5_VECTOR"
.LC8:
	.string	"res7_handler"
.LC65:
	.string	"COP_CLOCK_VECTOR"
.LC75:
	.string	"serial_init"
.LC60:
	.string	"IRQ_VECTOR"
.LC17:
	.string	"output5_handler"
.LC68:
	.string	"interrupt_vector_id"
.LC15:
	.string	"acc_overflow_handler"
.LC41:
	.string	"RES6_VECTOR"
.LC45:
	.string	"RES10_VECTOR"
.LC27:
	.string	"xirq_handler"
.LC7:
	.string	"res6_handler"
.LC34:
	.string	"interrupt_vectors_t"
.LC64:
	.string	"COP_FAIL_VECTOR"
.LC18:
	.string	"output4_handler"
.LC42:
	.string	"RES7_VECTOR"
.LC6:
	.string	"res5_handler"
.LC12:
	.string	"sci_handler"
.LC43:
	.string	"RES8_VECTOR"
.LC19:
	.string	"output3_handler"
.LC55:
	.string	"TIMER_OUTPUT1_VECTOR"
.LC5:
	.string	"res4_handler"
.LC44:
	.string	"RES9_VECTOR"
.LC76:
	.string	"_io_ports"
.LC59:
	.string	"RTI_VECTOR"
.LC30:
	.string	"cop_fail_handler"
.LC11:
	.string	"res10_handler"
.LC20:
	.string	"output2_handler"
.LC54:
	.string	"TIMER_OUTPUT2_VECTOR"
.LC63:
	.string	"ILLEGAL_OPCODE_VECTOR"
.LC4:
	.string	"res3_handler"
.LC13:
	.string	"spi_handler"
.LC53:
	.string	"TIMER_OUTPUT3_VECTOR"
.LC21:
	.string	"output1_handler"
.LC22:
	.string	"capture3_handler"
	.ident	"GCC: (GNU) 3.3.6-m68hc1x-20060122"
