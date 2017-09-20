

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Mar 2002

#------------ gdb/cew Initialization ---------------
   #set remotebaud 9600
   #target buffalo /dev/ttyS0
   # NOTE... only tested on the simulator
   # BY DEFAULT
   # sp will be initialized to 0x0000
   # _start will be initialized to 0x2000
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
   break _start
   run

   set $i=0 
   while ($i<10)

      set $cew_Test_Count++
          
          set $cew_act=foo($i) 

          set $cew_exp=$i+1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 33 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


      set $i++
   end

   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
