/* Templage for csci 261 Pex 3 */

extern strStr;

void  wstr(char *);
void  wcrlf(void);

void _start(void) {

  __asm__("lds #_stack");	

  wstr((char *) &strStr);
  wcrlf();

  __asm__("swi");
}

__asm__("strStr: .ascii \"Write a string\" \n .byte 0x4 \n");
