CC=gcc


get_symbols:
	ragel -m -G2 get_symbols.rl
	ragel -m -G2 reader.rl
	gcc  -g get_symbols.c reader.c walk_dir.c main.c  -o get_symbols.out -lm
	#./get_symbols.out .. 
	#or
	#./get_symbols.out .. sound1.tex	


