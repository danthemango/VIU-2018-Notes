

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Mar 2002

#------------ gdb/cew Initialization ---------------
   set remotebaud 9600
   target buffalo cscixtst:3001
   #target sim
   load palin.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0


#-------------- Local Assumptions -----------------
#   main.s has a malloc() routine that always returns the
#   address of STR

#-------------- Local Constants -------------------
#   Max string size is 30 bytes including null terminator

#-------------- Local Functions -------------------
#   none

#---------------- Test Cases -----------------------
   #test palindrome
   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR = "Happy St Parricks day"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 32 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

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
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 35 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR = "1"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 44 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 45 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 46 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 47 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR="11"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 56 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 57 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 58 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 59 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR = "10"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 68 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 69 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 70 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 71 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   
   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR = "101"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 80 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 81 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 82 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 83 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR = "112"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 92 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 93 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 94 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 95 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR = "1221"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 104 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 105 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 106 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 107 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR="1211"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 116 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 117 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 118 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 119 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   
   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR="ratsliveonnoevilstar"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 128 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 129 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 130 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 131 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR="ratslieonnoevilstar"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 140 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 141 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 142 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 143 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isPal
   tbreak *xisPal
   run
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set {char [30]}STR="ratslieonnoeilstar"
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 152 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 153 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 154 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 155 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   
   
   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
