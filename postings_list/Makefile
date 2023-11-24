CC=gcc


scanner:
	ragel -m -G2 scanner.rl
	ragel -m -G2 reader.rl
	gcc  -g scanner.c reader.c walk_dir.c main.c  -o scanner.out -lm
	#./scanner.out ../sound1.tex > output

get_sample_data:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz

remove_ascii:
	$(CC) strip_non_ascii.c -o strip_non_ascii.out
	/bin/bash pre-process-dataset.sh

