mytag=latexinarxiv
CC=gcc
CFLAGS = -Iopenssl/include -g
LDFLAGS = -Lopenssl/
LDLIBS = -lcrypto
INSTALL="apt install -y"


help:
	@echo "== outside the container =="
	@echo "make docker"
	@echo "         for linux"
	@echo "  "
	@echo "make docmac"
	@echo "         for Mac"
	@echo "== inside the container =="
	@echo "make openssl"
	@echo "make curl"
	@echo "make Kore"
	@echo "make sampledata"


test:
	cd config_files && bash db_init.sh
	cd src && make

# Docker on linux
docker:
	service docker start
	docker build -t $(mytag) .
	docker run -it  --rm $(mytag) /bin/bash

# Docker on Mac
docmac: dockermac_build dockermac_run
dockermac_build:
	docker build -t $(mytag) .

dockermac_run:
	docker run -it --rm -v `pwd`:/scratch $(mytag) /bin/bash


sampledata:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz
	mkdir 2003_errors
	$(CC) utils/strip_non_ascii.c -o strip_non_ascii.out
	bash utils/pre-process-dataset.sh
	#time find 2003 -type f -name "*.tex" |xargs -i -P12 latexml_tex2xml2html.sh "{}" 

curl:
	# Dependency for Kore, I prefer to build from source as a learning tool.
	sudo apt install -y  cmake 
	git clone https://github.com/curl/curl
	cd curl && mkdir build && cd build && cmake .. && make && sudo make install && sudo ldconfig

openssl:
	# Version change to 1.1.1 for kore
	wget https://www.openssl.org/source/openssl-1.1.1p.tar.gz
	tar -xf openssl-1.1.1p.tar.gz
	cd openssl-1.1.1p && ./config && make && sudo make install && sudo ldconfig

newcommand:
	$(CC) -Wall -Wunused -o newcommand utils/newcommand.c
	/bin/bash utils/run_new_command.sh


test_vocab:
	python test.py |tr ',' '\n'|sed -r 's/^\s+//g'|grep -v '\\' |tr -d "'" |awk 'length($1)>3' |grep -v '=' |grep -v '[0-9]'|grep -v '^\-'
	

	
hiredis:
	sudo apt install -y redis-server
	git clone https://github.com/redis/hiredis
	cd hiredis && make && sudo make install && sudo make install

RedisGraph:
	#docker run -p 6379:6379 -it --rm redislabs/redisgraph
	git clone --recurse-submodules -j8 https://github.com/RedisGraph/RedisGraph.git
	cd RedisGraph && make && sudo make install


katex:
	wget https://github.com/katex/katex/releases/download/v0.16.2/katex.tar.gz

