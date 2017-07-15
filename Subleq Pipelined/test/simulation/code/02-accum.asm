	LW x1, ZERO(x0)		; +0x0
	LW x2, ONE(x0)
loop:	SUBLEQ x1, x2, 0
	SUBLEQ x2, x1, 0
	SUBLEQ x1, x1, 0	; +0x10
	SW x2, 0x100(x0)	; +0x14
	SUBLEQ x0, x0, loop	; +0x18
	.align
ONE:	.long 1			; +0x20
ZERO:	.long 0			; +0x20
