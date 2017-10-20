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
#           https://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
#              - how to check if a file exists in bash, because I need this explained to me every time
#           https://stackoverflow.com/questions/1652680/how-to-get-the-pid-of-a-process-that-is-piped-to-another-process-in-bash
#              - capture the PID in the middle of a pipe
###################################################
# where to save the results
log=log
myTTY=/dev/ttyS0

# ensure program name is provided
if [ $# -eq 0 ]
then
   echo "usage: $0 program.s19"
   exit
fi
progname=$1

# ensure it exists
if [ ! -f $progname ]; then
    echo "$progname not found!"
    exit
fi

# start piping in the program
cat $myTTY | tee "$log" &
pid=$!
printf "load t\r" > $myTTY
cat $progname > $myTTY

# wait until HC11 says 'done'
while sleep 1
do
   if fgrep --quiet "done" "$log"
   then
      #kill $pid
      break
   fi
done

# try running the program
printf "g 2000\r" > $myTTY
# wait until HC11 prints end-of-program statements
while sleep 1
do
   if fgrep --quiet "P-" "$log"
   then
      #kill $pid
      break
   fi
done
kill %1
