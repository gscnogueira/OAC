.text
	addi a0, zero, 8
	addi a1, zero, 7
	
	sw a1, (a0)
	lw a2, (a0)

	sw a1, 4(a0)
	lw a3, 4(a0)

loop:
	beq zero, zero, loop
