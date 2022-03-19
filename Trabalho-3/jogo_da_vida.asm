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
cor: .word 0x008be9fd
.text

la a0, mat1


call plotm


j exit

#-------------------------------------
readm:
	slli t5, a0, 4
	# obter posição relativa à linha:
	add t5,t5, a1  
	# obter posição relativa à coluna:
	add t5, t5, a2 
	lb a0, 0(t5)
	ret
#-------------------------------------
plotm:
	lw s0, heap # carrega endereço do display
	lw s1, cor  	# carrega cor
	li s2, 0x10 # altura da matriz
	# Inicializa contador
	mv t3, zero
loopi:
	bge t3, s2, endi
	mv t4, zero
loopj:
	bge t4, s2 endj
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	call pinta_pixel
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp 8
	addi s0, s0, 4
	addi t4, t4, 1
	j loopj
endi:
	ret
endj:
	addi t3, t3, 1
	j loopi	

pinta_pixel:
	addi sp, sp, -4
	sw ra, 0(sp)
	mv a2, a0
	mv a1, t4
	mv a0, t3
	call readm
	lw ra, 0(sp)
	addi sp, sp, 4
	beqz a0, ppend
	sw s1, 0(s0)
ppend:	ret
	
pFIM: ret	
	
exit:
	li a7, 10
	ecall
print:
	li a7, 1
	ecall
	ret
	
