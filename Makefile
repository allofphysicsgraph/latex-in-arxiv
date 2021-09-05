
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

debug:
	flex -d arxiv.l
	rm -rf lexer
	cc -Iopenssl/include -g -c EVP_MD.c
	cc -Lopenssl/ -Wall EVP_MD.o  sds.c lex.yy.c words.c file_utils.c -lfl -lcrypto -o lexer 
	#sudo cp lexer /usr/bin
	#cd 2003 && find . -type f |xargs -i -P0 lexer "{}" 

lexer:
	rm -rf lexer
	flex arxiv.l
	gcc -Wall -Wextra  -Wall  sds.c lex.yy.c words.c file_utils.c -lfl  -o lexer 
	#sudo cp lexer /usr/bin
	#cd 2003 && find . -type f |xargs -i -P0 lexer "{}" 

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
	cd kore-4.1.0 && make && sudo make install

postgres:
	git clone https://github.com/postgres/postgres.git
	sudo apt install libreadline-dev
	sudo apt install zlib1g-dev
	sudo apt install bison
	sudo apt install flex
	cd postgres/ && ./configure && make 
	cd postgres && sudo make install
	sudo cp /usr/local/pgsql/lib/libpq.so.5 /usr/lib
	gcc postgres_connection_test.c -o pg_connection_test -I/usr/local/pgsql/include/ -L /usr/local/pgsql/lib -lpq

# NNCP is an experiment to build a practical lossless data compressor with neural networks.
nncp:
	wget https://bellard.org/nncp/nncp-2021-06-01.tar.gz
	tar -xf nncp-2021-06-01.tar.gz
	cd nncp-2021-06-01 && make && sudo cp nncp /usr/bin/ && sudo cp libnc.so /usr/lib/

md5:
	gcc -Iopenssl/include -g -c EVP_MD.c
	gcc -O3 -Wall -Wextra  -Lopenssl/  EVP_MD.o -lcrypto -o md5

delatex:
	git clone https://github.com/pkubowicz/opendetex.git
	cd opendetex/ &&  make  && sudo cp delatex /usr/bin/
 


newcommand:
	gcc -Wall -Wunused -o newcommand newcommand.c

clean:
	$(RM) lexer lex.yy.c
	$(RM) *.o EVP_MD

