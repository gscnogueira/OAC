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

void executeILA3() {
    switch(funct3){
    case ADDI3:
        addi();
        break;
    case ANDI3 :
        break;
    case SLLI3:
        break;
    case SR3:
        break;
    case ORI3:
        break;
    }
}

void execute()
{
    switch (opcode){
    case AUIPC:
    {
        cout<<"auipc"<<endl;
        break;
    }
    case LUI:
    {
        cout<<"LUI"<<endl;
        break;
    }
    case ILType:
    {
        cout<<"ILType"<<endl;
        break;
    }
    case BType:
    {
        cout<<"BType"<<endl;
        break;
    }
    case JAL:
    {
        cout<<"JAL"<<endl;
        break;
    }
    case StoreType:
    {
        cout<<"StoreType"<<endl;
        break;
    }
    case ILAType:
    {
        executeILA3();
        break;
    }
    case RegType:
    {
        cout<<"RegType"<<endl;
        break;
    }
    case ECALL:
    {
        cout<<"ECALL"<<endl;
        ecall();
        break;
    }
    case JALR:
    {
        cout<<"JALR"<<endl;
        break;
    }
    default:
        cout<<"mano que"<<endl;
    }
}

void step() {
    fetch();
    decode();
    execute();
}

void run() {
    while(pc < DATA_SEGMENT_START
          and not stop_prg){
        step();
    }
  
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

void dump_reg(char format)
{
    string base_str = format == 'h'? "0x%08x\n" : "%10d\n";

    stringstream ss, ss2;
    ss << "%s |   %02d   |" << base_str;
    string format_banco =  ss.str();


    ss2 << "PC   |        |" << base_str; 
    string format_pc    = ss2.str();


    printf("Name | Number | Value\n");
    printf("-----+--------+----------\n");
    for(int i = 0; i < 32; i++){
        printf(format_banco.c_str(),
               reg_str[i].c_str(),
               i, breg[i]);
    }
    printf(format_pc.c_str(), pc);

}
