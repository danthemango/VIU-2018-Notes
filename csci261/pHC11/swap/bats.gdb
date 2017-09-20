

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Feb 2001

#------------ gdb/cew Initialization ---------------
  set remotebaud 9600
  target buffalo kit55:3000
  # target sim
   load swap.elf
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
   # verify swap behaviour using assembled data values for AA and BB
   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&AA  

          set $cew_exp=0x3
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 25 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&BB  

          set $cew_exp=0x4
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 26 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
   set $cew_Test_Count++
          run
          set $cew_act={unsigned char}&AA  

          set $cew_exp=0x4
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 27 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&BB  

          set $cew_exp=0x3
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 28 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 

   # modify data values for AA and BB and verify swap behaviour
   set $cew_Test_Count++
          set {unsigned char}&AA=6 

  set {unsigned char}&BB=7 

  run
          set $cew_act={unsigned char}&AA  

          set $cew_exp=0x7
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 31 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
   set $cew_Test_Count++
          
          set $cew_act={unsigned char}&BB  

          set $cew_exp=0x6
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 32 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 

   # check register values
   set $cew_Test_Count++
          
          set $cew_act=$a  

          set $cew_exp=0x7
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 35 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
   set $cew_Test_Count++
          
          set $cew_act=$b  

          set $cew_exp=0x6
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 36 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 

   # check input/output reg parameters and ccr
   set {unsigned char}&AA=6 
   set {unsigned char}&BB=7 
   tbreak *swapab
   tbreak *xswapab
   set $cew_Test_Count++
          run
          set $cew_act=$a 

          set $cew_exp=6
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 43 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $ccrin=$ccr
   set $cew_Test_Count++
          
          set $cew_act=$b 

          set $cew_exp=7
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 45 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          continue
          set $cew_act=$a 

          set $cew_exp=7
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 46 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$b 

          set $cew_exp=6
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 47 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 48 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
