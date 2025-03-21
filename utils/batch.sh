#process the tex files in batches of 100k
#mkdir {1..20}
#for i in `seq 1 20` ; do find 2003 -type f |head -n 100000 |xargs -i -P30 rsync -axr "{}" $i/ --progress --remove-source-files ;done


#for i in `seq 1 20`;do bash run_scanner.sh equation.out $i;done
#sorting structs
#writing tf_idf scores to tf_idf


#for i in `seq 1 20`;do bash run_scanner.sh abstract.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh affiliation.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh align.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh author.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh bibitem.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh cite.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh equation.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh itemize.out  $i;done
##for i in `seq 1 20`;do bash run_scanner.sh ref.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh section.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh thebibliography.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh title.out  $i;done
#for i in `seq 1 20`;do bash run_scanner.sh usepackage.out  $i;done


#find tex_sentences/ -type f -name "*.tex.out" |xargs -i  -P20 sed -ri 's/CharacterOffsetBegin=|CharacterOffsetEnd=//g' "{}"
