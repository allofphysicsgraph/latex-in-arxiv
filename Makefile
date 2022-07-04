
mytag=latexinarxiv

CFLAGS = -Iopenssl/include -g
LDFLAGS = -Lopenssl/
LDLIBS = -lcrypto

help:
	@echo "== outside the container =="
	@echo "make docker"
	@echo "         for linux"
	@echo "  "
	@echo "make docmac"
	@echo "         for Mac"
	@echo "== inside the container =="
	@echo "make openssl"
	@echo "make sampledata"
	@echo "make lexer"


# Docker on linux
docker:
	sudo service docker start
	sudo docker build -t $(mytag) .
	sudo docker run -it --rm $(mytag) /bin/bash

# Docker on Mac
docmac: dockermac_build dockermac_run
dockermac_build:
	docker build -t $(mytag) .

dockermac_run:
	docker run -it --rm -v `pwd`:/scratch $(mytag) /bin/bash


sampledata:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
	tar -xf hep-th-2003.tar.gz
	mkdir 2003_errors

md5:
	gcc EVP_MD.c -Iopenssl/include/ -Lopenssl/ -lcrypto


curl:
	git clone https://github.com/curl/curl
	cd curl && mkdir build && cd build && cmake .. && make && make install

#version change to 1.1.1 for koreio
openssl:
	wget https://www.openssl.org/source/openssl-1.1.1p.tar.gz
	tar -xf openssl-1.1.1p.tar.gz
	cd openssl-1.1.1p && ./config && make && make install && ldconfig

# Kore is an easy to use web platform for writing scalable, concurrent APIs in C or Python.
koreio:
	wget https://kore.io/releases/kore-4.2.2.tar.gz --no-check-certificate
	tar -xf kore-4.2.2.tar.gz
	cd kore-4.2.2 && make TLS_BACKEND=none PYTHON=1 DEBUG=1 CURL=1 TASKS=1  &&  make install


delatex:
	git clone https://github.com/pkubowicz/opendetex.git
	cd opendetex/ &&  make  && sudo cp delatex /usr/bin/
 
install_libbloom:
	bash libbloom.sh

bloom:
	flex -Cf bloom_filter_test.l
	gcc -O3 -g -lfl lex.yy.c -Ilibbloom libbloom/bloom.c -Llibbloom/build/libbloom.so libbloom/murmur2/MurmurHash2.c  -lm -lncurses -o bloom_filter


newcommand:
	gcc -Wall -Wunused -o newcommand newcommand.c
	/bin/bash run_new_command.sh

parse_docs:
	# xargs -i either doensn't work on dragonfly bsd or does not have the same meaning
	# adjust for the number of cores that you want to allocate.
	find 2003 -type f |xargs -i -P6  python new_lexer.py "{}"


clean:
	$(RM) lexer lex.yy.c
	$(RM) *.o EVP_MD

