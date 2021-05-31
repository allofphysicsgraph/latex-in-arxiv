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
	gcc lex.yy.c words.c file_utils.c -lfl

openssl:
	git clone https://github.com/openssl/openssl.git
	cd openssl && ./Configure && make

clean:
	rm a.out lex.yy.c
