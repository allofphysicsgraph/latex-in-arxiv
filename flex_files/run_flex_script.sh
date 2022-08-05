find "." -type f -name "*.tex" -exec ./"$1" "{}" \; > "$(echo $1|cut -d '.' -f1)".csv
