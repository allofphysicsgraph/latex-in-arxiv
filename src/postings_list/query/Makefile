#CC=clang
#CFLAGS=-g -fsanitize=undefined -fno-sanitize-recover=all

CC=gcc
CFLAGS=-g 
scanner:
	#cp ../../common/sound1.tex .
	ragel -I../../common -m -G2 scanner.rl
	ragel -I../../common -m -G2 reader.rl
	$(CC)  $(CFLAGS)  -O2 -I../../common/ scanner.c  example.c reader.c  main.c  ../../common/xxhash.c funcs.c ../../common/canonicalFromStr.c -o scanner.out -lm
	#./scanner.out . 
	#/scanner.out . offsets
clean :
	rm tf_idf
	rm offsets

read_tf_idf:
	ragel read_tf_idf.rl -m -G2
	gcc  read_tf_idf.c -o read_tf_idf.out

get_sample_data:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz
	cd 2003 && find . -type f |grep -v tex$ |xargs -i mv "{}" "{}".tex 

remove_ascii:
	$(CC) strip_non_ascii.c -o strip_non_ascii.out
	/bin/bash pre-process-dataset.sh

files_with_errors:
	find . -type f -name "*.tex" -exec chktex "{}" \; | grep 'Warning 15'|grep tex|cut -d ' ' -f4|grep tex |sort|uniq > /tmp/files_with_errors

hugegraph_filenames:
	find 2003 -type f |xargs -i bash ../../../schema/create_document_verticies.sh "{}" 

hugegraph_tokens:
	cat offsets |grep -v './'|awk '{print($1,$3)}'|xargs -l -P10  bash hugegraph_tokens.sh $1 $2

