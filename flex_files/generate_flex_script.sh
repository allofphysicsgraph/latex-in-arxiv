lexer_file_name="$(echo "$1"|tr -d '{}'|sed -r 's/^begin//g')".l
state="$(echo $1|tr [a-z] [A-Z]|sed -r 's/^BEGIN//g'|tr -d '{}' )"
cat header_template > $lexer_file_name
cat lexer_template |sed "s/CITE/$state/g" |sed "s/cite/$1/g" >> $lexer_file_name
cat main_template >> $lexer_file_name

