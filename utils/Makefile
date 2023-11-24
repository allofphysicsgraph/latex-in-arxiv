variable_definitions:
	flex variable_definitions.l
	gcc -lfl lex.yy.c -o variable_definitions.out
	#./variable_definitions.out  ../sound1.tex |grep '<:.*?:>' -oP
