set remotebaud 9600
target buffalo /dev/ttyS0
load helloWorld.elf
set language asm
run
quit
