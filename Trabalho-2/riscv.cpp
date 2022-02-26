#include "riscv.h"
#include "globals.h"

using namespace std;

//
// FUNÇÕES DE ACESSO À MEMÓRIA
//

int32_t lw(uint32_t address, int32_t kte)
{
	uint32_t endereco = address + kte;
	if (endereco % 4) {
		printf("Endereço de memória deve ser um múltiplo de 4\n");
		return 0;
	}
	endereco /= 4;
	return mem[endereco];
}

int32_t lb(uint32_t address, int32_t kte)
{
	uint32_t endereco = address + kte;
	int8_t *ptr = (int8_t *) mem;
	return *(ptr + endereco);
}

int32_t lbu(uint32_t address, int32_t kte)
{
	uint32_t endereco = address + kte;
	int8_t *ptr = (int8_t *) mem;
	uint8_t tmp = *(ptr + endereco);
	return tmp;
}

void sw(uint32_t address, int32_t kte, int32_t dado)
{
	uint32_t endereco = address + kte;
	if (endereco % 4) {
		printf("Endereço de memória deve ser um múltiplo de 4\n");
		return;
	}
	endereco /= 4;
	mem[endereco] = dado;
}

void sb(uint32_t address, int32_t kte, int8_t dado)
{
	uint32_t endereco = address + kte;
	int8_t *ptr = (int8_t *) mem;
	*(ptr + endereco) = dado;
}

//
// FUNÇÕES LÓGICO-ARITMETICAS COM IMEDIATO
//


//
// JAL
//

void jal() {
    breg[rd] = pc;
    // printf("vai somar %d", imm21);
    pc += imm21 -4 ;
}


//
// BRANCHES
//

void beq() {
    pc = breg[rs1] == rs2 ? pc + imm13 -4 : pc;
}
//
// ECALL
//

void print_str() {
    uint32_t addres = breg[A0];
    char* blau = (char *) mem + addres;
    printf("%s", blau);
}

void print_int() {
    printf("%d", breg[A0]);
}

void ecall()
{
	switch (breg[A7]) {
	case 10:
		stop_prg = true;
		break;
    case 4:
        print_str();
        break;
	case 1:
		print_int();
        break;
	}

}
