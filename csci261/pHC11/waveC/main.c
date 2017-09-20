       /*============================================-=
       ; Behaviour: 
       ;      Generates a square wave with a 40% duty cycle
       ;      using polling   (see text page 366)
       ;      C demonstration version (with magic numbers)
       ;
       ; Assumptions:
       ;      none
       ; Board:
       ;      CME11-E9-EVBU
       ; Author/Date:
       ;      Peter Walsh Feb 2001
       ;      revised Feb 2002
       ;========================================== */


#define porta *(volatile unsigned char *)(0x1000)
#define toc2 *(volatile short int *)(0x1018)
#define tcnt *(volatile short int *)(0x100e)
#define tctl1 *(volatile unsigned char *)(0x1020)
#define tflg1 *(volatile unsigned char *)(0x1023)

#define highTicks 800
#define lowTicks 1200

#define oc2 0x40
#define toggle 0x40
#define clear 0x40

unsigned char _start(void) {

   porta |= oc2;
   tctl1 = toggle;
   toc2 = tcnt + highTicks;
   tflg1 = clear;
   while (1) {
	   while (!(tflg1 & clear));
	   tflg1 = clear;
	   toc2 =toc2 + lowTicks;
	   while (!(tflg1 & clear));
	   tflg1 = clear;
	   toc2 = toc2 + highTicks;
   }
   return 0;
}
