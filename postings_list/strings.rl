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

#define MAX_LEN 1024
#define MAX_WORD_SIZE 1024

char temp[MAX_WORD_SIZE];
char *buff;
char filename[128];
struct stat s;

int i;

int line_no = 1;
int col_number = 1;
int char_offset = 0;

extern void *malloc();

int scan(const char *in);
%%{
	machine strings;
  include strings "vocab.rl";
	main := |*
  word => { 
    memset(temp, '\0', MAX_WORD_SIZE);
    strncpy(temp, &buff[ts - in], te - ts);
    printf("%s,%zd,%zd,%s\n", filename, ts - in, te - ts, temp);
  };
  
  any ;
	*|;
}%%


%%{
  machine strings;
  include "vocab.rl";
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
  if (argc != 2) {
    printf("input filename\n");
    return -1;
  }

strncpy(filename, argv[1],128);
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
    scan((char *)buff);
    munmap(buff, s.st_size);
  }
  close(fd);
  return 0;
}
