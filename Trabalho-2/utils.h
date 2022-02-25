#ifndef __UTILS_H__
#define __UTILS_H__

#include <bits/stdc++.h>
#include "globals.h"

bool load_mem(const char *file, int start);

void fetch();

void summary();

void decode();

void executeILA();

void execute();

void step();

void run();

void dump_memory(uint32_t start_byte, uint32_t end_byte, char format='h');

void dump_reg(char format='h');


#endif
// void init();
// void fetch (instruction_context_st& ic);
// void decode (instruction_context_st& ic);
// void print_instr(instruction_context_st& ic);
// INSTRUCTIONS get_instr_code(uint32_t opcode, uint32_t func3, uint32_t func7);
// FORMATS get_i_format(uint32_t opcode, uint32_t func3, uint32_t func7);
// void debug_decode(instruction_context_st& ic);
// void dump_breg();
// void dump_asm(int start, int end);
// void dump_mem(int start_byte, int end_byte, char format);
// int load_mem(const char *fn, int start);
// void execute (instruction_context_st& ic);
// void step();
// void run();
