total = 0
word1 = "statisticians"
word2 = "ABGDxxxxxxxxxx"
def main():
    getPerms(word1)
    print(total)

def getCounts(s):
    # transform a string into a list of letters and counts
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
    # ensure word always never has a t before an s
    if 't' in word and 's' not in word:
        return
    global total
    #print counts
    numchoices = 0
    for l in counts:
        if counts[l] != 0:
            # ensure three i's are together
            if l == "i":
                numchoices = counts[l]
                newCounts = dict(counts)
                newCounts[l] -= 3
                getPermsFromC(word+l+l+l,newCounts)
            else:
                numchoices = counts[l]
                newCounts = dict(counts)
                newCounts[l] -= 1
                getPermsFromC(word+l,newCounts)
    if numchoices == 0:
        total+=1
##        print(ord,)
##        if total % 8 == 0:
##            print ""
        if total % 10000 == 0:
            print(total, word)
            
            
#get permutations from string
def getPerms(s):
    getPermsFromC("",getCounts(s))

main()
