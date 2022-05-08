.text
	addi t0, zero, 8
	addi t1, zero, 8
	addi t2, zero, 7
	
teste1:
	beq t1, t2, teste2
	addi a0, zero, 1
	
teste2:
	bne t1, t2, teste3
	addi a1, zero, 1
	
teste3:
	blt t0, t1, teste4
	addi a2, zero, 1
	
teste4:
	bltu t0, t1, teste5
	addi a3, zero, 1

teste5:
	bge t0, t1, teste6
	addi a4, zero, 1

teste6:
	bge t2, t0, loop
	addi a5, zero, 1

	
loop:
	beq zero, zero, loop
