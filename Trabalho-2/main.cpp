#include <bits/stdc++.h>
#include "utils.h"
#include "globals.h"

#define get_field(word, index, mask) (word >> index)&mask
using namespace std;



int main() {

    init();
    load_mem("code.bin", TEXT_SEGMENT_START);
    load_mem("data.bin", DATA_SEGMENT_START);
    run();
  
    return 0;
}
