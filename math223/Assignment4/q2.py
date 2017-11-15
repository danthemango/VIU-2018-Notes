# VIU MATH223 Assignment4 Question2
# solve the recurrence a_n+1 = a_n + 3n^2 -n for n>=0 and a_0=3

import argparse

def a(n):
    if(n <= 0):
        return 3
    else:
        m = n-1
        return a(m) + 3*m**2 - m

def ah(n):
    return 3

def ap(n):
    m = 1
    beta2 = 1
    beta1 = -2
    beta0 = 1
    t = 1
    return n**m*(beta2*n**2 + beta1*n + beta0)*t**n

def af(n):
    return ah(n) + ap(n)

if __name__ == "__main__":
    print("VIU MATH223 Assignment4 Question2")
    print("i, recurrence, particular, difference")
    for i in range(30):
        print(i, a(i), af(i), af(i) - a(i));
