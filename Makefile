
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
	sudo docker build -t latexinarxiv .
	sudo docker run -it --rm latexinarxiv /bin/bash

# Docker on Mac
docmac: dockermac_build dockermac_run
dockermac_build:
	docker build -t latexinarxiv .
dockermac_run:
	docker run -it --rm -v `pwd`:/scratch latexinarxiv /bin/bash


sampledata:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
	tar -xf hep-th-2003.tar.gz

openssl:
	git clone https://github.com/openssl/openssl.git
	cd openssl && ./Configure && make && sudo make install && sudo cp libcrypto.so.3 /usr/lib/ && sudo cp libssl.so.3 /usr/lib/

# Kore is an easy to use web platform for writing scalable, concurrent APIs in C or Python.
koreio:
	wget https://kore.io/releases/kore-4.1.0.tar.gz
	sha256sum -c kore-4.1.0.tar.gz.sha256
	tar -xf kore-4.1.0.tar.gz
	sed -i 's/CFLAGS+=-Wall -Werror/CFLAGS+=-DOPENSSL_API_COMPAT=0x10100000L -Wall /g' kore-4.1.0/kodev/Makefile 
	sed -i 's/CFLAGS+=-Wall -Werror/CFLAGS+=-DOPENSSL_API_COMPAT=0x10100000L -Wall /g' kore-4.1.0/Makefile 
	cd kore-4.1.0 && make PYTHON=1 ACME=1 DEBUG=1 CURL=1 TASKS=1 && sudo make install



md5:
	gcc -Iopenssl/include -g -c EVP_MD.c
	gcc -O3 -Wall -Wextra  -Lopenssl/  EVP_MD.o -lcrypto -o md5

delatex:
	git clone https://github.com/pkubowicz/opendetex.git
	cd opendetex/ &&  make  && sudo cp delatex /usr/bin/
 
bloom:
	flex -Cf bloom_filter_test.l
	gcc -O3 -g -lfl lex.yy.c  -Ilibbloom libbloom/bloom.c -Llibbloom/build/libbloom.so libbloom/murmur2/MurmurHash2.c -lm -lncurses -o bloom_filter


newcommand:
	gcc -Wall -Wunused -o newcommand newcommand.c

clean:
	$(RM) lexer lex.yy.c
	$(RM) *.o EVP_MD

