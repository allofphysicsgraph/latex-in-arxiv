state="$(echo $1|tr [a-z] [A-Z])"
cat cite.l |sed "s/CITE/$state/g" |sed "s/cite/$1/g" > "$1".l
