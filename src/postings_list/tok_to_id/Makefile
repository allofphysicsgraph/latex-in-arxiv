CC=gcc


get_symbols:
	ragel -m -G2 -I../../common get_symbols.rl
	gcc  -g -I../../common  ../../common/xxhash.c get_symbols.c ../../common/walk_dir.c main.c  -o get_symbols.out -lm
	 ./get_symbols.out ../../common

