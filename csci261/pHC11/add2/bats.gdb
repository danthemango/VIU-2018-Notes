

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Feb 2001

#------------ gdb/cew Initialization ---------------
   set remotebaud 9600
   target buffalo /dev/ttyS0
   #target sim
   load add2.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0



#-------------- Local Assumptions -----------------
#  none

#-------------- Local Constants -------------------
#  none

#-------------- Local Functions -------------------
#  none

#---------------- Test Cases ----------------------

   set $cew_Test_Count++
          run
          set $cew_act={unsigned char}&CC 

          set $cew_exp=7
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 25 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
