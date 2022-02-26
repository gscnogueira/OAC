simulador: main.o utils.o globals.o riscv.o
	g++ -o simulador -std=c++17 -Wall -g main.o utils.o globals.o riscv.o

main.o: main.cpp globals.h utils.h
	g++ -c main.cpp

globals.o: globals.cpp globals.h
	g++ -c globals.cpp

riscv.o: globals.h riscv.cpp riscv.h
	g++ -c riscv.cpp

utils.o: utils.cpp utils.h globals.h riscv.h
	g++ -c utils.cpp

run:
	./simulador


