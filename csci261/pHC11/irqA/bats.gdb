

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Mar 2002

#------------ gdb/cew Initialization ---------------
   set remotebaud 9600
   target buffalo /dev/ttyS0
   # example not for sim
   load main.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0


#-------------- Local Assumptions -----------------
#   none

#-------------- Local Constants -------------------
#   none

#-------------- Local Functions -------------------
#   none

#---------------- Test Cases -----------------------

   set {unsigned char}(0x00ee)=0x7e
   set {short int}(0x00ef)=irqCount
   set {unsigned char}&COUNT=0
 
   break *xirqCount
   run
   
   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&COUNT 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 31 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   continue

   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&COUNT 

          set $cew_exp=2
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 34 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   continue

   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&COUNT 

          set $cew_exp=3
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 37 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
