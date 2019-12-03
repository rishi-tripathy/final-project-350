nop
nop
nop
nop
loop:
	nop
	nop
	bne $r1, $r15, loop
nop
nop
addi $r5, $r0, 1
nop
nop
addi $r5, $r0, 0
j loop