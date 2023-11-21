install_ragel:
	/bin/bash install_ragel.sh

#strings:
	#ragel -V -Z -p -o strings.dot strings.rl
#	ragel   -m -G2 strings.rl
#	gcc  -g strings.c -o strings.out -lm
#	./strings.out sound1.tex

scanner:
	ragel -m -G2 scanner.rl
	ragel -m -G2 reader.rl
	gcc  -g scanner.c reader.c walk_dir.c main.c  -o scanner.out -lm
	#./scanner.out ../sound1.tex > output

sampledata:
	wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz --no-check-certificate
	tar -xf hep-th-2003.tar.gz
	mkdir 2003_errors
	$(CC) strip_non_ascii.c -o strip_non_ascii.out
	bash pre-process-dataset.sh
	#time find 2003 -type f -name "*.tex" |xargs -i -P12 latexml_tex2xml2html.sh "{}" 

