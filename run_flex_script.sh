find 2003 -type f -name "*.tex" -exec ./"$1" "{}" \; > 2003_"$(echo $1|cut -d '.' -f1)"
