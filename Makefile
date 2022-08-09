
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
	gcc strip_non_ascii.c -o strip_non_ascii.out
	bash pre-process-dataset.sh

md5:
	gcc EVP_MD.c -Iopenssl/include/ -Lopenssl/ -lcrypto


curl:
	git clone https://github.com/curl/curl
	cd curl && mkdir build && cd build && cmake .. && make && make install

#version change to 1.1.1 for koreio
openssl:
	wget https://www.openssl.org/source/openssl-1.1.1p.tar.gz
	tar -xf openssl-1.1.1p.tar.gz
	cd openssl-1.1.1p && ./config && make && sudo make install && sudo ldconfig

# Kore is an easy to use web platform for writing scalable, concurrent APIs in C or Python.
koreio:
	wget https://kore.io/releases/kore-4.2.2.tar.gz --no-check-certificate
	tar -xf kore-4.2.2.tar.gz
	cd kore-4.2.2 && make TLS_BACKEND=none PYTHON=1 DEBUG=1 CURL=1 TASKS=1  &&  sudo make install


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
	# xargs -i either doesn't work on dragonfly bsd or does not have the same meaning
	# adjust for the number of cores that you want to allocate.
	find 2003 -type f |xargs -i -P6  python new_lexer.py "{}"

postgres_build:
	sudo apt install libreadline-dev
	git clone https://github.com/postgres/postgres
	cd postgres && ./configure && make && sudo make install


postgres_db_setup:
	#REPLACE PASSWORD
	#database test for latex-in-arxiv
	sudo -u postgres -H -- psql -c "create user latexinarxiv with password '3e9f91486fa99d2fe94b2494baf5f2effe0791b6b040394cef4fbe1cefcada29'" 
	sudo -u postgres -H -- psql -c 'create database latexinarxiv with owner latexinarxiv;' 
	sudo -u postgres -H -- psql -d latexinarxiv -f db_init.sql 
	
postgrest:
	# REST Api for postgres
	wget https://github.com/PostgREST/postgrest/releases/download/v9.0.1/postgrest-v9.0.1-linux-static-x64.tar.xz
	tar -xf postgrest-v9.0.1-linux-static-x64.tar.xz
	sudo rsync -axr postgrest /usr/local/bin/
	sudo rsync -axr config_files/api.conf /usr/local/bin/
	cd /usr/local/bin/ && ./postgrest api.conf & 




clean:
	find . -maxdepth 1 -name "2003_*.csv" -exec rm "{}" \; 
	find . -type f -name "*.out" -exec rm "{}" \; 
	$(RM) *.o EVP_MD
	$(RM) *.out
