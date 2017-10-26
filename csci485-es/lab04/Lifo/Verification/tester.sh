#!/usr/local/bin/bash -e
################################################################
# tester.sh
# Author: Daniel Guenther
# Date:     2015-10-21
# update 1: 2017-10-23
# Purpose: used to test programs
################################################################

if [ $# -ne 1 ]; then
   echo "usage: $0 progname"
   exit
fi

prog=$1
path=$(dirname $0) #get the path to this file
# directories of 
inPath=tstin
expPath=tstexp
diffPath=tstdiff
outPath=tstout
failedTests=0
numTests=0

#ensure the program exists
if [ ! -f $prog ]
then
   echo "$prog not found"
   exit
fi

echo "== running tests on $prog =="

#ensure all directories exist
mkdir -p $inPath
mkdir -p $expPath
mkdir -p $diffPath
mkdir -p $outPath

# ensure tests exist
if [ -z "$(ls -A $path/$inPath)" ]; then
   echo "no tests found in $inPath"
   exit
fi

# run tests on inPath files
for testfile in $path/$inPath/* 
do
   # get the filename
   testname=$(basename $testfile)

   # run the test
   echo test: $testname
   $path/$prog < $path/$inPath/$testname > $path/$outPath/$testname.out
   ((numTests++))

   # ensure expectation file for test is available
   if [ ! -f $path/$expPath/$testname.exp ]
   then
      echo "ERR: $path/$expPath/$testname.exp not found"
      cat $path/$outPath/$testname.out
      ((failedTests++))
   # check the result of the test
   else
      diff $path/$outPath/$testname.out $path/$expPath/$testname.exp > $path/$diffPath/$testname.diff
      # if errcode is not 0, then the test failed
      if [ $? -ne 0 ]; then
         echo "ERR: $testname failed"
         cat $path/$diffPath/$testname.diff
         ((failedTests++))
      fi
   fi
done

echo failed $failedTests/$numTests tests
