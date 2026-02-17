CC = clang
TARGET = main
SRC = src/main.S src/ui.S src/random.S src/game.S src/tools/helpers.c

$(TARGET): Makefile $(SRC)
	$(CC) $(SRC) -o $(TARGET)
