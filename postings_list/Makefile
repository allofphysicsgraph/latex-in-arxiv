CC=gcc


scanner:
	ragel -m -G2 scanner.rl
	ragel -m -G2 reader.rl
	gcc  -g scanner.c reader.c walk_dir.c main.c  -o scanner.out -lm
	#./scanner.out .. 
	#or
	#./scanner.out .. sound1.tex	

inline:
	ragel -m -G2 inline_counts.rl
	ragel -m -G2 reader.rl
	gcc  -g inline_counts.c reader.c walk_dir.c main.c  -o inline_counts.out -lm
	#./inline.out .. 
	#or
	#./inline.out .. sound1.tex	

get_sample_data:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz

remove_ascii:
	$(CC) strip_non_ascii.c -o strip_non_ascii.out
	/bin/bash pre-process-dataset.sh

files_with_errors:
	find . -type f -name "*.tex" -exec chktex "{}" \; | grep 'Warning 15'|grep tex|cut -d ' ' -f4|grep tex |sort|uniq > /tmp/files_with_errors
