output=$(./a.out <"$1" > "$1"_newcmd)
line_count=$(diff $1 $1_newcmd|wc -l )
if [[ $line_count -eq 0 ]];
then 
	rm $1_newcmd
fi
