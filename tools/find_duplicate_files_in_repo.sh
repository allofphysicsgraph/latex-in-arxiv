find ../ -type f -exec sha256sum "{}" \; > /dev/shm/chksm_files ;
gcc read_file_into_struct.c -o read_file_into_struct.out
./read_file_into_struct.out /dev/shm/chksm_files 
