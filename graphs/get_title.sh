rm tf_idf
rm offsets
title.out "$1" "$2"
sed -ri 's/id:[a-f0-9]+: count:1 docs:1 tok://g' tf_idf
sed -ri 's/\\/\\\\/g' tf_idf
cat tf_idf | tr -d '\n' >  tf_idf_0
mv tf_idf_0 tf_idf
sed -ri 's/sorting structs writing tf_idf scores to tf_idf//g' tf_idf
