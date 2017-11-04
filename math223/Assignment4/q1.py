# VIU MATH223 Assignment4

import argparse

def a(n):
    if(n <= 0):
        return 1
    elif(n == 1):
        return 3
    else:
        return 5*a(n-1) + 6*a(n-2)

def a2(n):
    return (3/7)*(-1)**n + (4/7)*(6)**n

if __name__ == "__main__":
    print("VIU MATH223 Assignment4 Question2")
    for i in range(20):
        print(i, a(i), round(a2(i)), a(i) - round(a2(i)))
