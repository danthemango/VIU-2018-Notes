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

;---------------------------------------------
; Behaviour:
;    returns length of an ASCII string (excluding the terminator)
; Assumptions:
;    - The string is a null-terminated ASCII sequence of characters.
;    - The string length is in the range [0,64535]
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accd contains the address of the first character in the string
;    Postcondition:
;      accd contains the returned value
;    Destroys:
;      ccr
;---------------------------------------------
.global strLen
.global xstrLen
   
;---------------------------------------------
; Behaviour:
;    converts ascii character to upper case
; Assumptions:
;    character passed is alphabetic
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value
;    Destroys:
;      ccr
;---------------------------------------------
.global toUpper
.global xtoUpper

;---------------------------------------------
; Behaviour:
;    converts ascii character to lower case
; Assumptions:
;    character passed is alphabetic
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value
;    Destroys:
;     ccr 
;---------------------------------------------
.global toLower
.global xtoLower

;---------------------------------------------
; Behaviour:
;    test for numeric character (digit between '0' and '9' inclusive)
; Assumptions:
;    none
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value (0 for false, 1 for true)
;    Destroys:
;      acca
;---------------------------------------------
.global isNumeric
.global xisNumeric

;---------------------------------------------
; Behaviour:
;    test for uppercase character (character between 'A' and 'Z' inclusive)
; Assumptions:
;    none
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value (0 for false, 1 for true)
;    Destroys:
;      acca
;---------------------------------------------
.global isUpper
.global xisUpper

;---------------------------------------------
; Behaviour:
;    test for lowercase character (character between 'a' and 'z' inclusive)
; Assumptions:
;    none
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value (0 for false, 1 for true)
;    Destroys:
;      acca
;---------------------------------------------
.global isLower
.global xisLower

;---------------------------------------------
; Behaviour:
;    test for control character (character between NUL and US inclusive)
;                                see page 605 of our text
; Assumptions:
;    none
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value (0 for false, 1 for true)
;    Destroys:
;      acca
;---------------------------------------------
.global isControl
.global xisControl

;---------------------------------------------
; Behaviour:
;    test for SP (space) character
; Assumptions:
;    none
; Restriction:
;    subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accb contains the character
;    Postcondition:
;      accb contains the returned value (0 for false, 1 for true)
;    Destroys:
;      acca
;---------------------------------------------
.global isSpace
.global xisSpace
