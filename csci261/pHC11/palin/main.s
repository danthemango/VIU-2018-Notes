;============================================-=
; File:
       .file "main.s" 
; Behaviour: 
;      Determine if an ascii string of alpha-numeric characters is
;      a palindrome.
;      Accd is to be assigned  true (1) if the string is a 
;      Palindrome else it is to be assigned  false (0)
; Assumptions:
;      - The first character in the string is at STR.
;      - The string has at least 1 alpha-numeric character.
;      - The string is null-terminated.
;      - The string contains only alpha-numeric characters.
; Board:
;      CME11-E9-EVBU 
; Author:
;      Peter Walsh
;============================================-=

;----------------------------------------------
;            Text Section (code)
;----------------------------------------------
.sect .text
.global _start
.global STR

_start: 
               lds #_stack    ; initialize SP
               ldd #STR
               jsr isPal 
               
               swi            ; return control to the debugger



;---------------------------------------------
; Behaviour: 
;    Return true (1) if string is a palindrome else return false (0)
; Assumptions:
;    String is a null-terminated ascii sequence of alpha-numeric characters 
;    containing at least 1 alpha-numeric character.
; Restriction:
;      - subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accd is the address of the first character in the string 
;    Postcondition:
;      accd contains the returned value 
;    Destroys:
;      ccr
;---------------------------------------------
isPal:         pshx              ; save registers
               pshy

               xgdy              ; set up space and initialize 
               pshy              ; left string address

               des               ; set up space for right string address
               des

               tsy               ; set up stack frame pointer

               ldd 2,y           ; calculate right string address and 
               jsr strLen        ; initialize corresponding local variable
               addd 2,y
               xgdx
               dex
               xgdx
               std 0,y

morePal:       ldx 0,y           ; compare char. at left address
               ldaa 0,x          ; and right address
               ldx 2,y
               cmpa 0,x
               bne noPal         ; if they differ, branch to noPal

               ldd 0,y           ; branch to yesPal if right <= left
               subd 2,y
               bls yesPal        ; bls is branch if (Z + C) = 1

               ldd 0,y           ; decrement right address by 1
               xgdx
               dex
               xgdx
               std 0,y

               ldd 2,y           ; increment left address by 1
               xgdx
               inx
               xgdx
               std 2,y

               bra morePal


yesPal:        ldd #0x1          ; set return value to true
               bra palRes

noPal:         ldd #0x0          ; set return value to false

palRes:        ins               ; remove localvariables
               ins
               ins
               ins

               puly              ; restore registers
               pulx
xisPal:        rts

;---------------------------------------------
; Behaviour: 
;    Returns the address of STR.
;    This subroutine is for testing only (used by cew testbench) 
; Assumptions:
;    none
; Restriction:
;      - subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      none
;    Postcondition:
;      accd contains the returned value 
;    Destroyed:
;      ccr
;---------------------------------------------
malloc:        ldd STR;
               rts

;----------------------------------------------
;            Data Section
;----------------------------------------------
STR: .asciz "01233210" ; reserves a total of 30 bytes (8 +1 (\n) +21)
.space 21, 1

#set up dummy frame pointer
.global _.frame
_.frame: .word

.end
