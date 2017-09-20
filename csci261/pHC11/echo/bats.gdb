

set $cew_Test_Count=0
          set $cew_Error_Count=0







# Cew for asm Testing Script
# Peter Walsh Feb 2001



#------------ gdb/cew Initialization ---------------
   set remotebaud 9600
   target buffalo /dev/ttyS0
   #target sim
   load echo.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0



#-------------- Local Constants -------------------
#none
#-------------- Local Functions -------------------
#none

#---------------- Test Cases -----------------------


   run
   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
