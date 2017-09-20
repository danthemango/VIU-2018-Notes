unsigned char foo(unsigned char);

unsigned char main() {
  unsigned char c;
  c=foo(3);
  return (0);
}

unsigned char foo(unsigned char i) {
   return ++i;  
}

