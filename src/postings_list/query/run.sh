echo 'all tex files should be saved in 2003 folder'
mkdir 2003
#echo "input search pattern such as bibitem,title,ref,cite,equation "
#bash update_search_pattern.sh "$1"
mkdir 2003_errors
#time bash 0_pre-process.sh 
#time bash pre-process-dataset.sh  
ls 2003_errors |wc -l 
rm -rf 2003_errors
rm offsets
rm tf_idf
make scanner
make read_tf_idf
#rm -rf sound1.tex
./scanner.out . tex$
./read_tf_idf.out tf_idf
mv offsets "$1"_offsets
mv tf_idf "$1"_tf_idf
mv scanner.out "$1".out
