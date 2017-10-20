all: testprog 

testprog: obj/main.o obj/Set.o obj/Object.o
	gcc -Wall $^ -o $@

obj/%.o: %.c
	gcc -Wall -c $^ -o $@
