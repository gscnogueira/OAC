#include "globals.h"
#include "riscv.h"
#include "utils.h"
#include <fstream>

#define get_field(word, index, mask) (word >> index)&mask
#define get_bit(word, index) (word >> index)&1

void init()
{
	breg[SP] = sp;
	breg[GP] = gp;
}

bool load_mem(const char *file_name, int start)
{
	fstream file;
	file.open(file_name, ios::in | ios::binary);

	if (!file)
		return false;

	int word;
	int index = start / 4;

	while (true) {
		file.read((char *)&word, sizeof(int));

		if (file.eof())
			break;

		mem[index] = word;
		index++;
	}

	return true;
}

void fetch()
{
  ri = lw(pc, 0);
  pc += 4;

}

int extend_sign(int n, int bit_len) {
    n <<= (WORD - bit_len);
    n >>= (WORD - bit_len);
    return n;
}

int get_imm12_i(uint32_t ri)
{
	int imm12_i = get_field(ri, 20, 0xFFF);
    imm12_i = extend_sign(imm12_i, 12);
	return imm12_i;
}

int get_imm12_s(uint32_t ri) {
    int bit_11_5 = get_field(ri, 25, 0X7F);
    int bit_4_0  = get_field(ri, 7, 0x1F);

    bit_11_5 <<= 5;

    int imm12_s = bit_11_5 | bit_4_0;
    imm12_s = extend_sign(imm12_s, 12);

    return imm12_s;
}

int get_imm13(uint32_t ri)
{
    int bit_12   = get_field(ri, 31, 1);
    int bit_11   = get_field(ri, 7, 1);
    int bit_10_5 = get_field(ri, 25, 0x3F);
    int bit_4_1  = get_field(ri, 8,0xF);


    bit_12   <<= 12;
    bit_11   <<= 11;
    bit_10_5 <<= 5;
    bit_4_1  <<= 1;

    int imm13 = bit_12 | bit_11 | bit_10_5 | bit_4_1;
    imm13 = extend_sign(imm13, 13);

    return imm13;
}

int get_imm20_u(uint32_t ri)
{
	int imm20_u = get_field(ri, 12, 0xFFFFF);
    imm20_u <<=12;

    return imm20_u;
}

int get_imm21(uint32_t ri)
{
    int bit_20 = get_bit(ri,31);
    int bit_19_12 = get_field(ri, 12, 0xFF);
    int bit_11 = get_bit(ri, 20);
    int bit_10_1 = get_field(ri, 21, 0X3FF);

    bit_20 <<= 20;
    bit_19_12 <<= 12;
    bit_11 <<= 11;
    bit_10_1 <<= 1;

    int imm21 = bit_20 | bit_19_12 | bit_11 | bit_10_1;

    imm21 = extend_sign(imm21, 21);
    return imm21;
}

void decode()
{
	opcode  = get_field(ri, 0, 0x7F);
	rd      = get_field(ri, 7, 0x1F);
	rs1     = get_field(ri, 15, 0x1F);
	rs2     = get_field(ri, 20, 0x1F);
	shamt   = get_field(ri, 20, 0x1F);
	funct3  = get_field(ri, 12, 0x07);
	funct7  = get_field(ri, 25, 0x7F);

	imm12_i = get_imm12_i(ri);
	imm12_s = get_imm12_s(ri);
    imm20_u = get_imm20_u(ri);
	imm13   = get_imm13(ri);
	imm21   = get_imm21(ri);
}

void execILAType()
{
	switch (funct3) {
	case ADDI3:
		addi();
		break;
	case ANDI3:
        andi();
		break;
	case SLLI3:
        slli();
		break;
	case ORI3:
        ori();
		break;
	case SR3:
        switch (funct7) {
        case SRAI7:
            srai();
            break;
        case SRLI7:
            srli();
            break;
        }
    }
}

void execILType() {
    switch(funct3) {
    case LW3:
        breg[rd] = lw(breg[rs1], imm12_i);
        break;
    case LB3:
        breg[rd] = lb(breg[rs1], imm12_i);
        break;
    case LBU3:
        breg[rd] = lbu(breg[rs1], imm12_i);
        break;
    }
}

void execBType() {
    switch(funct3){
    case BEQ3:
        beq();
        break;
    case BNE3:
        bne();
        break;
    case BLT3:
        blt();
        break;
    case BGE3:
        bge();
        break;
    case BLTU3:
        bltu();
        break;
    case BGEU3:
        bgeu();
        break;
    }
}

void execRegType() {
  switch (funct3) {
  case ADDSUB3:
    switch (funct7) {
    case ADD7:
        add();
        break;
    case SUB7:
        sub();
        break;
    }
      break;
  case XOR3:
      xor_();
      break;
  case AND3:
      and_();
      break;
  case OR3:
      or_();
      break;
  case SLT3:
      slt();
      break;
  case SLTU3:
      sltu();
      break;
  }
}

void execStoreType() {
  switch (funct3) {
  case SW3:
      sw(breg[rs1], imm12_s,breg[rs2]);
      break;
  case SB3:
      sb(breg[rs1], imm12_s,breg[rs2]);
      break;
  }
}

void execute()
{
	switch (opcode) {
	case AUIPC:
        auipc();
		break;
	case LUI:
        lui();
		break;
    case ILType: {
        execILType();
        break;
    }
    case BType:
        execBType();
        break;
    case JAL:
        jal();
		break;
	case StoreType:
        execStoreType();
		break;
	case ILAType:
		execILAType();
		break;
	case RegType:
        execRegType();
		break;
	case ECALL:
		ecall();
		break;
	case JALR:
        jalr();
		break;
	}

    breg[ZERO] = 0;
}

void step()
{
	fetch();
	decode();
    execute();
}

void run(bool summ, bool dump)
{
	while (pc < DATA_SEGMENT_START and not stop_prg) {
		step();
        if (summ) {
            summary();
            getchar();
        }
        if(dump){
            dump_reg();
            getchar();
        }
    }

}

void summary()
{
	printf("opcode : 0x%02x\n", opcode);
	printf("rd     : 0x%02x\n", rd);
	printf("rs1    : 0x%02x\n", rs1);
	printf("rs2    : 0x%02x\n", rs2);
	printf("shamt  : 0x%08x\n", shamt);
	printf("funct3 : 0x%01x\n", funct3);
	printf("funct7 : 0x%02x\n", funct7);
	printf("imm12_i: 0x%03d\n", imm12_i);
	printf("imm12_s: 0x%03x\n", imm12_s);
	printf("lmm13  : 0x%04x\n", imm13);
	printf("imm20_u: 0x%04x\n", imm20_u);
	printf("imm21  : 0x%05x\n", imm21);
}

void dump_memory(uint32_t start_byte, uint32_t end_byte, char format)
{
	int start_intex = start_byte / 4;
	int end_index = end_byte / 4;

	printf("  Address  |   Value\n");
	printf("-----------+-----------\n");
	for (int i = start_intex; i <= end_index; i++) {
		printf("0x%08x | 0x%08x\n", i * 4, mem[i]);
	}
	printf("-----------+-----------\n");
}

void dump_reg(char format)
{
	string base_str = format == 'h' ? "0x%08x\n" : "%10d\n";

	stringstream ss, ss2;
	ss << "%s |   %02d   |" << base_str;
	string format_banco = ss.str();

	ss2 << "PC   |        |" << base_str;
	string format_pc = ss2.str();

	printf("Name | Number | Value\n");
	printf("-----+--------+----------\n");
	for (int i = 0; i < 32; i++) {
		printf(format_banco.c_str(), reg_str[i].c_str(), i, breg[i]);
	}
	printf(format_pc.c_str(), pc);

}
