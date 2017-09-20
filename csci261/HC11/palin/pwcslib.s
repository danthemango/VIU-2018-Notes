.include "pwcslib.h"
;============================================-=
; File:
       .file "pwcslib.h"
; Behaviour:
;      Library of character and string utilities.
; Assumptions:
;      Routines only modify registers and the stack.
; Board:
;      CME11-E9-EVBU 
; Author:
;      Peter Walsh
;============================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text

;=========================================================================
strLen:       pshx              ; save registers
              pshy

              ldy #0x0          ; counter 
              xgdx              ; set X to index into the string

nextChar:     ldaa 0,x          ; read current indexed character into A
              beq countDone     ; branch to done if \0 was read 

              iny               ; increment counter and index by 1
              inx

              bra nextChar      

countDone:    xgdy              ; save counter in D as return parameter

              puly              ; restore registers
              pulx 
xstrLen:      rts
   
;=========================================================================
toUpper:
              andb #0xDF        ; clear 3rd most significant bit
xtoUpper:     rts

;=========================================================================
toLower:
              orab #0x20        ; set 3rd most significant bit
xtoLower:     rts

;=========================================================================
isNumeric :
              tpa                       ; save ccr on the stack
              psha
              pshx                      ; save x on the stack
              pshb                      ; save char on the stack
              tsx                       ; set up stack frame pointer

              ldab #0x30                ; load accb with '0'
              subb 0,x                  ; accb:=accb-ord(char)
              bgt notNumeric            ; branch to nonNumeric if accb > 0

              ldab #0x39                ; load accb with '9'
              subb 0,x                  ; accb:=accb-ord(char)
              blt notNumeric            ; branch to nonNumeric if accb  < 0

              ldab #0x1                 ; we have a digit, return true (1)
              bra isNumericCleanUp 

notNumeric:   ldab #0x0                 ; we dont have a digit, return false (0)

isNumericCleanUp:                       ; clean stack and restore registers
              ins              
              pulx
              pula
              tap
xisNumeric:   rts

;=========================================================================
isUpper :
              tpa                       ; save ccr on the stack
              psha
              pshx                      ; save x on the stack
              pshb                      ; save char on the stack
              tsx                       ; set up stack frame pointer

              ldab #0x41                ; load accb with 'A'
              subb 0,x                  ; accb:=accb-ord(char)
              bgt notUpper              ; branch to nonUpper if accb > 0

              ldab #0x5A                ; load accb with 'Z'
              subb 0,x                  ; accb:=accb-ord(char)
              blt notUpper              ; branch to nonUpper if accb  < 0

              ldab #0x1                 ; we have an upper, return true (1)
              bra isUpperCleanUp 

notUpper:     ldab #0x0                 ; we dont have an upper, return false (0)

isUpperCleanUp:                         ; clean stack and restore registers
              ins              
              pulx
              pula
              tap
xisUpper:     rts

;=========================================================================
isLower :
              tpa                       ; save ccr on the stack
              psha
              pshx                      ; save x on the stack
              pshb                      ; save char on the stack
              tsx                       ; set up stack frame pointer

              ldab #0x61                ; load accb with 'a'
              subb 0,x                  ; accb:=accb-ord(char)
              bgt notLower              ; branch to nonLower if accb > 0

              ldab #0x7A                ; load accb with 'z'
              subb 0,x                  ; accb:=accb-ord(char)
              blt notLower              ; branch to nonLower if accb  < 0

              ldab #0x1                 ; we have a lower, return true (1)
              bra isLowerCleanUp 

notLower:     ldab #0x0                 ; we dont have a lower, return false (0)

isLowerCleanUp:                         ; clean stack and restore registers
              ins              
              pulx
              pula
              tap
xisLower:     rts

;=========================================================================
isControl:
              tpa                       ; save ccr on the stack
              psha
              pshx                      ; save x on the stack
              pshb                      ; save char on the stack
              tsx                       ; set up stack frame pointer

              ldab #0x00                ; load accb with NUL
              subb 0,x                  ; accb:=accb-ord(char)
              bgt notControl            ; branch to nonControl if accb > 0

              ldab #0x1f                ; load accb with US
              subb 0,x                  ; accb:=accb-ord(char)
              blt notControl            ; branch to nonControl if accb  < 0

              ldab #0x1                 ; we have a control char., return true (1)
              bra isControlCleanUp 

notControl:   ldab #0x0                 ; we dont have a control char., return false (0)

isControlCleanUp:                       ; clean stack and restore registers
              ins              
              pulx
              pula
              tap
xisControl:   rts

;=========================================================================
isSpace:
              tpa                       ; save ccr on the stack
              psha
              andb #0xDF                ; results in 0 if a space
              bne  notSpace 
              ldab #0x1                 ; we have a space, return true (1)
              bra isSpaceCleanUp 

notSpace:     ldab #0x0                 ; we dont have an space, return false (0)
isSpaceCleanUp:
              pula
              tap
xisSpace:     rts

.end
