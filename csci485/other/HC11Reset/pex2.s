;============================================-=
; File:
       .file "pex2.s" 
; Behaviour: 
;     Used to test a person's reaction time
;     - program waits for START signal on IC3
;     - waits three seconds and turns on PA4 (STARTLED)
;     - begins listening to IC2 (REACT). 
;     - if IC2 seen before REACTLED is on, system aborts and resets
;     - waits a random number of seconds (less than 10), then turns on PA5 (REACTLED)
;     - begins counting reaction time
;     - once signal seen on IC2 (REACT), displays the reaction time
;        - (in milliseconds, in hexadecimal)
;     - resets
; Timing:
;     - reactiontime has error of approximately .01 ms per millisecond measured
;     - routine 'sleepsecond' uses TOF and TOC2
;     - routine reactWait uses TOC2 
; Assumptions:
;     - reaction occurs in under 64 seconds
; Board:
;      CME11-E9-EVBU
; Authors:
;     Daniel Guenther
;     Nathan Hogman
; Date:
;     finished on 2016-03-31
;==========================================-=

;----------------------------------------------
;            Text Section (code)
;----------------------------------------------
.sect .text 
.global _start

set regbase, 0x1000                    ; addresses of HC11 registers
set porta, 0x0
set tcnt, 0x0e       
set toc2, 0x18
set tctl2, 0x21
set tmsk1, 0x22
set tflg1, 0x23
set TCNT , 0x100E
set TFLG2 , 0x1025

set IC3, 0x1                           ; the pins of porta
set IC2, 0x2
set PA4, 0x10
set PA5, 0x20
set OC2, 0x40

; used for sleepSecond
set secondOverflows , 30 	            ; number of overflows in under one second (30 x 32.77ms)
set secondDifference, 33950		      ; number of cycles for the difference (16.98ms, or 33950 cycles) 

set mscycles, 2000                     ; # cycles in 1 ms

set startWaitTime, 3                   ; time to wait after START is set to set STARTLED, in seconds
; note the following number is random

; the LED's and Inputs are going to be in the following pins of porta
set START, IC3
set REACT, IC2
set STARTLED, PA4
set REACTLED, PA5

; bits of 'status' dealing with different statuses
set startStatus, 0b1
set reactStatus, 0b10

; useful subroutines
set OUTLHLF, 0xffb2
set OUTRHLF, 0xffb5
set OUTA, 0xffb8
set OUT1BYT, 0xffbb
set OUT1BSP, 0xffbe
set OUT2BSP, 0xffc1
set OUTSTRG, 0xffc7
set OUTSTRGO, 0xffca
set OUTCRLF, 0xffc4
set eot, 0x4                           ;end of string

; input pin logic (tctl2)
set IC2listen, 0b100
set IC3listen, 0b1

set jmpOPcode, 0x7e 
set IC3JT, 0xe2 ; IC3 jump table address
set IC2JT, 0xe5 ; IC2 Jump table address
set IRQJT, 0xee ; IRQ jump table address

_start: 
            sei
            ldaa #0                    ; declare the user hasn't yet reacted
            staa hasReacted            

            lds #_stack                ; initialize SP
            ldx #regbase               ; turn off LED's
            bclr porta,x STARTLED
            bclr porta,x REACTLED

            jsr startWait              ; wait for START signal
            ldx #startmessage          ; tell user start signal received
            jsr OUTSTRG
            
            ldaa #startWaitTime        ; wait a few seconds before STARTLED
            jsr counttimer
                                      ; set the STARTLED
            ldx #regbase
            bset porta,x STARTLED

            ldx #IC2JT                 ; begin listening to IC2 (REACT)
            ldaa #jmpOPcode            ; set up jump table
            staa 0,x
            ldd #reactINT
            std 1,x

            ldaa #0                    ; declare the user hasn't yet reacted
            staa hasReacted            
            ldx #regbase
            ldaa #IC2                  
            staa tmsk1,x               ; set IC2I
            staa tflg1,x               ; clear IC2F
            ldaa #IC2listen            ; enable pin logic to listen
            staa tctl2,x
            cli                        ; enable interrupts

            jsr setrand                ; set a random number into reactWaitTime 
            ldaa reactWaitTime         ; wait a reactWaitTime seconds before REACTLED
            jsr counttimer

            ldaa hasReacted            ; if reaction was premature, abort
            cmpa #1
            beq abort

            ldx #regbase
            bset porta,x REACTLED      ; set REACTLED

            jsr reactWait              ; begin counting reacttime, wait for REACT

            ldx #reacttimemessage      ; print reactiontime to screen
            jsr OUTSTRG                ; (label)
            ldaa #'0'                  ; (0x...)
            jsr OUTA
            ldaa #'x'
            jsr OUTA
            ldx reactiontime           ; (number)
            ldx #reactiontime
            jsr OUT2BSP
            ldx #unitsmessage          ; (.. ms)
            jsr OUTSTRGO

            jmp _start

abort:      ldx #abortmessage          ; print abort message
            jsr OUTSTRG
            jsr OUTCRLF
            jmp _start

end:        
            swi

;---------------------------------------------
; Behaviour: 
;    startWait
;    loops until START (IC3 interrupt) signal seen
; Register and Memory Usage:
;    Precondition:
;        none
;    Postcondition:
;        none
;    Destroys:
;        IX, ccr, accd
;---------------------------------------------
                                    
startWait:  
            sei
            ldx #status
            bclr 0,x startStatus       ; turn off startStatus
            ldx #IC3JT                 ; begin listening to IC3 (START)
            ldaa #jmpOPcode            ; set up jump table
            staa 0,x
            ldd #startINT
            std 1,x
            ldx #regbase
            ldaa #IC3                  
            staa tmsk1,x               ; set IC3I
            staa tflg1,x               ; clear IC3F
            ldaa #IC3listen            ; enable pin logic to listen
            staa tctl2,x
            cli                        ; enable interrupts
            ldx #status
            brclr 0,x startStatus .    ; loop here until startStatus is on
            sei                        ; turn off interrupts again
xstartWait: rts

;---------------------------------------------
; Behaviour: 
;     startINT
;     turns startStatus on (byte 0 of status)
;     this interrupt routine is called by IC3 (jump table)
; Assumptions:
;     jump table altered to jump to this routine
; Register and Memory Usage:
;     Precondition:
;        IC3 interrupt seen
;     Postcondition:
;        IC3F cleared, startStatus is set 
;     Destroys:
;        acca, IX
;---------------------------------------------
startINT:   ldx #status
            bset 0,x startStatus
            ldx #regbase               ; clear the IC3 flag
            ldaa #IC3
            staa tflg1,x
xstartINT:  rti

;---------------------------------------------
; Behaviour: 
;    reactWait
;    wait for REACT (IC2) signal and count how long it took
;    stores the number of 1ms cycles in reactiontime
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;        IC2 interrupt enabled
;    Postcondition:
;        IC2 interrupt disabled
;        number of milliseconds inside of routine stored in reactiontime
;    Destroys:
;        IY, acca, IX, accd, ccr
;---------------------------------------------
reactWait:  
                                       ; we're going to be using accy as reactiontime (until saving)
            ldy #0                     ; set reactiontime to 0

RWloop:     
            ldx #regbase               ; clear OC2F
            ldaa #OC2
            staa tflg1,x
            ldd tcnt,x                 ; add 1ms difference to OC2
            addd #mscycles
            std toc2,x
            brclr tflg1,x OC2 .        ; wait until OC2F is set
            iny                        ; increment reactiontime

            ldaa hasReacted            ; if user has reacted, exit
            cmpa #1                    

            bne RWloop             

            sty reactiontime           ; save the reactiontime

xreactWait: rts

;---------------------------------------------
; Behaviour: 
;     reactINT - react interrupt
;     sets hasReacted to 1 if REACT signal found (IC2)
; Assumptions:
;     IC2 interrup enabled and set to jump here
; Register and Memory Usage:
;    Precondition:
;        IC2F is set
;    Postcondition:
;        IC2F is cleared
;        hasReacted = 1
;    Destroys:
;        acca
;---------------------------------------------
reactINT:
            ldaa #1                    ; declare that the user has now reacted
            staa hasReacted
            ldaa #IC2                  ; clear IC2F
            staa tflg1+regbase
xreactINT:  rti

;---------------------------------------------
; Behaviour: 
;     sleepSecond
;     waits for one second 
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Destroys:
;        ccr
;---------------------------------------------
sleepSecond:   
            pshy
            psha
            pshb

            ldy #secondOverflows 
				jsr tofClr
				ldd TCNT
				addd #secondDifference
				bcc tLoop1
				iny
		
tLoop1:		cpy #0x0
				beq tLoop2

tLoop3: 		tst TFLG2
				bpl tLoop3
				jsr tofClr
				dey
				bne tLoop1

tLoop2: 		cpd TCNT
				bhi tLoop2	
            
            pulb
            pula
            puly

xsleepSecond:		
            rts

;---------------------------------------------
; Behaviour: 
;     clears TOF
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;        TOF is set
;    Postcondition:
;        TOF is cleared
;    Destroys:
;        none
;---------------------------------------------
tofClr: 		
            psha
            ldaa #0x80
				staa TFLG2
            pula
xtofClr:		rts

;---------------------------------------------
; Behaviour: 
;    count n seconds
; Assumptions:
;     n passed on acca
; Restriction:
;     none
; Register and Memory Usage:
;     Precondition:
;         n is in acca
;     Postcondition:
;     Destroys:
;       acca, ccr
;---------------------------------------------
counttimer:		
            staa TMAX                  ; keep track of how long we need to count to 
            ldaa #0
            staa TCOUNT

ctloop:			                        ; keep sleeping one second until TMAX equals n
            ldaa TMAX
            cmpa TCOUNT
            beq xcounttimer
            jsr sleepSecond
            inc TCOUNT
            ldaa hasReacted            ; if user reacted, abort
            cmpa #1
            beq xcounttimer
            jmp ctloop
			
xcounttimer:
            rts

;---------------------------------------------
; Behaviour: 
;     setrand
;     sets a random time in reactWaitTime
;     between 0 and 10
; Assumptions:
;     none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;        none
;    Postcondition:
;        reactWaitTime is set to a pseudorandom time between 0 and 10
;    Destroys:
;        ccr, IX, accd
;---------------------------------------------

setrand:
                                       ; put the contents of tcnt into accd
            ldx #regbase
            ldd tcnt,x                 ; save (low byte of) time in reactWaitTime
            ldx #reactWaitTime          
            stab 0,x
            bclr 0,x 0b11110000        ; modulo reactWaitTime with 0xf
            ldab 0,x                   ; if reactWaitTime > 10, then reactWaitTime -= 5
            cmpb #10
            ble xsetrand
            subb #5
            stab 0,x
xsetrand:
            rts


;-----------------------------------------
;         misc Data
;-----------------------------------------
                                       ; printouts to the screen
startmessage:     .asciz "Beginning Sequence"
.byte eot
abortmessage:     .asciz "Aborting: reacted too soon"
.byte eot
reacttimemessage: .asciz "Reaction Time: "
.byte eot
unitsmessage: .ascii "ms"
.byte eot
reactWaitTime: .byte 3                 ; seconds to wait before prompting for user response
TCOUNT: .byte 0                        ; number of counts done by counttimer
TMAX: .byte 0                          ; number of counts to be done by counttimer
status: .byte 0                        ; bit 0 is 'startStatus'
hasReacted: .byte 0                    ; set to 1 if REACT signal seen
reactiontime: .word 0                  ; reaction time

; set up dummy frame pointer
.global _.frame
_.frame: .word

.end
