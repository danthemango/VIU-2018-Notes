# Makefile to drive fsm translation  
# By: pwalsh

# P Walsh Sept 2017 

# Targets 
#   translate   translate *.moore to *.pm
#   tidy 

# directory where scripts are located and temp file
MM=../MooreMT

# code beautifier 
INDENT=perltidy -i=3 

MMTSRC = $(wildcard *.moore)
MMTBNAME = $(basename $(MMTSRC))
MMTDEST = $(addsuffix .pm, $(MMTBNAME))

%pm: %moore
	@rm -f ./$@
	@m4 -I $(MM)/bin $< | $(INDENT)  > $@

translate: $(MMTDEST) 

tidy:
	@$(INDENT) $(CUT) *.pm *.moore
