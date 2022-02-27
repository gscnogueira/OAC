#include <bits/stdc++.h>
#include "utils.h"
#include "globals.h"

#define get_field(word, index, mask) (word >> index)&mask
using namespace std;



int main() {
    init();
    load_mem("code.bin", TEXT_SEGMENT_START);
    load_mem("data.bin", DATA_SEGMENT_START);
    // dump_memory(DATA_SEGMENT_START, DATA_SEGMENT_START + 4*20);
    // run(true, true);
    run();
    // dump_reg('h');
    

  
    return 0;
}
