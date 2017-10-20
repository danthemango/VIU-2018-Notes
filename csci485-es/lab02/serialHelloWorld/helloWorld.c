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
int main ()
{
   serial_init();
   serial_print("Hello Squirrel World\n\r");
   __asm__("swi");
   return 0;
}
