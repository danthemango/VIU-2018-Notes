/**********************************************
* Filename:   Lifo.h
* Author:     Daniel Guenther (565154853)
* Date:       2017-10-19
* Class:      CSCI 485
* Project:    lab04: Lifo in C
************************************************/

#ifndef LIFO_H
#define LIFO_H

/* using a linked list to store the scalars */
#define NONODE 0 /* pointer to nothing, for error checking */
typedef struct node node;
struct node {
   /* member element */
   int el;
   /* pointers to the previous and next nodes */
   node* next;
   node* prev;
};

/* a lifo is just a stack */
/* use new_lifo() to create one */
/* use destroy_lifo(lifo*) to destroy it */
typedef struct {
   node* tail;
   /** private members **/
   int size;
   int maxsize;
} Lifo;

/* optional parameter preprocessor hack inspired by https://gustedt.wordpress.com/2010/06/08/detect-empty-macro-arguments/ */
/* use '$ gcc -E <thisfile>.c' to take a look at what the proprocessor actually makes */

/* the gist of this hack is that I'm sticking VA_ARGS (the arguments given by '...' in a macro
 * function) inbetween PUT_COMMA and '()', which means that the PUT_COMMA function only runs
 * if VA_ARGS happen to be completely empty. I can use HAS_COMMA to check if PUT_COMMA has ran.
 * This extra comma will determine if HAS_COMMA has exactly 1 argument or 2, which means that
 * if I run it with "VA_ARGS, 0, 1" either 0 or 1 is the third argument.
 *
 * then I can append that 0 or 1 to the end of "lifo", and I can run either _lifo_1 or
 * _lifo_0 depending on if exactly 1 or 0 arguments has been given to "lifo"
 */

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

/* lifo constructors */
/* define new_lifo() as a macro with an optional parameter */
#define new_lifo(...) EXPAND_AND_APPEND(_new_lifo,HASARG(__VA_ARGS__))(__VA_ARGS__)
Lifo * _new_lifo_1(int arg);
Lifo * _new_lifo_0();
/* lifo destructor */
void destroy_lifo(Lifo* _self);
/* returns the size of the lifo */
int size(Lifo* _self);
/* inserts element on the top of the lifo */
void push(Lifo* _self, int scalar);
/* pops the top of the stack */
void pop(Lifo* _self);
/* returns the top of the stack */
int top(Lifo* _self);

#endif
