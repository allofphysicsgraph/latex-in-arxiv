duplicates:
	gcc find_duplicate_files.c -o find_duplicate_files.out -lssl -lcrypto
	sudo cp find_duplicate_files.out /usr/bin/

variable_definitions:
	flex variable_definitions.l
	gcc -lfl lex.yy.c -o variable_definitions.out
	./variable_definitions.out /home/user/latex-in-arxiv/src/common/sound1.tex |grep '<:.*?:>' -oP |sed -r 's/^<:,?\s?/</g'| sed -r 's/\s*,?:>/>/g'
