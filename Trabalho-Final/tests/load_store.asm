.text
	addi t0, zero, 8
	addi t1, zero, 7
	
	sw t1, (t0)
	lw t2, (t0)
	
	
	sw t1, 4(t0)
	lw t2, 4(t0)

loop:
	beq zero, zero, loop
