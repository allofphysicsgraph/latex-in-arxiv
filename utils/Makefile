all:
	ragel json_resp_2_struct.rl
	gcc -g json_resp_2_struct.c main.c
	valgrind -s ./a.out 
