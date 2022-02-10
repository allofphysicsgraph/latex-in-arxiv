#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <ctype.h>
#include <sys/stat.h>
#include <unistd.h>
#define BUF_SIZE 1000
int main(int argc, char **argv){

	int fd;
	char buf[BUF_SIZE];
	memset(buf,'\0',BUF_SIZE);
	int numRead,i;
	fd = open(argv[1],O_RDWR);
	lseek(fd,10,SEEK_SET);
	numRead = read(fd,buf,10);
	for(i=0;i<numRead;i++){
		printf("%c",isprint(buf[i]) ? buf[i] : '?');
	}

	printf("\n");
	lseek(fd,5,SEEK_SET);
	numRead = read(fd,buf,10);
	for(i=0;i<numRead;i++){
		printf("%c",isprint(buf[i]) ? buf[i] : '?');
	}
	
	return 0;
}
