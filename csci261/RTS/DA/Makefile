# Makefile to manage vnet
# P Walsh Jan 2016

# Targets
#   interactive
#   clean --- clean all modules
#   tidy --- indent code in all modules 
#   runtest --- run bats in all modules
#   cover --- run cover in all modules

# directory where scripts are located and temp files
SD=../../../Cew

MODULES=Demo/Verification/Lifo \
        Exc/Verification/Exception \
        Exc/Verification/TryCatch

clean:
	@for m in $(MODULES); do \
		((cd $$m; $(MAKE) clean;) > /dev/null) \
	done

tidy:
	@for m in $(MODULES); do \
		((cd $$m; $(MAKE) tidy;) > /dev/null 2>&1) \
	done


runtest:
	@for m in $(MODULES); do \
		(cd $$m; $(MAKE) bats;) \
	done

cover:
	@for m in $(MODULES); do \
		(cd $$m; $(MAKE) cover;) \
	done

