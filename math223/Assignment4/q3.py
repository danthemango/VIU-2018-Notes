# VIU MATH223 Assignment4

import argparse
from math import sqrt as sq

def a(n):
    if(n <= 0):
        return 1
    elif(n == 1):
        return 11
    else:
        return 4*a(n-1) + 28*a(n-2)

def a2(n):
    return ((9*sq(2))/16 + .5) * ((2 + 4*sq(2))**n) + (.5 - (9*sq(2))/16) * ((2 - 4*sq(2))**n)

if __name__ == "__main__":
    print("VIU MATH223 2017 Assignment4")
    for i in range(20):
        print("recurrence:", a(i))
        print("function:  ", int(a2(i)))
