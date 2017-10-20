# Makefile to manage tosf
# P Walsh Aug 2017

# Targets
#   interactive
#   clean --- clean all modules
#   tidy --- indent code in all modules 
#   runtest --- run bats in all modules
#   cover --- run cover in all modules

TAGS=

# directory where scripts are located and temp files
SD=../../../Cew

MODULES=Demo/Verification/Lifo \
        Event/Verification/IDLE  \
        Record/Verification/Task \
        Record/Verification/Semaphore \
        Record/Verification/SVar \
        Table/Verification/SVAR \
        Table/Verification/SEMAPHORE \
        Table/Verification/TASK \

pc_interactive: pc.pl
	@((cd ./Fsm; $(MAKE) translate;) > /dev/null 2>&1)
	perl $(TAGS) pc.pl


tl_interactive: tl.pl
	@((cd ./Fsm; $(MAKE) translate;) > /dev/null 2>&1)
	perl tl.pl


clean:
	@for m in $(MODULES); do \
		((cd $$m; $(MAKE) clean;) > /dev/null) \
	done

tidy:
	@for m in $(MODULES); do \
		((cd $$m; $(MAKE) tidy;) > /dev/null 2>&1) \
	done


runtest:
	@((cd ./Fsm; $(MAKE) translate;) > /dev/null 2>&1)
	@for m in $(MODULES); do \
		(cd $$m; $(MAKE) bats;) \
	done

cover:
	@for m in $(MODULES); do \
		(cd $$m; $(MAKE) cover;) \
	done

