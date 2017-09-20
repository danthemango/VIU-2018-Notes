# How many arrangements of the letters ABCDxxxxxxxxxx are three if no two (capitals) can be consecutive?
total = 0
word2 = "ABGDxxxxxxxxxx"
def main():
    getPerms(word2)
    print(total)

# returns each combination of double letters possible
# (like permutations of any 2 letters, but I didn't want to rewrite the other function. Sue me)
def getDoubles(string):
    theDoubles = []
    for i in range(len(string)):
        remainder = string[:i]+string[i+1:]
        for letter in remainder:
            # join the two letters together
            theDoubles.append(string[i]+letter)
    return theDoubles

badchoices = getDoubles("ABGD")

def getCounts(s):
    # transform a string into a dictionary of letters and counts
    letters = ""
    letterCounts = {}
    for l in s:
        if l not in letters:
            letters +=l
            letterCounts[l]=1
        else:
            letterCounts[l]+=1
    return letterCounts 

#pass permutations from counts
def getPermsFromC(word,counts):
    # ensure no two greek letters are together
    global badchoices
    for badchoice in badchoices:
        if badchoice in word:
            return
    global total
    #print counts
    numchoices = 0
    for l in counts:
        if counts[l] != 0:
            # ensure three i's are together
            numchoices = counts[l]
            newCounts = dict(counts)
            newCounts[l] -= 1
            getPermsFromC(word+l,newCounts)
    if numchoices == 0:
        total+=1
        print(word,)
        if total % 1 == 0:
            print("")
##        if total % 10000 == 0:
##            print(otal, word)
            
            
#get permutations from string
def getPerms(s):
    getPermsFromC("",getCounts(s))

main()
