import argparse
\
        # number of rows for a block
height=3

def main():
    parser = argparse.ArgumentParser(description="MATH223 Ass.4: print the checkerboards of size 2xN (given by -n), covered only by square and corner tiles")
    parser.add_argument('-n', '--num', metavar='N', help="print boxes of size 2xN", type=int, required=True, default=4)
    parser.add_argument('-c', '--cols', metavar='N', help="number of boxes to print before a linebreak", type=int, required=False, default=4)
    args = parser.parse_args() 
    num = args.num # number of boxes
    cols = args.cols # number of columns (boxes per row)
    print("printing all possible ways to tile a 2 x", num,"checkerboard with only squares and corner tiles")
    # grab the boxes
    boxarr = [box for box in getBox(num)]
    print("there are",len(boxarr),"ways to do this")
    numrows = int(len(boxarr)/cols)
    if(len(boxarr)%cols!=0):
        numrows+=1
    # and print them
    # a row here is a set of boxes
    for row in range(numrows):
        # a boxrow is a row *within* a single box
        for boxrow in range(height):
            # grab up to 'cols' number of boxes and print them
            for box in boxarr[row*cols:(1+row)*cols]:
                print(box[boxrow], end='')
            print()

# list of patterns to use
patterns = [
        # all possible patterns of length 1
        [
            "┌┐",
            "├┤",
            "└┘"],
        # all patterns of length 2 which cannot be constructed by smaller patterns
        [
            "┌┬┐",
            "│└┤",
            "└─┘"],
        [
            "┌─┐",
            "│┌┤",
            "└┴┘"],
        [
            "┌─┐",
            "├┐│",
            "└┴┘"],
        [
            "┌┬┐",
            "├┘│",
            "└─┘"],
        # all patterns of length 3 which cannot be constructed by smaller patterns
        [
            "┌┬─┐",
            "│└┐│",
            "└─┴┘"],
        [
            "┌─┬┐",
            "│┌┘│",
            "└┴─┘"],
        ]

# iterator which returns box string arrays
# (note, first element is the top row, second is the middle and the last is the bottom)
def getBox(size, start=["","",""]):
    if(size == 0):
        yield start
    else:
        for pattern in patterns:
            patternWidth = len(pattern[0])-1
            if(patternWidth<=size):
                yield from getBox(size-patternWidth,stitch(pattern,start))

# combinther two sets of checkerboard patterns
def stitch(start, addition):
    return [stitchString(startString,additionString) for startString,additionString in zip(start,addition)]

# returns stitched together strings
def stitchString(start,end):
    if(len(start)==0):
        return end
    elif(len(end)==0):
        return start
    else:
        return start[:-1] + stitchChar(start[-1],end[0]) + end[1:]

# returns the relevant character to stitch the two ends togethr
def stitchChar(first, second):
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
