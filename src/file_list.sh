data_source='test/'
files=$(find $data_source -type f)
file_count=$(echo $files|tr ' ' '\n' |wc -l)
files_per_session=50
number_of_workers=10
for i in `seq 0 $files_per_session $file_count`;
do 
	echo $files |tr ' ' '\n'| sed -n $i,$(($i+50))p|xargs -i redis-cli lpush "$i"_queue "{}" 
done
