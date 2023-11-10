nested_expression_test:
	ragel -V -Z -p -o nested.dot nested.rl
	ragel   -m -G2 nested.rl
	gcc  -g nested.c -o nested.out -lm
	./nested.out nested_test
