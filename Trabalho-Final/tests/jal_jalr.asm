.text
	
	addi t0, zero, 8
    	jalr t1, t0, 8
    	addi a0, zero, 1
   	addi a1, zero, 2
	addi a2, zero, 3
	
	jal skip
	addi a2, a2, 3
	jal loop

skip:
	addi a2, a2, 3
	ret

loop:
	beq zero, zero, loop
