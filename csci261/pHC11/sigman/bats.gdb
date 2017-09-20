

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Feb 2001

#------------ gdb/cew Initialization ---------------
   set remotebaud 9600
   target buffalo cscixtst:3001
   #target sim
   load sigman.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0


#-------------- Local Assumptions ------------------
#  none

#-------------- Local Constants --------------------
#  none

#-------------- Local Functions --------------------
#  none

#---------------- Test Cases -----------------------
   set $cew_Test_Count++
          run
          set $cew_act={unsigned char}&SUM  

          set $cew_exp=0xa
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 23 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
   # changing memory as demonstrated below is not recommended
   # it is included here just to show the 'power' of gdb's scripting lang.
   set $cew_Test_Count++
          set {unsigned char}0x2002=3 

  run
          set $cew_act={unsigned char}&SUM  

          set $cew_exp=0x6
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 26 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          set {unsigned char}0x2002=4 

  run
          set $cew_act={unsigned char}&SUM  

          set $cew_exp=0xa
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 27 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          set {unsigned char}0x2002=1 

  run
          set $cew_act={unsigned char}&SUM  

          set $cew_exp=0x1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 28 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
