find HEP -type f -name "*.tex" -exec ./"$1" "{}" \; > HEP_"$(echo $1|cut -d '.' -f1)".csv
