progname=lifoTest

all: $(progname)

$(progname): obj/main.o obj/Lifo.o obj/Object.o
	gcc -Wall $^ -o $@

obj/%.o: %.c
	gcc -Wall -c $^ -o $@

clean:
	rm -f obj/* lifotest

again: clean all
