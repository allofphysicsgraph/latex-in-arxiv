#nested_expression_test:
#	ragel -V -Z -p -o nested.dot nested.rl
#	ragel   -m -G2 nested.rl
#	gcc  -g nested.c -o nested.out -lm
#	./nested.out nested_test

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
	gcc  -g reader.c -o reader.out -lm
	./reader.out output ../sound1.tex
