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
cor_viva: .word 0x008be9fd
cor_morta: .word 0x44475a
msg: .string "nao valido\n"
.text



la a0, mat1
call plotm

li a7, 32
li a0, 1000
ecall 

la a0, mat1
la a1, mat2
call copy

la a2, mat1
la a3, mat2
li a0, 5
li a1, 12

call conta_vizinhanca
call print

la a2, mat1
la a3, mat2
li a0, 5
li a1, 12


call evolui 

la a0, mat2
call plotm







j exit
#-------------------------------------
copy:
	li t0, 64
	mv t1, zero
loop:
	bge t1, t0, end_loop
	lw t2, 0(a0)
	sw t2, 0(a1)
	addi t1, t1, 1
	addi a0, a0, 4
	addi a1, a1, 4
	j loop
end_loop:
	ret
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
	lw s1, cor_viva
	lw s2, cor_morta  	# carrega cor
	li s3, 0x10 # altura da matriz
	# Inicializa contador
	mv s4, zero
loopi:
	bge s4, s3, endi
	mv s5, zero
loopj:
	bge s5, s3 endj
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	call pinta_pixel
	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp 8
	addi s0, s0, 4
	addi s5, s5, 1
	j loopj
endi:
	ret
endj:
	addi s4, s4, 1
	j loopi	

pinta_pixel:
	addi sp, sp, -4
	sw ra, 0(sp)
	mv a2, a0
	mv a1, s5
	mv a0, s4
	call readm
	lw ra, 0(sp)
	addi sp, sp, 4
	beqz a0, pinta_morta
	sw s1, 0(s0)
	j ppend
pinta_morta:
	sw s2, 0(s0)
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
	
	
	mv s0, zero 	# incializa contador
	addi s1, a0, -1 # i-1
	addi s2, a0, 0  # i
	addi s3, a0, 1	# i+1
	addi s4, a1, -1 # j-1
	addi s5, a1, 0  # j
	addi s6, a1, 1  # j+1
	
	addi sp, sp, -4
	sw ra, 0(sp)
	# [i-1][j-1]
	mv a0, s1
	mv a1, s4
	call readm
	add s0, s0, a0
	# [i-1][j]
	mv a0, s1
	mv a1, s5
	call readm
	add s0, s0, a0
	# [i-1][j+1]
	mv a0, s1
	mv a1, s6
	call readm
	add s0, s0, a0
	# [i][j-1]
	mv a0, s2
	mv a1, s4
	call readm
	add s0, s0, a0
	# [i][j+1]
	mv a0, s2
	mv a1, s6
	call readm
	add s0, s0, a0
	# [i+1][j-1]
	mv a0, s3
	mv a1, s4
	call readm
	add s0, s0, a0
	# [i+1][j]
	mv a0, s3
	mv a1, s5
	call readm
	add s0, s0, a0
	# [i+1][j+1]
	mv a0, s3
	mv a1, s6
	call readm
	add s0, s0, a0
	mv a0, s0

	lw ra, 0(sp)
	addi sp, sp, 4
	ret	
#-------------------------------------
evolui:
# Parâmetros:
# a0: i
# a1: j
# a2: matrix
# Retorno 
# a0: novo valor do ponto(i,j)

	addi sp, sp, -12
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	
	call conta_vizinhanca
	mv s0, a0
	lw a0, 4(sp)
	lw a1, 8(sp)
	
	call readm
	mv s1, a0
	lw a0, 4(sp)
	lw a1, 8(sp)
	
	mv a2, a3
	beqz s1, nasce
	li t1, 1
	sgt t1, s0, t1 # checa se tem mais de um vizinho
	slti t2, s0, 4 # checa se tem menos de 4 vizinhos
	and t1, t1, t2  # checa se das duas condições são satisfeitas
	beqz t1, morre
sobrevive:
	j fim_evolui
morre:
	call write
	j fim_evolui
nasce:
	li t1, 3
	bne s0, t1, fim_evolui
	call write
	j fim_evolui
	
fim_evolui:	
	lw ra, 0(sp)
	addi, sp, sp, 12
	ret
#-------------------------------------
step:
	
#-------------------------------------

exit:
	li a7, 10
	ecall
print:
	li a7, 1
	ecall
	ret
error:
	
	
	
