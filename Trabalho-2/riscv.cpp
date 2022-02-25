#include "riscv.h"
#include "globals.h"

using namespace std;


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

void addi() {
    breg[rd] = breg[rs1] + imm12_i;
}


void ecall() {
    switch(breg[A7]){
    case 10:
        stop_prg = true;
        break;
    default:
        printf("Instrução ainda não suportada pelo simulador\n");
    }
  
}
