#include "globals.h"
#include "riscv.h"
#include "utils.h"
#include <fstream>

#define get_field(word, index, mask) (word >> index)&mask

bool load_mem(const char *file_name, int start)
{
    fstream file;
    file.open(file_name, ios::in | ios::binary);

    if (!file)
        return false;

    int word;
    int index = start/4;

    while(true)
    {
        file.read((char *) &word, sizeof(int));

        if (file.eof())
            break;

        mem[index] = word;
        index++;
    }

    return true;
}

void fetch() {
    ri = lw(pc, 0);
    pc += 4;
  
}

void decode() {
    opcode = get_field(ri,0, 0x7F);
    rd = get_field(ri,7, 0x1F);
    rs1 = get_field(ri, 15, 0x1F);
    rs2 = get_field(ri, 20, 0x1F);
    shamt = get_field(ri, 20, 0x1F); // implementar
    funct3 = get_field(ri, 12, 0x07);
    funct7 = get_field(ri, 25, 0x7F);
    imm12_i = get_field(ri,20, 0xFFF);
    imm12_s = get_field(ri, 20, 0xFFF);
    imm13 = get_field(ri, 20, 0x1f); //implementar
    imm20_u = get_field(ri, 12, 0xFFFFF);
    imm21 = get_field(ri, 12, 0x1f); //implementar
}

void summary() {
    printf("opcode : 0x%02x\n", opcode);
    printf("rd     : 0x%02x\n", rd);
    printf("rs1    : 0x%02x\n", rs1);
    printf("rs2    : 0x%02x\n", rs2);
    printf("shamt  : 0x%08x\n", shamt);
    printf("funct3 : 0x%01x\n", funct3);
    printf("funct7 : 0x%02x\n", funct7);
    printf("imm12_i: 0x%03x\n", imm12_i);
    printf("imm12_s: 0x%03x\n", imm12_s);
    printf("lmm13  : 0x%04x\n", imm13);
    printf("imm20_u: 0x%04x\n", imm20_u);
    printf("imm21  : 0x%05x\n", imm21);
}

void dump_memory(uint32_t start_byte, uint32_t end_byte, char format)
{
    int start_intex = start_byte/4;
    int end_index = end_byte/4;

    printf("  Address  |   Value\n");
    printf("-----------+-----------\n");
    for(int i = start_intex; i <= end_index; i++){
        printf("0x%08x | 0x%08x\n",i*4, mem[i]);
    }
    printf("-----------+-----------\n");
}
