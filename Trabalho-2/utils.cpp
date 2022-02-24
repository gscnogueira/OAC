#include "utils.h"
#include "globals.h"
#include <fstream>

int mem[MEM_SIZE];

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

void dump_memory(uint32_t start_byte, uint32_t end_byte, char format)
{
    int start_intex = start_byte/4;
    int end_index = end_byte/4;

    printf("  Address  |   Value\n");
    printf("-----------+-----------\n");
    for(int i = start_intex; i <= end_index; i++){
        printf("0x%08x | 0x%08x\n",i*4, mem[i]);
    }
}
