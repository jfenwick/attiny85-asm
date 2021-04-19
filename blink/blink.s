; Original code at http://karooza.net/going-bare-metal-on-the-attiny85
; Modified to work on gavrasm

.equ SPH=0x3E				; Stack Pointer High Address
.equ SPL=0x3D				; Stack Pointer Low Address
.equ DDRB=0x17				; Data Direction Register PortB
.equ PORTB=0x18				; PortB output register


.org		0x0000				; Start of program
	rjmp	0x0010				; Jump over vectors to main part

.org		0x0010				; Main part of code

	ldi 	r16, 0x02			; Setting up the stack at top of RAM
	out 	SPH, r16
	ldi 	r16, 0x5F
	out 	SPL, r16
	
	ldi 	r16, 0x01			; Set PB0 as output
	out	DDRB, r16

loop1:						; Outer loop	
	ldi   	r25, 0xC3			; Load register pair r24 and r25
	ldi   	r24, 0x50  			; Low byte
	
	ldi	r16, 0x01			; Toggle PB0
	in	r17, PORTB			; Get current port bits
	eor	r17, r16			; Perform XOR
	out	PORTB, r17			; Write to PortB
	
loopDelay:					; Inner delay loop	
	rcall	delay				; Burn some cycles
	rcall	delay
	rcall	delay
	
	sbiw   	r24,1				; Subtract, Z = 1 if result 0
	
	brne 	loopDelay 			; Branch if r17 != 0
	rjmp 	loop1				; Run outer loop 

	
 ; Burns 10 cycles when called
 ; rcall=3 + ret=4 + nop=3
 delay:
  nop
  nop
  nop
  ret 