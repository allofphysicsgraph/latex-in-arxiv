state="$(echo $1|tr [a-z] [A-Z])"
cat author.l |sed "s/AUTHOR/$state/g" |sed "s/author/$1/g" > "$1".l
