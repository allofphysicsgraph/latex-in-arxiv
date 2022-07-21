while read f;
do flex -Cf "$f".l;
	gcc -lfl lex.yy.c -o "$f".out
done < <(find . -maxdepth 1 -type f -name "*.l"|cut -d '/' -f2 |cut -d '.' -f1)
