;============================================-=
; File:
       .file "fibonacci.s" 
; Behaviour: 
;      Calculate the Nth fibonacci number
;      and store the answer in FIBON
; Assumptions:
;      - N is in the range [0, MAXN] 
; Board:
;      CME11-E9-EVBU
; Author/Date:
;      Peter Walsh Feb 2001
;      revised Feb 2002
;============================================-=

;----------------------------------------------
;            Text Section (code and data)
;----------------------------------------------
.sect .text
.global _start

_start: 
         lds #_stack    ; initialize SP
         ldab N        
         jsr fibonacci   
         staa FIBON
	 ;stop           ; use stop for wookie
         swi            ; use swi for gdb and buffalo

;---------------------------------------------
; Behaviour: 
;      Return the nth fibonacci number
; Assumptions:
;      n th fibonacci number is fib(n) = fib(n-1) + fib(n-2) where
;      fib(0) and fib(1) = 1 (n >= 0)
; Register and Memory Usage:
;    Precondition:
;      accb contains the  value of n 
;    Postcondition:
;      acca contain  fib(n)
;    Destroyed:
;      ccr
;---------------------------------------------
fibonacci: pshb         ; save registers 
           pshx

                        ; set up variables on the stack
           ldaa #1      
           psha         ; fn-1
           psha         ; fn

           tsx          ; set up index ($x)to access variables

           tstb         ; done if n==0 or n==1
           beq donefib
           decb
           beq donefib

                        ; calculate fib(n) where n>1

L1:        pshb         ; save n
           ldaa 0,x     ; $a=fn
           ldab 0,x     ; $b=fn

           adda 1,x     ; $a=$a+fn-1
           staa 0,x     ; fn=$a

           stab 1,x     ; fn-1=$b  

           pulb         ; loop until n==0
           decb
           bne L1

donefib:   pula         ; $a=fn

           ins          ; clean the stack and restore register values
           pulx
           pulb

xfibonacci:rts

;----------------------------------------------
;            Data Section
;----------------------------------------------
N: .byte 
FIBON: .byte

#set up dummy frame pointer
.global _.frame
_.frame: .word


.end
