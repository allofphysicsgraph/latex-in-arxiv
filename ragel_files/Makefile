all:
	ragel author_statechart.rl
	gcc author_statechart.c -o author.out
	#./author.out ../sound1.tex
	
	ragel abstract.rl
	gcc abstract.c -o abstract.out


clean:
	rm *~
	rm *.out
