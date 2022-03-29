		INCLUDE	"mcp.i"

		IMPORT	hello

		SECTION	"Entry",CODE
Entry::		
		moveq	#0,d1		; channel
		move.l	#helloStr,d2
		moveq	#helloStr_len,d3
		SYSCALL	chan_write

		moveq	#0,d1		; return value
		SYSCALL	exit

		SECTION	"Data",DATA
helloStr	DC.B	"Hello, world!"
helloStr_len	EQU	@-helloStr
