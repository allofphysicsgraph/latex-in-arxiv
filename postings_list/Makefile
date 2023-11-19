install_ragel:
	/bin/bash install_ragel.sh

strings:
	#ragel -V -Z -p -o strings.dot strings.rl
	ragel   -m -G2 strings.rl
	gcc  -g strings.c -o strings.out -lm
	./strings.out sound1.tex

scanner:
	ragel -m -G2 scanner.rl
	gcc  -g scanner.c -o scanner.out -lm
	./scanner.out ../sound1.tex > output
reader:
	ragel -m -G2 reader.rl
	gcc   reader.c -o reader.out 
	./reader.out output ../sound1.tex

#python_reader:
#	ragel -m -G2 reader.rl
#	gcc  -g -fPIC -shared -o reader.so reader.c 
		
