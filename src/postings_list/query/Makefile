CC=gcc

scanner:
	ragel -I../../common -m -G2 scanner.rl
	ragel -I../../common -m -G2 reader.rl
	gcc    -I../../common/ scanner.c  example.c reader.c ../../common/walk_dir.c main.c  ../../common/xxhash.c funcs.c ../../common/canonicalFromStr.c -o scanner.out -lm
	#rm hello_world
	#./scanner . 
	#/scanner . hello_world
