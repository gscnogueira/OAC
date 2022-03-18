// Autor: Gabriel da Silva Corvino Nogueira
// Matrícula: 180113330
// Email: 180113330@aluno.unb.br
// Disciplina: CIC0099 - Organização e Arquitetura de computadores
// Professor: Ricardo Puzzuol Jacobi
// Turma: C
// COMPILADOR: GCC 11.1.0 (utilizar o comando make para facilitar o processo de compilação)
// SISTEMA OPERACIONAL: GNU/Linux kernel 5.15.11-arch2-1
// IDE: Emacs 27.2

#include <bits/stdc++.h>
#include "utils.h"
#include "globals.h"

using namespace std;



int main() {

    init();
    load_mem("code.bin", TEXT_SEGMENT_START);
    load_mem("data.bin", DATA_SEGMENT_START);
    run();
  
    return 0;
}
