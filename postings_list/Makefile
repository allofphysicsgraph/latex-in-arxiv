#nested_expression_test:
#	ragel -V -Z -p -o nested.dot nested.rl
#	ragel   -m -G2 nested.rl
#	gcc  -g nested.c -o nested.out -lm
#	./nested.out nested_test

all:
	#ragel -V -Z -p -o strings.dot strings.rl
	ragel   -m -G2 strings.rl
	gcc  -g strings.c -o strings.out -lm
	./strings.out sound1.tex

