nested_expression_test:
	ragel -m -G2 nested.rl
	gcc  -g nested.c -o nested.out -lm
	./nested.out nested_test
