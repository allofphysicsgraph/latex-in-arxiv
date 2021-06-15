
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
	@echo "make parser"

docker:
	sudo service docker start
	sudo docker build -t latexinarxiv .
	sudo docker run -it --rm latexinarxiv /bin/bash

docmac: dockermac_build dockermac_run
dockermac_build:
	docker build -t latexinarxiv .
dockermac_run:
	docker run -it --rm -v `pwd`:/scratch latexinarxiv /bin/bash


sampledata:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
	tar -xf hep-th-2003.tar.gz


lexer:
	flex arxiv.l
	cc -Iopenssl/include -g -c EVP_MD.c
	cc -Lopenssl/ -Wall EVP_MD.o  sds.c lex.yy.c words.c file_utils.c -lfl -lcrypto -o lexer 
	sudo cp lexer /usr/bin
	cd 2003 && find . -type f |xargs -i -P0 lexer "{}" 

openssl:
	git clone https://github.com/openssl/openssl.git
	cd openssl && ./Configure && make && sudo make install && sudo cp libcrypto.so.3 /usr/lib/ && sudo cp libssl.so.3 /usr/lib/

koreio:
	wget https://kore.io/releases/kore-4.1.0.tar.gz
	sha256sum -c kore-4.1.0.tar.gz.sha256
	tar -xf kore-4.1.0.tar.gz
	sed -i 's/CFLAGS+=-Wall -Werror/CFLAGS+=-DOPENSSL_API_COMPAT=0x10100000L -Wall /g' kore-4.1.0/kodev/Makefile 
	sed -i 's/CFLAGS+=-Wall -Werror/CFLAGS+=-DOPENSSL_API_COMPAT=0x10100000L -Wall /g' kore-4.1.0/Makefile 
	cd kore-4.1.0 && make && sudo make install


clean:
	$(RM) lexer lex.yy.c
	$(RM) *.o EVP_MD
