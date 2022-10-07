
mytag=latexinarxiv
CC=gcc
CFLAGS = -Iopenssl/include -g
LDFLAGS = -Lopenssl/
LDLIBS = -lcrypto
INSTALL="sudo apt install -y"


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


# Docker on linux
docker:
	sudo service docker start
	sudo docker build -t $(mytag) .
	sudo docker run -it --publish 8888:8888 --rm $(mytag)

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

Kore:
	# Kore is an easy to use web platform for writing scalable, concurrent APIs in C or Python.
	wget https://kore.io/releases/kore-4.2.3.tar.gz --no-check-certificate
	tar -xf kore-4.2.3.tar.gz
	cd kore-4.2.3 && make TLS_BACKEND=none PGSQL=1 PYTHON=1 DEBUG=1 CURL=1 TASKS=1  &&  sudo make install

install_libbloom:
	bash libbloom.sh

bloom:
	sudo apt install -y  ncurses-dev
	flex -Cf bloom_filter_test.l
	$(CC) -O3 -g -lfl lex.yy.c -Ilibbloom libbloom/bloom.c -Llibbloom/build/libbloom.so libbloom/murmur2/MurmurHash2.c  -lm -lncurses -o bloom_filter


newcommand:
	$(CC) -Wall -Wunused -o newcommand utils/newcommand.c
	/bin/bash utils/run_new_command.sh

parse_docs:
	# xargs -i either doesn't work on dragonfly bsd or does not have the same meaning
	# adjust for the number of cores that you want to allocate.
	# decompress if the file exists
	find . -maxdepth 1 -type f -name "Punkt_LaTeX_SENT_Tokenizer.pickle.xz" -exec xz -d "{}" \;
	#find 2003 -type f |xargs -i -P6  python new_lexer.py "{}"

postgres:
	sudo apt install -y  libreadline-dev
	sudo apt install -y  postgresql-server-dev-all
	sudo apt install -y  postgresql

postgres_db_setup:
	#REPLACE PASSWORD
	#database test for latex-in-arxiv
	sudo -u postgres -H -- psql -c "create user latexinarxiv with password '3e9f91486fa99d2fe94b2494baf5f2effe0791b6b040394cef4fbe1cefcada29'" 
	sudo -u postgres -H -- psql -c 'create database latexinarxiv with owner latexinarxiv;' 
	sudo -u postgres -H -- psql -d latexinarxiv -f db_init.sql 
	sudo sed -i 's/5433/5432/g' /etc/postgresql/14/main/postgresql.conf	
	sudo service postgresql restart


postgrest:
	# REST Api for postgres
	wget https://github.com/PostgREST/postgrest/releases/download/v9.0.1/postgrest-v9.0.1-linux-static-x64.tar.xz
	tar -xf postgrest-v9.0.1-linux-static-x64.tar.xz
	sudo rsync -axr postgrest /usr/local/bin/
	sudo rsync -axr config_files/api.conf /usr/local/bin/
	cd /usr/local/bin/ && ./postgrest api.conf & 

test_vocab:
	python test.py |tr ',' '\n'|sed -r 's/^\s+//g'|grep -v '\\' |tr -d "'" |awk 'length($1)>3' |grep -v '=' |grep -v '[0-9]'|grep -v '^\-'
	

webapp:
	cd websocket/assets && wget https://github.com/twbs/bootstrap/releases/download/v5.2.1/bootstrap-5.2.1-dist.zip && unzip bootstrap-5.2.1-dist.zip && cd ../../ &&  cp websocket/assets/bootstrap-5.2.1-dist/js/bootstrap.bundle.min.js websocket/assets/js && cp websocket/assets/bootstrap-5.2.1-dist/css/bootstrap.min.css websocket/assets/css/   
	cd websocket/assets && tar -xf HTML.tar.xz && rm HTML.tar.xz && rm -rf bootstrap-5.2.1-dist  && cd .. && make
	
hiredis:
	git clone https://github.com/redis/hidredis
	cd hiredis && make && sudo make install && sudo make install

RedisGraph:
	#docker run -p 6379:6379 -it --rm redislabs/redisgraph
	git clone --recurse-submodules -j8 https://github.com/RedisGraph/RedisGraph.git
	cd RedisGraph && make && sudo make install

clean:
	find . -maxdepth 1 -name "2003_*.csv" -exec rm "{}" \; 
	find . -type f -name "*.out" -exec rm "{}" \; 
	$(RM) *.o EVP_MD
	$(RM) *.out

katex:
	wget https://github.com/katex/katex/releases/download/v0.16.2/katex.tar.gz
