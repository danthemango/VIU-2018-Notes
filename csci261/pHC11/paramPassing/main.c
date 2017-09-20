unsigned char foo(unsigned char i, unsigned char j, unsigned char k);


unsigned char _start(void) {
  
  return foo(1,2,3);
}


unsigned char foo(unsigned char i, unsigned char j, unsigned char k) { 
   return ( (i+j)  - k ); 
}
