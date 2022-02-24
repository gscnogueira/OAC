simulador: main.o utils.o
	g++ -o simulador -std=c++17 -Wall main.o utils.o

main.o: main.cpp globals.h utils.h
	g++ -c main.cpp

utils.o: utils.cpp utils.h globals.h
	g++ -c utils.cpp



