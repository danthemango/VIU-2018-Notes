

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Mar 2002

#------------ gdb/cew Initialization ---------------
   set remotebaud 9600
   target buffalo /dev/ttyS0
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

   
   tbreak *wstr
   tbreak *xwstr
   run
   set $ccrin=$ccr
   set $xin=$x
   set $yin=$y
   set $din=$d
   set $spin=$sp
   continue
   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 33 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 34 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$d  

          set $cew_exp=$din
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 35 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 36 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr  

          set $cew_exp=$ccrin
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
