# Makefile to drive cew testing of asm code using gdb
# P Walsh Feb 2001
# Revised Jan 2004

# Targets
#   interactive --- assemble program under test and load into gdb
#   bats --- make batch tester from bats.script
#   clean

# executable file name
EXE=swap

# all source file name(s) (assumed extension of .s)
SRC=swap

# all generated object file name(s)
OBJ=swap.o

# directory where scripts are located and temp files
SD=CewDir

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
WOK=/home/pwalsh/bin/wookie167.exe

interactive: $(EXE).elf
	$(GDB) $(EXE).elf

bats.gdb: bats.script
	rm -f $(SD)/tmp/bats.gdb
	perl $(SD)/bin/addLineNums.pl bats.script > $(SD)/tmp/bats.num
	m4 $(SD)/tmp/bats.num | $(INDENT)  > bats.gdb

clean:
	rm -f *.o *.elf *.s19 *.gdb *.lst $(EXE) $(SD)/tmp/*

bats:	$(EXE).elf bats.gdb
	$(GDB) $(XDBF) bats.gdb $(EXE).elf | $(SD)/bin/filterOutput.pl

$(EXE).elf: impMod 
	$(LD)  -O0 --verbose -N -mshort -mm68hc11elfb $(OBJ) -o $(EXE).elf
	$(OC) -O srec --only-section=.text --only-section=.data $(EXE).elf $(EXE).s19

impMod:
	if (test "$(SRC)" != "none") then \
		for m in $(SRC); do \
			($(AS)   -al=$$m.lst --gstabs -o $$m.o  $$m.s) \
		done \
	fi

wookie: $(EXE).elf
	(wine $(WOK) 2> /dev/null  &)

submit:
	@echo "nothing to submit for the $(SRC) example"
