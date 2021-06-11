
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


lexer:
	flex arxiv.l
	cc -Iopenssl/include -g -c EVP_MD.c
	cc -Lopenssl/  EVP_MD.o  lex.yy.c words.c file_utils.c -lfl -lcrypto -o lexer 


openssl:
	git clone https://github.com/openssl/openssl.git
	cd openssl && ./Configure && make && sudo cp openssl/libcrypto.so.3 /usr/lib/ && cd utils/MD5 && make

koreio:
	wget https://kore.io/releases/kore-4.1.0.tar.gz
	sha256sum -c kore-4.1.0.tar.gz.sha256
	tar -xf kore-4.1.0.tar.gz
	cd kore-4.1.0

clean:
	rm a.out lex.yy.c
	$(RM) *.o EVP_MD
