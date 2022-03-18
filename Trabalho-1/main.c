/* Autor      : Gabriel da Silva Corvino Nogueira
 * Matrícula  : 180113330
 * E-mail     : 180113330@aluno.unb.br
 * Disciplina : CIC0099 ORGANIZAÇÃO E ARQUITETURA DE COMPUTADORES
 * Professor  : Ricardo Pezzuol Jacobi
 * Turma      : C
*/
#include <stdio.h>
#include <stdint.h>

#define MEM_SIZE 4096
int32_t mem[MEM_SIZE];

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

int main()
{
	/* 1) executa operações de escrita */
    /* a) */
	sb(0, 0, 0x04);
	sb(0, 1, 0x03);
	sb(0, 2, 0x02);
	sb(0, 3, 0x01);

    /* b) */
	sb(4, 0, 0xFF);
	sb(4, 1, 0xFE);
	sb(4, 2, 0xFD);
	sb(4, 3, 0xFC);

    /* c) */
	sw(12, 0, 0xFF);
	sw(16, 0, 0xFFFF);
	sw(20, 0, 0xFFFFFFFF);
	sw(24, 0, 0x80000000);

    /* d) */
    sb(31, 0, 0xAF);
    sb(31, -2, 0xB0);
    sb(31, -3, 0xFE);
    sb(32,  3, 0xFE);
    sb(36,  2, 0xF0);
    sb(40,  1, 0xFE);
    sb(44,  0, 0xF0);
    sw(500, -100, 0xCAFEEEEE);
    sw(0, 444, 0xF0CAF0FA);
    sw(MEM_SIZE, -4, 0xAEEEEEEE);



	/* 2) Imprime contúdo escrito na memória */
	printf("1) Conteúdo carregado na memória:\n\n");
	printf("\ta) mem[0]   = %08x\n", mem[0]);
	printf("\tb) mem[1]   = %08x\n", mem[1]);
	printf("\tc) mem[2]   = %08x\n", mem[2]);
	printf("\td) mem[3]   = %08x\n", mem[3]);
	printf("\te) mem[4]   = %08x\n", mem[4]);
	printf("\tf) mem[5]   = %08x\n", mem[5]);
	printf("\tg) mem[6]   = %08x\n", mem[6]);
	printf("\th) mem[7]   = %08x\n", mem[7]);
	printf("\ti) mem[8]   = %08x\n", mem[8]);
	printf("\tj) mem[9]   = %08x\n", mem[9]);
	printf("\tk) mem[10]  = %08x\n", mem[10]);
	printf("\tl) mem[11]  = %08x\n", mem[11]);
	printf("\tm) mem[100] = %08x\n", mem[100]);
	printf("\tn) mem[111] = %08x\n", mem[111]);
	printf("\tn) mem[%d] = %08x\n", ( MEM_SIZE - 4)/4, mem[(MEM_SIZE - 4)/4]);

	/* 3) ler dados e imprimir em hexadecimal  */
	printf("\n2) Leitura de dados:\n\n");

	/* a) */
    printf("\ta)\n");
	printf("\t  lb(4, 0) -> 0x%08x =  %d\n", lb(4, 0), lb(4, 0));
	printf("\t  lb(4, 1) -> 0x%08x =  %d\n", lb(4, 1), lb(4, 1));
	printf("\t  lb(4, 2) -> 0x%08x =  %d\n", lb(4, 2), lb(4, 2));
	printf("\t  lb(4, 3) -> 0x%08x =  %d\n", lb(4, 3), lb(4, 3));

	/* b) */
    printf("\n\tb)\n");
	printf("\t  lbu(4, 0) -> 0x%08x = %d\n", lbu(4, 0), lbu(4, 0));
	printf("\t  lbu(4, 1) -> 0x%08x = %d\n", lbu(4, 1), lbu(4, 1));
	printf("\t  lbu(4, 2) -> 0x%08x = %d\n", lbu(4, 2), lbu(4, 2));
	printf("\t  lbu(4, 3) -> 0x%08x = %d\n", lbu(4, 3), lbu(4, 3));

	/* c) */
    printf("\n\tc)\n");
	printf("\t  lw(12, 0) -> 0x%08x = %d\n", lw(12, 0), lw(12, 0));
	printf("\t  lw(16, 0) -> 0x%08x = %d\n", lw(16, 0), lw(16, 0));
	printf("\t  lw(20, 0) -> 0x%08x = %d\n", lw(20, 0), lw(20, 0));

	/* d) */
    printf("\n\td)\n");
	printf("\t  lw(27, -3) -> 0x%08x = %d\n", lw(27, -3), lw(27, -3));
	printf("\t  lbu(27, 0) -> 0x%08x = %d\n", lbu(27, 0), lbu(27, 0));
	printf("\t  lw(20, 0)  -> 0x%08x = %d\n", lw(20, 0), lw(20, 0));
	printf("\t  lw(444, 0) -> 0x%08x = %d\n", lw(444, 0), lw(444, 0));
	printf("\t  lw(0, 444) -> 0x%08x = %d\n", lw(0, 444), lw(0, 444));
	printf("\t  lb(444, 1) -> 0x%08x = %d\n", lb(444, 1), lb(444, 1));
	printf("\t  lb(444, 0) -> 0x%08x = %d\n", lb(444, 0), lb(444, 0));
	printf("\t  lbu(444, 1) -> 0x%08x = %d\n", lbu(444, 1), lbu(444, 1));
	printf("\t  lbu(444, 0) -> 0x%08x = %d\n", lbu(444, 0), lbu(444, 0));

    putchar('\n');
	return 0;
}
