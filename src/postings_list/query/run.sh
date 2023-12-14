rm offsets
rm tf_idf
make scanner
make tf_idf
./scanner.out . 
./scanner.out . offsets
./read_tf_idf.out tf_idf
