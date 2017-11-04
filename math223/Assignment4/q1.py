# VIU MATH223 Assignment4
# note the recurrence and the function should generate the same results
# that's what "solve a recurrence" means

import argparse

# recurrence evaluated by a 
def recurrence(n):
    if(n <= 0):
        return 1
    elif(n == 1):
        return 3
    else:
        return 5*recurrence(n-1) + 6*recurrence(n-2)

def function(n):
    return (3/7)*(-1)**n + (4/7)*(6)**n

if __name__ == "__main__":
    print("VIU MATH223 Assignment4")
    print("n, recurrence, function, difference")
    for i in range(20):
        print(i,",", recurrence(i),",", round(function(i)),",", recurrence(i) - round(function(i)))
