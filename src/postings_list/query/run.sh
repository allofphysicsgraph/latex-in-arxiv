rm offsets
rm tf_idf
make scanner
make read_tf_idf
rm -rf sound1.tex
./scanner.out . 
./scanner.out . offsets
./read_tf_idf.out tf_idf
