;;; This program only stores 0 from 0x100 to 0x140
loop:	SD x0, 100H(x0)		;+0x0
	SD x0, 108H(x0)		;+0x4
	SD x0, 110H(x0)		;+0x8
	SD x0, 118H(x0)		;+0xC
	SD x0, 120H(x0)		;+0x10
	SD x0, 128H(x0)		;+0x14
	SD x0, 130H(x0)		;+0x18
	SD x0, 138H(x0)		;+0x1C
	SD x0, 140H(x0)		;+0x20
	SUBLEQ x0, x0, -28H		;+0x24 loop back
	
