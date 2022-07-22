state="$(echo $1|tr [a-z] [A-Z]|sed -r 's/^BEGIN//g'|tr -d '{}' )"
cat cite.l |sed "s/CITE/$state/g" |sed "s/cite/$1/g" > "$(echo "$1"|tr -d '{}'|sed -r 's/^begin//g')".l
