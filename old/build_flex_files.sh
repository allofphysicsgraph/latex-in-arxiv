while read f;
do flex -Cf "$f".l;
	echo $f
	gcc -lfl lex.yy.c -o "$f".out
done < <(find . -maxdepth 1 -type f -name "*.l"|cut -d '/' -f2 |cut -d '.' -f1|grep -v bloom|grep -v menu)
