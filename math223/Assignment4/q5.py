# VIU MATH223 Assignment4

import argparse

def a(n):
    if(n <= 0):
        return 1
    elif(n == 1):
        return 6
    else:
        return 3*a(n-1) - 2*a(n-2)

def a2(n):
    return 5*2**n - 4

if __name__ == "__main__":
    print("VIU MATH223 2017 Assignment4")
    print("i, recurrence, function, difference")
    for i in range(20):
        print(i, a(i), round(a2(i)), a(i) - round(a2(i)))
