from copy import deepcopy

def main():
    myset = [2,3,5,7,11,17]
    for i in choose(myset):
        print(i)
    return
    for i in range(len(myset)):
       choose(myset,i)

def choose(collection):
    if len(collection) == 1:
        yield collection
        return
    for subset in choose(collection[1:]):
        yield subset
##        for i, item in enumerate(subset):
##            # create a set with this item or not
##            return
            

# returns all possible choices of a set
def choose1(choices, num,choice=[],remainder=[]):
   if len(choices) < num:
      return
   if num == 0:
      print(choice, remainder + choices)
   else:
      #we choose the first element, or not
      choose(choices[1:],num-1,choice+[choices[0]],remainder)
      choose(choices[1:],num,choice,remainder+[choices[0]])
    
# prints all binary numbers of length n
def binaries(n,start=""):
    if n == 0:
        print(start)
        return 
    binaries(n-1,start+"0")
    binaries(n-1,start+"1")
    
main()
