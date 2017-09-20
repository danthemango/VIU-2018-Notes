from math import sqrt
from math import factorial as f
from copy import deepcopy
total = 0

def main1():
    distr([[2], [3], [5]],[7, 11, 13, 17])

def main():
    endNum = 510510
    factors = getprimefactors(endNum)
    countThreeFactors(factors)
    global total
    print(total)

def countThreeFactors(factors):
    # pick three factors and iterate over them
    for i in range(len(factors)):
        ifactors = factors[:i] + factors[i+1:]
        for j in range(len(ifactors)):
            jfactors = ifactors[:j] + ifactors[j+1:]
            for k in range(len(jfactors)):
                kfactors = jfactors[:k] + jfactors[k+1:]
                sets = [[factors[i]], [ifactors[j]], [jfactors[k]]]
                #print sets, kfactors
                distr(sets, kfactors)

def distr(sets,remains):
    # how many elements go into the first element of the set
    for i in range(len(remains)):
        print(i)

#distribute the remains among the sets
def orddistr(sets, remains):
    print(sets, remains)
    return
    if len(remains) == 0:
        global total; total+=1
        if sets[0] == [3] and sets[2] == [17]:
           print(sets, [mult(subset) for subset in sets], mult(sets))
        return
    for i in range(len(remains)):
        for j in range(len(sets)):
            newset = deepcopy(sets)
            # add the last elements to the set if we are only considering the final set
            if j == len(sets)-1:
                newset[j].extend(remains)
                distr(newset,[])
                return
            newremains = remains[:i]+remains[i+1:]
            newset[j].append(remains[i])
            distr(newset,newremains)
            
# multiplies all numbers in array
def mult(arr):
    num = 1
    for i in arr:
        if isinstance(i, list):
            num *= mult(i)
        else:
            num *= i
    return num

#returns true if i has factors
def hasfactors(i):
    if i % 2 == 0 and i > 2:
        return True
    for j in range(3,int(sqrt(i))+1,2):
        if(i%j == 0):
            return True
    return False

# returns list of all prime factors of the number
def getprimefactors(num):
    factors = []
    for i in range(2,int(sqrt(num))):
        if not hasfactors(i) and num % i == 0:
            factors.append(i)
    return factors

main()
