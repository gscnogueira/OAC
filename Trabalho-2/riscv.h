/*
 *  riscv.h
 *  RV32I
 *
 *  Created by Ricardo Jacobi on 17/09/19.
 *  Copyright 2019 Universidade de Brasilia / York. All rights reserved.
 *
 */

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

inline void addi() {breg[rd] = breg[rs1] + imm12_i;}

inline void andi() {breg[rd] = breg[rs1] & imm12_i;}

void slli();

void srai();

void srli();

void ori();

//
// AUIPC
//

inline void auipc() {breg[rd] = pc -4  + imm20_u;};

//
// JAL
//

void jal();

//
// JALR
//

void jalr();

//
// BRANCHES
//

void beq();

void bne();

void bge();

void bgeu();

void blt();

void bltu();

//
// FUNÇÕES DO SISTEMA
//


void ecall();


#endif
