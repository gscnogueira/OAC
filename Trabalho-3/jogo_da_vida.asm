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
msg: .string "nao valido\n"
.text

la a2, mat1
li a0, 15
li a1, -1


call readm
call print


j exit

#-------------------------------------
readm:
	li t0, 15
	mv t1, zero
	# i < 0:
	sltz t2, a0  
	or t1, t1, t2
	# j < 0:
	sltz t2, a1
	or t1, t1, t2
	# i > 15:
	sgt t2, a0, t0
	or t1, t1, t2
	# j > 15:
	sgt t2, a1, t0
	or t1, t1, t2
	
	beqz t1, valido
	mv a0, zero
	ret	
valido:	
	# obter posição relativa da linha:
	slli t0, a0, 4
	# obter posição relativa da coluna:
	add t0,t0, a1  
	
	add t0, t0, a2 
	lb a0, 0(t0)
	ret
#-------------------------------------
write:
	# obter posição relativa da linha:
	slli t0, a0, 4
	# obter posição relativa da coluna:
	add t0,t0, a1  
	
	add t0, t0, a2 
	lb a0, 0(t0)
	xori a0, a0, 1
	sb a0, 0(t0)		
	ret
	
#-------------------------------------
plotm:
	lw s0, heap # carrega endereço do display
	lw s1, cor  	# carrega cor
	li s2, 0x10 # altura da matriz
	# Inicializa contador
	mv s3, zero
loopi:
	bge s3, s2, endi
	mv s4, zero
loopj:
	bge s4, s2 endj
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	call pinta_pixel
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp 8
	addi s0, s0, 4
	addi s4, s4, 1
	j loopj
endi:
	ret
endj:
	addi s3, s3, 1
	j loopi	

pinta_pixel:
	addi sp, sp, -4
	sw ra, 0(sp)
	mv a2, a0
	mv a1, s4
	mv a0, s3
	call readm
	lw ra, 0(sp)
	addi sp, sp, 4
	beqz a0, ppend
	sw s1, 0(s0)
ppend:	ret
		
#-------------------------------------
max:
	bge a0, a1, a0_maior
a1_maior:
	mv a0, a1
a0_maior:
	ret	
#-------------------------------------
min:
	ble a0, a1, a0_menor
a1_menor:
	mv a0, a1
a0_menor:
	ret	
	
#-------------------------------------
conta_vizinhanca:
# Parâmetros:
# a0: i
# a1: j
# a2: matrix
# Retorno 
# a0: numero de celulas vizinhas à ceulula localizada em matrix[i][j]
	
	
	
	
#-------------------------------------	
exit:
	li a7, 10
	ecall
print:
	li a7, 1
	ecall
	ret
error:
	
	
	
