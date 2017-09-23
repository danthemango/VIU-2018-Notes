set remotebaud 9600
target buffalo /dev/ttyS0
load mallocTest.elf
set language asm
run
quit

