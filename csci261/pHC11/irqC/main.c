void irqCount(void) __attribute__((trap));
unsigned char COUNT;

unsigned char main() {
  __asm__("cli"); /* enable interrupts */
  while (1);
  return (0);
}

void irqCount(void) {
	COUNT=COUNT+1;
__asm__("xirqCount:"); /* insert an exit label for testing purposes */
}
