.text
	addi t0, zero, 7
	addi t1, zero, 2
	
	add  a0, t0, t1
	sub  a1, t0, t1
	and  a2, t0, t1
	xor  a3, t0, t1
	or   a4, t0, t1
	srli a5, t0, 2
	slli a6, t0, 2
	slt  a7, t0, t1


loop:
	beq zero, zero, loop
