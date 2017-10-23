/* optional parameter preprocessor inspired by https://gustedt.wordpress.com/2010/06/08/detect-empty-macro-arguments/ */
/* use '$ gcc -E <thisfile>.c' to take a look at what the proprocessor actually makes */

/* the gist of this hack is that I'm sticking VA_ARGS (the arguments given by '...' in a macro
 * function) inbetween PUT_COMMA and '()', which means that the PUT_COMMA function only runs
 * if VA_ARGS happen to be completely empty. I can use HAS_COMMA to check if PUT_COMMA has ran.
 * This extra comma will determine if HAS_COMMA has exactly 1 argument or 2, which means that
 * if I run it with "VA_ARGS, 0, 1" either 0 or 1 is the third argument.
 *
 * then I can append that 0 or 1 to the end of "hello", and I can run either _hello_1 or
 * _hello_0 depending on if exactly 1 or 0 arguments has been given to "hello"
 */

#include <stdio.h>
/* resolves to the third argument given */
#define GET_THIRD_ARG(_0, _1, _2, ...) _2
/* 0 if '...' has a comma */
#define HAS_COMMA(...) GET_THIRD_ARG(__VA_ARGS__, 0, 1)
/* resolves to a comma */
#define PUT_COMMA() ,
/* 0 if '...' is empty, 1 otherwise */
#define HASARG(...) HAS_COMMA(PUT_COMMA __VA_ARGS__ ())
/* concatenates the arguments as strings */
#define APPEND(_0, _1) _0 ##_##_1
/* expands then concatenates the arguments */
#define EXPAND_AND_APPEND(_0,_1) APPEND(_0, _1)

/* define hello as an optional parameter function */
#define hello(...) EXPAND_AND_APPEND(_hello,HASARG(__VA_ARGS__))(__VA_ARGS__)

void _hello_1(int arg){
   printf("your argument was: %d\n", arg);
}

void _hello_0(){
   const int default_arg = 5;
   _hello_1(default_arg);
}

int main(){
   hello(1);
   hello();
}
