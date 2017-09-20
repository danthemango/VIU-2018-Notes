# Makefile to drive cew testing of asm code using gdb
# P Walsh Feb 2001

# Targets
#   interactive --- assemble program under test and load into gdb
#   bats --- make batch tester from bats.script
#   clean

# source file
SRC=bHelloWorld

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

interactive: $(SRC).elf
	$(GDB) $(SRC).elf

bats.gdb: bats.script
	rm -f $(SD)/tmp/bats.gdb
	perl $(SD)/bin/addLineNums.pl bats.script > $(SD)/tmp/bats.num
	m4 -B20000  $(SD)/tmp/bats.num | $(INDENT)  > bats.gdb

clean:
	rm -f *.o *.elf *.s19 *.gdb *.lst $(SD)/tmp/*

bats:	$(SRC).elf bats.gdb
	$(GDB) $(XDBF) bats.gdb $(SRC).elf | $(SD)/bin/filterOutput.pl

$(SRC).o: $(SRC).s
	$(AS)   -al=$(SRC).lst --gstabs -o $(SRC).o $(SRC).s

$(SRC).elf: $(SRC).o
	$(LD)  -O0 --verbose -N -mshort -mm68hc11elfb $(SRC).o -o $(SRC).elf
	$(OC) -O srec --only-section=.text $(SRC).elf $(SRC).s19

submit:
	@echo "nothing to submit for the $(SRC) example"
