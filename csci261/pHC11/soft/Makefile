# Makefile to drive cew testing of asm code using gdb
# P Walsh Feb 2001

# Targets
#   interactive --- assemble program under test and load into gdb
#   bats --- make batch tester from bats.script
#   clean
#   submit -- submit assignment code

# source file
SRC=foolib

# directory where scripts are located and temp files
SD=CewDir

# code beautifier 
INDENT=cat

# version of awk
AWK=awk 

# extra debugger flags
XDBF=-batch -x

# tools 
AS=m6811-elf-as
CC=m6811-elf-gcc
LD=m6811-elf-ld
GDB=m6811-elf-gdb

interactive: main.elf
	$(GDB) main.elf

bats.gdb: bats.script
	rm -f $(SD)/tmp/bats.gdb
	perl $(SD)/bin/addLineNums.pl bats.script > $(SD)/tmp/bats.num
	m4 -B20000  $(SD)/tmp/bats.num | $(INDENT)  > bats.gdb

clean:
	rm -f *.o *.elf *.gdb *.lst $(SD)/tmp/*

bats:	main.elf bats.gdb
	$(GDB) $(XDBF) bats.gdb main.elf | $(SD)/bin/filterOutput.pl 

$(SRC).o: $(SRC).s
	$(AS)   -a=$(SRC).lst -o $(SRC).o $(SRC).s

main.s: main.c
	$(CC) -S -Os -mshort main.c

main.o: main.s
	$(AS)   -a=main.lst --gstabs -o main.o main.s

main.elf: main.o $(SRC).o
	$(LD)  -O0 --verbose -N -mshort -mm68hc11elfb main.o $(SRC).o -o main.elf

submit:
	@echo "Nothing to submit"
