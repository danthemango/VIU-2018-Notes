import argparse

def main():
   parser = argparse.ArgumentParser(description="MATH223 Ass.4: print the checker boards of length n");
   parser.add_argument('-n', '--num', metavar='N', help="print a box of size n", type=int, required=True, default=4)
   args = parser.parse_args()
   num = args.num
   print("printing box of size", num)
#   for i in range(s2NumPatterns):
#       newBlocks = getStitchBlocks(s1(0),s2(i))
#       printBlocks(newBlocks)
   printBox(num)

def printBox(num, start=["","",""]):
    if(num == 0):
        printBlocks(start)
        return
    if(num >= 1):
        for i in range(s1NumPatterns):
            printBox(num-1, getStitchBlocks(s1(i),start))
    if(num >= 2):
        for i in range(s2NumPatterns):
            printBox(num-2, getStitchBlocks(s2(i),start))
    if(num >= 3):
        for i in range(s3NumPatterns):
            printBox(num-3, getStitchBlocks(s3(i),start))

# returns a 2x1 checkerboard
#   ┌┐
# 0:├┤
#   └┘
s1NumPatterns = 1
def s1(num):
    if(num == 0):
        return ["┌┐","├┤","└┘"]
    else:
        return ["","",""]

# returns a 2x2 checkerboard
# (only the ones which cannot be created by combining smaller patterns)
#   ┌┬┐   ┌─┐   ┌─┐   ┌┬┐
# 0:│└┤ 1:│┌┤ 2:├┐│ 3:├┘│
#   └─┘   └┴┘   └┴┘   └─┘
s2NumPatterns = 4
def s2(num):
    if(num == 0):
        return ["┌┬┐","│└┤","└─┘"]
    elif(num == 1):
        return ["┌─┐","│┌┤","└┴┘"]
    elif(num == 2):
        return ["┌─┐","├┐│","└┴┘"]
    elif(num == 3):
        return ["┌┬┐","├┘│","└─┘"]
    else:
        return ["","",""]

# returns a 2x3 checkerboard
# (only the ones which cannot be created by combining smaller patterns)
#   ┌┬─┐    ┌─┬┐
# 0:│└┐│  1:│┌┘│
#   └─┴┘    └┴─┘
s3NumPatterns = 2
def s3(num):
    if(num==0):
        return ["┌┬─┐","│└┐│","└─┴┘"]
    elif(num==1):
        return ["┌─┬┐","│┌┘│","└┴─┘"]
    else:
        return ["","",""]

# prints the set of blocks given
def printBlocks(strings):
    for row in strings:
        print(row)

# combines together two sets of checkerboard patterns
def getStitchBlocks(start, addition):
    return [getStitchString(row[0], row[1]) for row in zip(start,addition)]

# returns stitched together strings
def getStitchString(start,end):
    if(len(start)==0):
        return end
    elif(len(end)==0):
        return start
    else:
        return start[:-1] + getStitchChar(start[-1],end[0]) + end[1:]

# returns the relevant character to stitch the two ends togethr
def getStitchChar(first, second):
    # stitch the top corners together
    if(first=="┐" and second=="┌"):
        return "┬"
    # stitch the bottom corners
    elif(first=="┘" and second=="└"):
        return "┴"
    # stitch the middles
    elif(first=="│" and second=="│"):
        return "│"
    elif(first=="┤" and second=="│"):
        return "┤"
    elif(first=="│" and second=="├"):
        return "├"
    elif(first=="┤" and second=="├"):
        return "┼"
    else:
        return " "

if __name__ == "__main__":
   main()
