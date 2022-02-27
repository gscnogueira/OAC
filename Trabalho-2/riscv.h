#ifndef __RISCV_H__
#define __RISCV_H__

#include <iostream>
#include <map>
#include "globals.h"

using namespace std;

#define get_byte_0(w) (w & 0xFF)
#define get_byte_1(w) ((w>>8) & 0xFF)
#define get_byte_2(w) ((w>>16) & 0xFF)
#define get_byte_3(w) ((w>>24) & 0xFF)

// init instruction strings
void build_dic();

//
// FUNÇÕES DE ACESSO À MEMÓRIA
//

int32_t lw(uint32_t address, int32_t kte);

int32_t lb(uint32_t address, int32_t kte);

int32_t lbu(uint32_t address, int32_t kte);

void sw(uint32_t address, int32_t kte, int32_t dado);

void sb(uint32_t address, int32_t kte, int8_t dado);

//
// FUNÇÕES LÓGICO-ARITMETICAS COM IMEDIATO
//

inline void addi()
{
	breg[rd] = breg[rs1] + imm12_i;
}

inline void andi()
{
	breg[rd] = breg[rs1] & imm12_i;
}

inline void slli() {
    breg[rd] = breg[rs1] << shamt;
}

inline void srai() {
    breg[rd] = breg[rs1] >> shamt;
}

inline void srli() {
    breg[rd] = ((uint32_t) breg[rs1] ) >> shamt;
}


inline void ori() {
    breg[rd] = breg[rs1] | imm12_i;
}

//
//REGType INSTRUCTIONS
//

inline void add() {
    breg[rd] = breg[rs1] + breg[rs2];
}

inline void sub() {
    breg[rd] = breg[rs1] - breg[rs2];
}

inline void and_() {
    breg[rd] = breg[rs1] & breg[rs2];
}

inline void or_() {
    breg[rd] = breg[rs1] | breg[rs2];
};

inline void xor_() {
    breg[rd] = breg[rs1] ^ breg[rs2];
  
}

inline void sltu() {
    breg[rd] = ((uint32_t) breg[rs1] ) < ((uint32_t) breg[rs2] ) ? 1 : 0;
};

inline void slt() {
    breg[rd] =  breg[rs1] < breg[rs2] ? 1 : 0;
};

//
// LUI
//

inline void lui() {
    breg[rd] = imm20_u;
}
//
// AUIPC
//

inline void auipc()
{
	breg[rd] = pc - 4 + imm20_u;
}

//
// JUMPS
//

void jal();

void jalr();

//
// BRANCHES
//

inline void beq()
{
	pc = breg[rs1] == breg[rs2] ? pc + imm13 - 4 : pc;
};

inline void bne()
{
	pc = breg[rs1] != breg[rs2] ? pc + imm13 - 4 : pc;
};

inline void bge()
{
	pc = breg[rs1] >= breg[rs2] ? pc + imm13 - 4 : pc;
};

inline void bgeu()
{
	pc = ((uint32_t) breg[rs1]) >= ((uint32_t) breg[rs2]) ?
	    pc + imm13 - 4 : pc;
};

inline void blt()
{
	pc = breg[rs1] < breg[rs2] ? pc + imm13 - 4 : pc;
};

inline void bltu()
{
	pc = ((uint32_t) breg[rs1]) < ((uint32_t) breg[rs2]) ?
	    pc + imm13 - 4 : pc;
};

//
// FUNÇÕES DO SISTEMA
//

void ecall();

#endif
