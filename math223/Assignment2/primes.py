import math
import argparse

def main():
   parser = argparse.ArgumentParser(description="print a bunch of primes");
   parser.add_argument('-m', '--max', metavar='N', help="check primes up to N", type=int, required=False, default=1000)
   parser.add_argument('-c','--count', help="count mode, if selected it will only print number of primes", action='store_true', default=False);
   args = parser.parse_args()
   printMode = not args.count
   printFactors(args.max, printMode)

# prints all possible factors up to N
# and prints them if printMode is true
def printFactors(N, printMode=True):
   numPrimes=0
   for i in range(2,N):
      if(not hasFactors(i)):
         numPrimes += 1
         if(printMode):
            print(i)
   if(printMode):
      print
   print("there are " + str(numPrimes) + " Primes up to " + str(N))

# returns true if N has factors
def hasFactors(N):
   if(N <= 1):
      return False

   for i in range(2,int(math.sqrt(N))+1):
      if(N % i == 0):
         return True

# A function to print all prime factors of 
# a given number n
def primeFactors(n):

   # Print the number of two's that divide n
   while n % 2 == 0:
      print(2)
      n = n / 2

   # n must be odd at this point
   # so a skip of 2 ( i = i + 2) can be used
   for i in range(3,int(math.sqrt(n))+1,2):

      # while i divides n , print i ad divide n
      while n % i== 0:
         print(i)
         n = n / i

   # Condition if n is a prime
   # number greater than 2
   if n > 2:
      print(n)

   print()

if __name__ == "__main__":
   main()
