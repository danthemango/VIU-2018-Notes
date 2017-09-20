# Makefile to drive cew testing of asm code using gdb
# P Walsh Feb 2001

# Targets
#   interactive --- assemble program under test and load into gdb
#   bats --- make batch tester from bats.script
#   clean

# source file
SRC=pex2

# directory where scripts are located and temp files
SD=CewDir
KITNUM=kit55
PORTNUM=3000

# code beautifier 
INDENT=cat

# version of awk
AWK=awk 

# extra debugger flags
XDBF=-batch -x 

# tools 
AS=m68hc11-as
LD=m68hc11-ld
GDB=m68hc11-gdb
OC=m68hc11-objcopy

$(SRC).elf: $(SRC).o
	$(LD)  -O0 -N -mshort -mm68hc11elfb $(SRC).o -o $(SRC).elf
	$(OC) -O srec --only-section=.text $(SRC).elf $(SRC).s19

load: $(SRC).elf
	term11 -m $(KITNUM) -p $(PORTNUM) -f $(SRC).s19

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
	$(AS)   -a=$(SRC).lst --gstabs -o $(SRC).o $(SRC).s

submit:
	@echo "nothing to submit for the $(SRC) example"

get:
	cp ~hogmannf/csci261/HC11/waveA/wave.s natPex2.s
