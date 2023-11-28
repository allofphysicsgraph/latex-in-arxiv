CC=gcc

install_ragel:
	/bin/bash install_ragel.sh


scanner:
	ragel -I../../common -m -G2 scanner.rl
	ragel -I../../common -m -G2 reader.rl
	gcc   -I../../common/ scanner.c  reader.c ../../common/walk_dir.c main.c  ../../common/xxhash.c funcs.c ../../common/canonicalFromStr.c -o scanner.out -lm
	#./scanner.out ../sound1.tex > output


