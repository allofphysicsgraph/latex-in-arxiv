all:
	ragel json_resp_2_struct.rl
	gcc -g json_resp_2_struct.c main.c -lcurl
	#valgrind -s ./a.out 
	./a.out 
