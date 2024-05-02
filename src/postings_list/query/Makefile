#CC=clang
#CFLAGS=-g -fsanitize=undefined -fno-sanitize-recover=all

CC=gcc
CFLAGS=-g 
scanner:
	cp ../../common/sound1.tex .
	ragel -I../../common -m -G2 scanner.rl
	ragel -I../../common -m -G2 reader.rl
	$(CC)  $(CFLAGS)  -O2 -I../../common/ scanner.c  example.c reader.c ../../common/walk_dir.c main.c  ../../common/xxhash.c funcs.c ../../common/canonicalFromStr.c -o scanner.out -lm
	#./scanner.out . 
	#/scanner.out . offsets

read_tf_idf:
	ragel read_tf_idf.rl -m -G2
	gcc  read_tf_idf.c -o read_tf_idf.out
	./read_tf_idf.out tf_idf

get_sample_data:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz

remove_ascii:
	$(CC) strip_non_ascii.c -o strip_non_ascii.out
	/bin/bash pre-process-dataset.sh

files_with_errors:
	find . -type f -name "*.tex" -exec chktex "{}" \; | grep 'Warning 15'|grep tex|cut -d ' ' -f4|grep tex |sort|uniq > /tmp/files_with_errors
