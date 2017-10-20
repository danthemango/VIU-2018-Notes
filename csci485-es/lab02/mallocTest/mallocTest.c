/*************************************************************
* Filename:   helloWorld.c
* Author:     Daniel Guenther (565154853)
* Date:       2017-09-21
* Class:      CSCI 485
* Project:    lab02
* Purpose:    simple example of C code compilation to the HC11
* Source:     Implementation details identified by reading 
*             source code in the GEL exaples, especially simple.c
*             note: the libraries provided by the GEL are required
*             for the compilation of this program
*************************************************************/

#include <sys/sio.h>
#include <sys/interrupts.h>
#include <stdlib.h>
#include <string.h>
//#include <stdio.h>

void printC(char c);

int main ()
{
   serial_init();

   char mystring[] = "hello";
   char mystring2[] = "world";

   printC(mystring[0]);
   serial_print("\n");
   return 0;


   char c = serial_recv();
   char* buffer;
   char* buffer2;
   int bufsize = 6;
   buffer = (char*) malloc(bufsize);
   buffer2 = (char*) malloc(bufsize);
   strcpy(buffer,mystring);
   strcpy(buffer2,mystring2);
   serial_print(buffer);
   serial_print("\n\r");
   serial_print(buffer2);
   free(buffer);
   free(buffer2);

   __asm__("swi");
   return 0;
}

// prints one char
void printC(char c)
{
   char mystr[] = "c";
   mystr[0] = c;
   serial_print(mystr);
   return;
}
