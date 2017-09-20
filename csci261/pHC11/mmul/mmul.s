;============================================-=
; File:
       .file "prime.s" 
; Behaviour: 
;      Count the number of prime numbers between 0 and N (inclusive)
;      and store the answer in COUNT
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
               ldd N
               jsr countPrimes
               stab COUNT
               swi            ; use with gdb and buffalo
               ;stop           ; use with wookie


;---------------------------------------------
; Behaviour: 
;    Returns 1 if n is prime else 0
; Assumptions:
;    n is in the range [0, 65535] 
; Restriction:
;      - subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accd contains the  value of n 
;    Postcondition:
;      accd contains the returned value 
;    Destroyed:
;      ccr
;---------------------------------------------
isPrime:       pshx
               pshy             ; save registers
               pshb
               psha
               ldd #0x0002      ; init. divisor for prime tests
               pshb
               psha
               tsy

               ldd 2,y          ; special case of 0,1 and 2
               beq notPrime
               subd #0x0001
               beq notPrime   
               subd #0x0001
               beq prime 

loop:          ldd 2,y          ; check for prime by repative division
               ldx 0,y
               idiv
               cpd #0x0000  
               beq notPrime
               ldd 0,y
               addd #0x0001
               std 0,y
               cpd 2,y
               blt loop
prime:         ldd #0x0001      ; set-up return value
               bra ipdone
notPrime:      ldd #0x0000
ipdone:        ins
               ins
               ins
               ins              ; clean stack and restore registers 
               puly
               pulx
xisPrime:      rts
   

;---------------------------------------------
; Behaviour: 
;    Return the number of prime numbers between 0 and n (inclusive).
; Assumptions:
;    n is in the range [0, 65535] 
; Restriction:
;      - subroutine may only accesses registers and the stack
; Register and Memory Usage:
;    Precondition:
;      accd contains the  value of n 
;    Postcondition:
;      accd contains the returned value 
;    Destroyed:
;      ccr
;---------------------------------------------
countPrimes:   pshy
               pshx             ; save registers
               pshb
               psha
               ldy #0x0000      ; init. prime count
               pulx
               pshx
next:          xgdx 
               jsr isPrime
               cpd #0x0000
               beq noCinc
               iny              ; increment prime count
noCinc:        pulx
               xgdx
               cpd #0x0000
               beq cpdone 
               xgdx
               dex              ; decrement n (if n!=0)
               pshx
               bra  next

cpdone:        xgdy             ; set-up return value
               pulx             ; restore registers
               puly
xcountPrimes:  rts


;----------------------------------------------
;            Data Section
;----------------------------------------------
set MAXN, 0xF000
N: .word
COUNT: .byte

.end
