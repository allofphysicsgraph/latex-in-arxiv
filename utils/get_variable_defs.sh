#flex  variable_definitions.l
#gcc -lfl lex.yy.c -o variable_definitions.out
./variable_definitions.out "$1" |grep '<:.*?:>' -oP |sed -r 's/^<:,?\s?/</g'| sed -r 's/\s*,?:>/>/g'|sed -r "s/>//g"|sed -r 's/and$//g'|sort|uniq|grep -v sed|grep -v gcc

