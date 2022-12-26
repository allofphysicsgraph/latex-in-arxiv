all:
	ragel author_statechart_standalone.rl
	gcc author_statechart_standalone.c -o author.out
	#./author.out ../sound1.tex
	ragel title.rl
	gcc title.c -o title.out
	ragel cite.rl
	gcc cite.c -o cite.out	
	ragel abstract.rl
	gcc abstract.c -o abstract.out


clean:
	rm *~
	rm *.out
