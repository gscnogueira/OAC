.data
mat1: .byte
	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 1 1 0 0 0 1 0 0 0 0 0 0 0 0 0
 	0 1 1 0 0 0 0 1 0 0 0 0 0 0 0 0
 	0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 1 1 0 0 0 0 0 1 1 1 0 0 0
	0 0 1 1 0 0 0 0 0 0 0 1 0 0 0 0
 	0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
mat2: .byte 0:255 

heap: .word 0x00003000
display_size: .word 0x400
cor: .word 0x00ff0000
.text

li a0, 1
li a1, 2
la a2, mat1

call readm
call print


j exit

readm:
	slli t4, a0, 4
	# obter posição relativa à linha:
	add t4,t4, a1  
	# obter posição relativa à coluna:
	add t4, t4, a2 
	lb a0, 0(t4)
	ret
plotm:
	lw s0, heap # carrega endereço do display
	lw s1, cor  # carrega cor das células 
	lw s2, display_size # carrega tamanho do display em bytes
	add t2, t2, t0
	L1:
	beq t0, t2, exit
	sw t1, 0(t0)
	addi t0, t0, 4
	j L1
	
	
exit:
	li a7, 10
	ecall
print:
	li a7, 1
	ecall
	ret
	
