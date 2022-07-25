find ../ -type f -exec sha256sum "{}" \; > /dev/shm/chksm_files ;

#removing duplicates in training data
#./a.out hello |grep -P "\t" -C 2|grep train -C 2|grep -P '\t'|sed -r 's/^\s+//g'|sed -r 's/^\.\///g'|xargs -i rm ../"{}"

