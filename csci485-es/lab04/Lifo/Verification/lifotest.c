/******************************************
 * Author:     Daniel Guenther (565154853)
 * Date:       2017-10-26
 * Class:      CSCI 485
 * Project:    lab05: Lifo in C
 ******************************************/

#include <stdio.h>
#include "../Lifo.h"

/* print instructions for this program */
void print_help();

int main ()
{
   /* create Lifo tester */
   Lifo* myLifo = new_lifo();

   printf("=== Lifo tester ===\n");
   printf("type 'h' for help\n");
   /* grab char from user */
   char c;
   do{
      printf("> ");
      scanf(" %c", &c);
      switch(c){
         case('h'):
            print_help();
            break;
         case('s'):
            printf("lifo size is %d\n", size(myLifo));
            break;
         case('u'):
            printf("pushing num: ");
            int num;
            scanf("%d", &num);
            push(myLifo, num);
            break;
         case('p'):
            pop(myLifo);
            break;
         case('t'):
            printf("top: %d\n", top(myLifo));
            break;
         case('q'):
            destroy_lifo(myLifo);
            return 0;
            break;
         default:
            printf("ERR: invalid command\n");
            break;
      }
   }while(c != 'q');
   return 0;
}

/* print instructions for this program */
void print_help(){
   printf("h - print help\n");
   printf("s - print the size of the lifo\n");
   printf("u - push an element on the top of the lifo\n");
   printf("p - pop an element from the lifo\n");
   printf("t - print the element at the top of the lifo\n");
   printf("q - quit\n");
}
