count = 0

def isTriplet(word,l):
    for i in range(len(word)-2):
        (l1,l2,l3) = word[i],word[i+1],word[i+2]
        if l1 == l and l2 == l and l3 == l:
            return True
    return False

originalword = "statisticians"
myword = "statstcians"

def main():
    countPerms()

def countPerms():
    prPerms("", "abcd")
    print(count)

def prPerms(start,choices):
    if choices == "":
        print(start)
        global count
        count+=1
##        if(count%100000==0):
##            print(".",)
        return
    for i in range(len(choices)):
        prPerms(start+choices[i],choices[:i]+choices[i+1:])

main()

