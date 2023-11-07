#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <sys/param.h>
#
#define MAX_LEN 1024
#define MAX_WORD_SIZE 1024


char temp[MAX_WORD_SIZE];
char *buff;
char filename[256];

struct stat s;

int i;

int line_no = 1;
int col_number = 1;
int char_offset = 0;

extern void *malloc();

int scan(const char *in);
%%{
	machine strings;
	main := |*
  any ;
	*|;
}%%



%% write data;

int scan(const char *in) {
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  %% write init;
  %% write exec;

  if (cs == strings_error)
    printf("Error near %zd\n", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);

  return EXIT_SUCCESS;
}


int main(int argc, char **argv) {
  if (argc != 4) {
    printf("input filename offset context\n");
    return -1;
  }

strncpy(filename, argv[1],256);
  char buffer[s.st_size];
  int cs, res = 0;

  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    //scan((char *)buff);
    char temp[MAX_LEN];
    memset(temp,'\0',MAX_LEN);
    int lower,upper,x;
    lower = MAX((atoi(argv[2])-atoi(argv[3])),0);
    upper = MIN(atoi(argv[3])*3,s.st_size-atoi(argv[2]));

    printf("%d %d\n",lower,upper);
    strncpy(temp,&buff[lower],upper);
    printf("%s",temp);
    munmap(buff, s.st_size);
  }
  close(fd);
  return 0;
}
