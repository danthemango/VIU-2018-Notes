

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Feb 2001

#------------ gdb/cew Initialization ---------------
   #set remotebaud 9600
   #target buffalo /dev/ttyS0
   target sim
   load fibonacci.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0


#-------------- Local Assumptions -----------------
#  none

#-------------- Local Constants -------------------
   set $MAXN=0xC

#-------------- Local Functions -------------------
# Behaviour:
#   $ans = fib($arg0) 
# Assumptions:
#    $arg0 >= 0
define oracle
   set $fn=1
   set $fnm1=1
   set $i=$arg0
   while ($i >= 2)
      set $hld=$fn
      set $fn=$fn + $fnm1
      set $fnm1=$hld
      set $i--
   end
   set $ans=$fn
end

#---------------- Test Cases -----------------------
   set $cnt=0
   while ($cnt <= $MAXN)
      set $cew_Test_Count++
          set {unsigned char}&N=$cnt 

  run 

  oracle $cnt
          set $cew_act={unsigned char}&FIBON 

          set $cew_exp=$ans
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 40 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 

      set {unsigned char}&N=$cnt
      tbreak *fibonacci
      tbreak *xfibonacci
      set $cew_Test_Count++
          run
          set $cew_act=$b 

          set $cew_exp=$cnt
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 45 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
      set $xin=$x
      set $yin=$y
      set $spin=$sp
      set $cew_Test_Count++
          continue
          set $cew_act=$a 

          set $cew_exp=$ans
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 49 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
      set $cew_Test_Count++
          
          set $cew_act=$b 

          set $cew_exp=$cnt
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 50 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
      set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 51 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
      set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 52 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
      set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 53 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end
 
      set $cnt++
      end

   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
