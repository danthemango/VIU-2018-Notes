

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Mar 2002

#------------ gdb/cew Initialization ---------------
   #set remotebaud 9600
   #target buffalo /dev/ttyS0
   target sim
   load main.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0


#-------------- Local Assumptions -----------------
# none

#-------------- Local Constants -------------------
# none

#-------------- Local Functions -------------------
# none

#---------------- Test Cases -----------------------

   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
