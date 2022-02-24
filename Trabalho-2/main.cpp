#include <bits/stdc++.h>
#include "utils.h"
#include "globals.h"
using namespace std;


int main() {
    load_mem("code.bin", TEXT_SEGMENT_START);
    load_mem("data.bin", DATA_SEGMENT_START);
    dump_memory(0, 10);
    dump_memory(DATA_SEGMENT_START, 0x2048);
  
    return 0;
}
