#################################################
# Filename:   loadWaitRun.sh
# Author:     Daniel Guenther (565154853)
# Date:       2017-09-20
# Class:      CSCI 485
# Project:    any HC11 related work
# Purpose:    to load an s19 record to the HC11 and run it
#             without user intervention
# Sources:
#           https://superuser.com/questions/402979/kill-program-after-it-outputs-a-given-line-from-a-shell-script
#              - quick and dirty way to check for tty output results
###################################################
# where to save the results
log=log
myTTY=/dev/ttyS0

# ensure program name is provided
if [ $# -eq 0 ]
then
   echo "usage: $0 program.s19"
fi
progname=$1

# start piping in the program
echo -n "load t\r" > $myTTY
cat $progname > 

# wait until HC11 says 'done'
cat $myTTY > "$log" 2>&1 &
pid=$!
while sleep 1
do
   if fgrep --quiet "done" "$log"
   then
      kill $pid
      break
   fi
done

# try running the program
echo -n "g 2000\r" > $myTTY

# print program as it is running
cat $myTTY

