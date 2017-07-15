;;; This program performs 1 + 1 and stores 2 in 0x100
	LD x1, ZERO(x0)		; Load 0 to x1 +0x0
	LD x2, ONE(x0)		; Load 1 to x2
	SUBLEQ x1, x2, 0	; x1 := x1 - x2 = -1 Stall and Forward
	SUBLEQ x2, x1, 0	; x2 := x2 - x1 = 1 - (-1) = 2
	SUBLEQ x1, x1, 0	; Reset x1 +0x10
	SD x2, 0x100(x0)	; Store result
loop:				; +0x18
	SUBLEQ x0, x0, loop
	.data
	.align 8
ONE:	.long 1			; +0x20
ZERO:	.long 0			; +0x28
	
