/* Buffalo i/o library Starting Point */

extern char strStr[];

#include "foolib.h"

void _start(void) {

  __asm__("lds #_stack");	

  wstr((char *) &strStr);
  wcrlf();

  strStr[1] = 'X';
  wstr((char *) &strStr);
  wcrlf();

  __asm__("swi");
}

__asm__("strStr: .ascii \"Hello World\" \n .byte 0x4 \n");
