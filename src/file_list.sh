data_source='test/'
files=($(find $data_source -type f))
file_count=${#files[@]}
files_per_session=50
number_of_workers=15
starting_port_number=18861

#in order create_jobs, start_servers, start_clients 
#you should see a list of 30 entries in screen -ls 15 servers, 15 clients
#TODO start a new client when on job finished
#     log status of success, fail, and if fail where
#     validate the number of matches with grep, python and ragel


create_jobs(){
for i in `seq 0 $files_per_session $file_count`;
do 
	echo ${files[@]} |tr ' ' '\n'| sed -n $i,$(($i+50))p|xargs -i redis-cli lpush "$i"_queue "{}" 
done
}

start_servers() {
for i in `seq $starting_port_number $(($starting_port_number+$number_of_workers-1))`;
do 
	screen -d -m -S "$i"_server python server.py $i
done
}

start_clients() {
	server_list=($(screen -ls|grep _server|grep 188|cut -d '.' -f2|cut -d '_' -f1))
	server_count=${#server_list[@]}
	job_list=($(echo 'keys *' |redis-cli |grep queue|shuf))
	echo $server_count
	echo "${server_list[@]}"
	for i in `seq 0 $((${#server_list[@]}-1))`
do 
	
	echo screen -d -m -S "${server_list[$i]}"_client python client.py ${job_list[$i]} ${server_list[$i]}
	screen -d -m -S "${server_list[$i]}"_client python client.py ${job_list[$i]} ${server_list[$i]}
	#echo ${job_list[$i]} | xargs -i redis-cli del "{}"
done
}
