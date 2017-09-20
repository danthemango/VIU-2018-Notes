;============================================-=
; Note this is v0, it's a working version of the program,
;  but doesn't meet all program requirements
; File:
       .file "pex2.s" 
; Behaviour: 
;     Used to test a person's reaction time
;     - program waits for a signal in IC3
;     - waits three seconds and turns on PA4
;     - waits a random number of seconds (less than 10), then turns on PA5
;     - begins counting reaction time
;     - once signal is received in IRQ, program outputs reaction time
;     - then resets
; Assumptions:
;     TODO only counts up to the maxsize of reactiontime
; Board:
;      CME11-E9-EVBU
; Author/Date:
;     Daniel Guenther, March 2016
;==========================================-=

;----------------------------------------------
;            Text Section (code)
;----------------------------------------------
.sect .text 
.global _start

set regbase, 0x1000
set porta, 0x0
set tcnt, 0x0e
set tmsk1, 0x22
set tflg1, 0x23
set IC2, 0x2

; 
set TCNT , 0x100E
set NUMINT , 0x3 		; counter set to 100ms (3 x 32.77ms)
set DIFF , 0xD34		; Diff, number of counts for 1.69 ms (3380 counts) 0d34	
set TFLG2 , 0x1025

set startWaitTime, 30 ; time to wait after START is set to set STARTLED, in 100ms
; note the following number is random
set reactWaitTime, 40 ; time to wait after STARTLED is set to set REACTLED, in 100ms

; the LED's and Inputs are going to be in the following pins of porta
set START, 0x1
set REACT, 0x2
set STARTLED, 0x10   
set REACTLED, 0x20

; useful subroutines
set OUTA, 0xffb8
set OUT1BYT, 0xffbb
set OUT1BSP, 0xffbe
set OUT2BSP, 0xffc1
set OUTSTRG, 0xffc7
set OUTCRLF, 0xffc4
set eot, 0x4 ;end of string

set jmpOPcode, 0x7e 
set IC2JT, 0xe5 ; IC2 Jump table address
set IRQJT, 0xee ; IRQ jump table address

_start: 
         sei

         lds #_stack    ; initialize SP

                                    ; turn off LED's
         ldx #regbase
         bclr porta,x STARTLED
         bclr porta,x REACTLED

                                    ; wait for START signal
         jsr startWait
         ldx #startmessage          ; tell user start signal received
         jsr OUTSTRG
         
                                    ; wait a few seconds before STARTLED
         ldaa #startWaitTime
         jsr counttimer
                                    ; set the STARTLED
         ldx #regbase
         bset porta,x STARTLED

         ldx #IRQJT                 ; begin listening to IRQ (REACT)
         ldd #0
         std hasReacted
         ldaa #jmpOPcode
         staa 0,x
         ldd #reactINT
         std 1,x
         cli
                                    ; wait a few seconds before REACTLED
         ldaa #reactWaitTime
         jsr counttimer

         ldaa hasReacted            ; if reaction was premature, abort
         cmpa #1
         beq abort

         ldx #regbase
         bset porta,x REACTLED      ; set REACTLED

         jsr reactWait              ; begin counting reacttime, wait for REACT
         ldx #reacttimemessage      ; print reactiontime to screen
         jsr OUTSTRG
         ldx #reactiontime          
         jsr OUT2BSP
         jsr OUTCRLF

         jmp _start

abort:   ldx #abortmessage          ; print abort message
         jsr OUTSTRG
         jsr OUTCRLF
         jmp _start

end:     
         swi

;---------------------------------------------
; Behaviour: 
;    startWait
;    wait for START signal
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroys:
;       none
;---------------------------------------------
                                    
startWait:  
            ldx #regbase           
            bclr porta,x START      ; clear the START flag
            brclr porta,x, START .  ; loop here until START signal seen
xstartWait: rts

;---------------------------------------------
; Behaviour: 
;    reactWait
;    wait for REACT (IRQ) signal and count how long it took
;    stores the number of 100ms cycles in reactiontime
; Assumptions:
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroys:
;       none
;---------------------------------------------
reactWait:  
            ldx #regbase
            ldd #0                 ; set reactiontime to 0
            std reactiontime

RWloop:     
            jsr sleep100ms
            ldx reactiontime
            inx
            stx reactiontime
            ldaa hasReacted        
            cmpa #1                 ; if user hasn't reacted, increment reactiontime
            bne RWloop             

xreactWait: rts

;---------------------------------------------
; Behaviour: 
;     reactINT - react interrupt
;     sets hasReacted to 1 if REACT signal found (IRQ)
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroys:
;      TODO
;---------------------------------------------
reactINT:
            ldaa #1
            staa hasReacted
xreactINT:  rti

;---------------------------------------------
;        reaction data
;---------------------------------------------
hasReacted: .byte 0       ; set to 1 if REACT signal seen
reactiontime: .word 0     ; reaction time

;---------------------------------------------
; Behaviour: 
;     sleep100ms
;     waits 100ms 
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroys:
;      TODO
;---------------------------------------------
sleep100ms:   
            ldy #NUMINT
				jsr tofClr
				ldd TCNT
				addd #DIFF
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

xsleep100ms:		rts
	
;---------------------------------------------
; Behaviour: 
;     clears TOF
; Assumptions:
;    none
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroys:
;      TODO
;---------------------------------------------
tofClr: 		ldaa #0x80
				staa TFLG2
xtofClr:		rts

;---------------------------------------------
; Behaviour: 
;    count n 100ms cycles
; Assumptions:
;     n passed on acca
; Restriction:
;    none
; Register and Memory Usage:
;    Precondition:
;    Postcondition:
;    Destroys:
;      TODO
;---------------------------------------------
counttimer:		
            staa TMAX               ; keep track of how long we need to count to 
            ldaa #0
            staa TCOUNT

ctloop:			                     ; keep sleeping 100ms until TMAX equals n
            ldaa TMAX
            cmpa TCOUNT
            beq xcounttimer
            jsr sleep100ms
            inc TCOUNT
            ldaa reactiontime       ; if user reacted, abort
            cmpa #1
            beq xcounttimer
            jmp ctloop
			
xcounttimer:
            rts

;-----------------------------------------
;         Data Area
;-----------------------------------------
startmessage: .asciz "Beginning Sequence"
.byte eot
abortmessage: .asciz "Aborting: reacted too soon"
.byte eot
testmessage: .asciz "test"
.byte eot
reacttimemessage: .asciz "Reaction Time: "
.byte eot
TCOUNT: .byte 0                     ; number of counts done by counttimer
TMAX: .byte 0                       ; number of counts to be done by counttimer

; set up dummy frame pointer
.global _.frame
_.frame: .word

.end
