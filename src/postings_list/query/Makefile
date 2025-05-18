#CC=clang
#CFLAGS=-g -fsanitize=undefined -fno-sanitize-recover=all

CC=gcc
CFLAGS=-g 
scanner:
	ragel -m -G2 scanner.rl
	$(CC)  -O2  scanner.c main.c murmur3.c -I../../include -o scanner.out -lm

rewrite_rules:
	ragel -m -G2 rewrite_rules.rl
	$(CC)  -O2  rewrite_rules.c main.c  -o rewrite_rules.out -lm
clean :
	rm tf_idf
	rm offsets

get_sample_data:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz
	cd 2003 && find . -type f |grep -v tex$ |xargs -i mv "{}" "{}".tex 

remove_ascii:
	$(CC) strip_non_ascii.c -o strip_non_ascii.out
	/bin/bash pre-process-dataset.sh

files_with_errors:
	find . -type f -name "*.tex" -exec chktex "{}" \; | grep 'Warning 15'|grep tex|cut -d ' ' -f4|grep tex |sort|uniq > /tmp/files_with_errors

