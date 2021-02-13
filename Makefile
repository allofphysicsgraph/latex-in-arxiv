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


parser:
	flex arxiv.l
	gcc lex.yy.c -lfl

parse_file:
	a.out FILENAME

clean:
	rm a.out lex.yy.c