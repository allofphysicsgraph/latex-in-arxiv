all:
	bison -d expr.y
	flex expr.l
	cc expr.tab.c lex.yy.c -lm -lfl
