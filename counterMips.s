nop
nop
addi $r2, $r0, 5
loop:
	nop
	addi $r1, $r1, 1
	bne $r1, $r2, loop
