

#cew_Variables






# Cew for asm Testing Script
# Peter Walsh Mar 2002

#------------ gdb/cew Initialization ---------------
   #set remotebaud 9600
   #target buffalo /dev/ttyS0
   # NOTE... only tested on the simulator
   target sim
   load main.elf
   set language asm
   set $cew_Test_Count=0
          set $cew_Error_Count=0


#-------------- Local Assumptions -----------------
#   strlen.s has a malloc() routine that always returns the
#   address of STR

#-------------- Local Constants -------------------
   set $MAXLEN=30

#-------------- Local Functions -------------------
# Behaviour:
#    Generate string at STR with values 1, 2, 3 .... $arg0, \0
# Assumptions:
#    $arg0 > 0
define strGen
   set $i=1
   set $addr=(unsigned char *)&STR
   while ($i <= $arg0)
      set {unsigned char}$addr=$i
      set $i++
      set $addr++
   end
   set {unsigned char}$addr=0x0
end

#---------------- Test Cases -----------------------
   set {short int}(&smc+1)=strLen
   #tests for strLen
   #using the string from the main.s file
   tbreak *strLen
   tbreak *xstrLen
   run 
   set $d=(unsigned char *)&STR
   set $xin=$x
   set $yin=$y
   set $spin=$sp
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=8
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 48 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 49 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 50 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 51 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cnt=0
   while ($cnt < $MAXLEN)
      strGen $cnt
      tbreak *strLen
      tbreak *xstrLen
      run
      set $d=(unsigned char *)&STR
      set $xin=$x
      set $yin=$y
      set $spin=$sp
      set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=$cnt
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 62 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$x  

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 63 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$y  

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 64 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$sp  

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 65 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cnt++
   end

   #tests for strLen
   #using  malloc()

   tbreak *strLen
   tbreak *xstrLen
   run
   set $testString="Happy St Patricks day"
   set $d=(unsigned char *)&STR
   set $x=$xin
   set $y=$yin
   set $spin=$sp
   set $cew_Test_Count++
          continue
          set $cew_act=$d 

          set $cew_exp=21
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


   set {short int}(&smc+1)=toUpper
   #tests for toUpper

   set $i='a'
   set $ans='A'
   while ($i <= 'z')

      tbreak *toUpper
      tbreak *xtoUpper
      run
      set $b=$i 
      set $ccrin=$ccr
      set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=$ans
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 97 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 98 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   
      set $i++
      set $ans++
   end

   set {short int}(&smc+1)=toLower
   #tests for toLower

   set $i='A'
   set $ans='a'
   while ($i <= 'Z')

      tbreak *toLower
      tbreak *xtoLower
      run
      set $b=$i 
      set $ccrin=$ccr
      set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=$ans
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 116 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 117 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   
      set $i++
      set $ans++
   end

   set {short int}(&smc+1)=isNumeric
   #tests for isNumeric
   
   # test for '/' and ':' 
   tbreak *isNumeric
   tbreak *xisNumeric
   run
   set $b='/'
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 135 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 136 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 137 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 138 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 139 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isNumeric
   tbreak *xisNumeric
   run
   set $b=':'
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 149 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 150 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 151 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 152 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 153 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   set $i='0'
   while ($i <= '9')

      tbreak *isNumeric
      tbreak *xisNumeric
      run
      set $b=$i
      set $spin=$sp
      set $xin=$x
      set $yin=$y
      set $ccrin=$ccr
      set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 166 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 167 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 168 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 169 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 170 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

  
      set $i++
   end

   set {short int}(&smc+1)=isUpper
   #tests for isUpper
   
   # test for '@' and '[' 
   tbreak *isUpper
   tbreak *xisUpper
   run
   set $b='@'
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 187 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 188 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 189 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 190 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 191 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isUpper
   tbreak *xisUpper
   run
   set $b='['
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 201 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 202 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 203 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 204 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 205 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   set $i='A'
   while ($i <= 'Z')

      tbreak *isUpper
      tbreak *xisUpper
      run
      set $b=$i
      set $spin=$sp
      set $xin=$x
      set $yin=$y
      set $ccrin=$ccr
      set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 218 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 219 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 220 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 221 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 222 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

  
      set $i++
   end

   set {short int}(&smc+1)=isLower
   #tests for isLower
   
   # test for '`' and '{' 
   tbreak *isLower
   tbreak *xisLower
   run
   set $b=0x60
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 239 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 240 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 241 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 242 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 243 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isLower
   tbreak *xisLower
   run
   set $b='}'
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 253 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 254 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 255 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 256 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 257 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   set $i='a'
   while ($i <= 'z')

      tbreak *isLower
      tbreak *xisLower
      run
      set $b=$i
      set $spin=$sp
      set $xin=$x
      set $yin=$y
      set $ccrin=$ccr
      set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 270 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 271 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 272 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 273 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 274 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

  
      set $i++
   end

   set {short int}(&smc+1)=isControl
   #tests for isControl
   
   # test for 0xFF and SP 
   tbreak *isControl
   tbreak *xisControl
   run
   set $b=0xFF
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 291 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 292 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 293 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 294 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 295 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isControl
   tbreak *xisControl
   run
   set $b=' '
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 305 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 306 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 307 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 308 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 309 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   set $i=0x00
   while ($i <= 0x1f)

      tbreak *isControl
      tbreak *xisControl
      run
      set $b=$i
      set $spin=$sp
      set $xin=$x
      set $yin=$y
      set $ccrin=$ccr
      set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 322 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 323 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 324 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 325 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

      set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 326 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

  
      set $i++
   end

   set {short int}(&smc+1)=isSpace
   #tests for isSpace
   
   tbreak *isSpace
   tbreak *xisSpace
   run
   set $b=0x20
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=1
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 342 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 343 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 344 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 345 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 346 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   tbreak *isSpace
   tbreak *xisSpace
   run
   set $b=0x21
   set $spin=$sp
   set $xin=$x
   set $yin=$y
   set $ccrin=$ccr
   set $cew_Test_Count++
          continue
          set $cew_act=$b  

          set $cew_exp=0
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 356 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$sp 

          set $cew_exp=$spin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 357 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$x 

          set $cew_exp=$xin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 358 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$y 

          set $cew_exp=$yin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 359 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end

   set $cew_Test_Count++
          
          set $cew_act=$ccr 

          set $cew_exp=$ccrin
          if (($cew_act) != ($cew_exp))
             set $cew_Error_Count++
             printf "__cew__Test Case ERROR (Ncase) in script at line number 360 \n"
             printf "__cew__   Actual Value is %d \n", $cew_act
             printf "__cew__   Expected Value is %d \n", $cew_exp
          end


   printf "__cew__**********Summary**********\n"
         printf "__cew__Total number of test cases = %d \n", $cew_Test_Count
         printf "__cew__Total number of test cases in error = %d \n", $cew_Error_Count

   quit
