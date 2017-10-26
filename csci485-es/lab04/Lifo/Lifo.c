#include "Lifo.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

const int LIFO_DEFAULT_SIZE = 5;

/* creates a new lifo */
Lifo* _new_lifo_1(int maxsize){
   Lifo * _self = (Lifo*) malloc(sizeof(Lifo));
   assert(_self); /* ensure pointer was assigned */
   _self->maxsize = maxsize;
   _self->size = 0;

   /* create dummy node as tail */
   node* dummyNode = (node*) malloc(sizeof(node));
   dummyNode->el = 0;
   dummyNode->next = NONODE;
   dummyNode->prev = NONODE;
   _self->tail = dummyNode;
   return _self;
}
/* create lifo of default size */
Lifo* _new_lifo_0(){
   return _new_lifo_1(LIFO_DEFAULT_SIZE);
}
/* destroys a lifo object */
void destroy_lifo(Lifo* _self){
   /* recursively delete nodes from the tail back */
   while(_self->tail != NONODE){
      node* temp = _self->tail;
      _self->tail = _self->tail->prev;
      free(temp);
   }
   free(_self);
}
/* returns the size of the lifo */
int size(Lifo* _self){
   return _self->size;
}
/* inserts element on the top of the lifo */
void push(Lifo* _self, int scalar){
   /* increment Lifo size if possible */
   assert(_self->maxsize != _self->size);
   _self->size++;

   /* create new node and put on top of stack */
   node* newNode = (node*) malloc(sizeof(node));
   newNode->el = scalar;

   /* set new node as tail of list */
   _self->tail->next = newNode;
   newNode->prev = _self->tail;
   _self->tail = newNode;
   newNode->next = NONODE;
}
/* pops the top of the stack */
void pop(Lifo* _self){
   /* decrement size if possible */
   assert(_self->size != 0);
   _self->size--;

   /* remove tail node */
   node* temp = _self->tail;
   _self->tail = _self->tail->prev;
   free(temp);
   _self->tail->next = NONODE;
}
/* returns the top of the stack */
int top(Lifo* _self){
   /* ensure there is something on the stack */
   assert(size != 0);
   return _self->tail->el;
}
