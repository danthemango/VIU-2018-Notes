import argparse
\
# number of rows for a block
height=3

def main():
   parser = argparse.ArgumentParser(description="MATH223 Ass.4: print the checker boards of size 2xN (given by -n), covered only by square and corner tiles");
   parser.add_argument('-n', '--num', metavar='N', help="print boxes of size 2xN", type=int, required=True, default=4)
   parser.add_argument('-c', '--cols', metavar='N', help="number of boxes to print before a linebreak", type=int, required=False, default=4)
   args = parser.parse_args()
   num = args.num
   cols = args.cols
   print("printing all possible boxes of size 2 x", num)
   boxarr = [box for box in getBox(num)]
   numrows = int(len(boxarr)/cols)
   if(len(boxarr)%cols!=0):
       numrows+=1
   # a row is a set of boxes
   for row in range(numrows):
       # a boxrow is a row *within* a single box
       for boxrow in range(height):
           # grab up to 'cols' number of boxes
           for box in boxarr[row*cols:(1+row)*cols]:
               print(box[boxrow], end='')
           print()

# iterator which returns box string arrays
# (note, first element is the top row, second is the middle and the last is the bottom)
def getBox(size, start=["","",""]):
    if(size == 0):
        yield start
    if(size >= 1):
        for i in range(s1NumPatterns):
            yield from getBox(size-1, getStitchBlocks(start,s1(i)))
    if(size >= 2):
        for i in range(s2NumPatterns):
            yield from getBox(size-2, getStitchBlocks(start,s2(i)))
    if(size >= 3):
        for i in range(s3NumPatterns):
            yield from getBox(size-3, getStitchBlocks(start,s3(i)))

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
