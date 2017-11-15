# VIU MATH223 Assignment4

import argparse
from math import sqrt as sq

def a(n):
    if(n <= 1):
        return 1
    elif(n == 2):
        return 5
    elif(n == 3):
        return 11
    else:
        return a(n-1) + 4*a(n-2) + 2*a(n-3)

def a2(n):
    alpha1 = 1
    alpha2 = (1/sq(3))
    alpha3 = -(1/sq(3))
    root1 = -1
    root2 = 1+sq(3)
    root3 = 1-sq(3)
    return alpha1*root1**n + alpha2*root2**n + alpha3*root3**n


if __name__ == "__main__":
    print("VIU MATH223 2017 Assignment4")
    for i in range(20):
        print("recurrence:", a(i))
        print("function:  ", round(a2(i)))
