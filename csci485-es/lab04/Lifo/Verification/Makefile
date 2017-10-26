progname=lifotest

all: $(progname)

$(progname): lifotest.c ../obj/Lifo.o
	gcc -Wall $^ -o $@

../obj/%.o: ../%.c
	gcc -Wall -c $^ -o $@

clean:
	rm -f ../obj/* lifotest

runtest: $(progname)
	bash tester.sh $<

# save all outputs as expectation files
saveExp: tstexp tstout
	for f in tstout/*.out; do mv $$f tstexp/$$(basename tstout/$${f%.out}.exp); done

again: clean all
