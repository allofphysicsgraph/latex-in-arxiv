rm tf_idf
rm offsets
cite.out "$1" "$2"
#sed -ri 's/id:[a-f0-9]+: count:1 docs:1 tok://g' tf_idf
#sed -i 's/\\begin{abstract}//g' tf_idf
#sed -i 's/\\end{abstract}//g' tf_idf
#sed -ri 's/\(|\)//g' tf_idf
#sed -ri 's/sorting structs writing tf_idf scores to tf_idf//g' tf_idf
cat tf_idf
#|tr -d [:punct:] |tr -d '{}'|  sed 's/\x0a//g' |sed 's/\n//g'| sed  's/[\x00-\x1F\x7F]//g' 
