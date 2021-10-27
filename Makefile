
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
	gcc  sds.c scanner.c words.c file_utils.c -lfl -o lexer 
	#sudo cp lexer /usr/bin
	#cd 2003 && find . -type f |xargs -i -P0 lexer "{}" 

lexer:
	rm -rf lexer
	flex arxiv.l
	gcc -Wall -Wextra  -Wall  sds.c scanner.c words.c file_utils.c -lfl  -o lexer 
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
	cd kore-4.1.0 && make PYTHON=1 ACME=1 DEBUG=1 CURL=1 TASKS=1 && sudo make install


# CDB - An interface to the Constant Database Library
# http://cr.yp.to/cdb.html
cdb:
	git clone https://github.com/howerj/cdb.git
	cd cdb && make && sudo make install && sudo cp cdb /usr/bin/
	cdb -c test_db.cdb <cdb_file

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

