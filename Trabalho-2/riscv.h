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
// identificacao dos registradores do banco do RV32I
//


// FUNÇÕES DE ACESSO À MEMÓRIA

int32_t lw(uint32_t address, int32_t kte);

int32_t lb(uint32_t address, int32_t kte);

int32_t lbu(uint32_t address, int32_t kte);

void sw(uint32_t address, int32_t kte, int32_t dado);

void sb(uint32_t address, int32_t kte, int8_t dado);


// FUNÇÕES ARITMÉTICAS

void addi();

// FUNÇÕES DO SISTEMA

void ecall();

#endif
