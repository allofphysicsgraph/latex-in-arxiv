install_flex:
	sudo apt install libtool
	sudo apt install texinfo
	sudo apt install help2man
	git clone https://github.com/westes/flex
	cd flex && bash autogen.sh && ./configure && make && sudo make install && sudo cp src/flex /usr/bin/

install_sds:
	git clone https://github.com/antirez/sds
	cp sds/sds* .

base:
	flex -CFa scanner.l
	gcc -g -O3 lex.S1_.c resub.c main.c -lfl -o frac.out 
	./frac.out ../../sound1.tex


