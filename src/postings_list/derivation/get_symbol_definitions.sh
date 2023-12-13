cp ../../../utils/variable_definitions.l .
flex variable_definitions.l 
gcc -lfl lex.yy.c 
./a.out ../../common/sound1.tex |grep -oP "<:.*?:>" |sed -r 's/^<://g'|sed -r 's/:>$//g' |sed -r 's/^,\s*//g'
