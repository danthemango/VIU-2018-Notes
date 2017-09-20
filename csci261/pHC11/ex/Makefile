# Makefile to drive cew testing of asm code using gdb
# P Walsh Feb 2001

# Targets
#   interactive --- assemble program under test and load into gdb
#   bats --- make batch tester from bats.script
#   clean
#   submit -- submit assignment code

# source file (there should also be a main)
SRC=

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
LD=m6811-elf-ld
GDB=m6811-elf-gdb
OC=m6811-elf-objcopy


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

#$(SRC).o: $(SRC).s
#	$(AS)   -a=$(SRC).lst --gstabs -o $(SRC).o $(SRC).s

main.o: main.s
	$(AS)   -a=main.lst --gstabs -o main.o main.s

main.elf: main.o 
	$(LD)  -O0 --verbose -N -mshort -mm68hc11elfb main.o -o main.elf
	$(OC) -O srec --only-section=.text --only-section=.data main.elf main.s19


submit:
	@echo "Nothing to submit"
