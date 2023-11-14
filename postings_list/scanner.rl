#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
int i,n;

int scan(const char *in);
%%{
	machine strings;
  include strings "vocab.rl";
	main := |*
  word => { 
    printf("%zd %zd  ",ts - in, te - ts);
  };
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
  for (int i = 0; i < argc - 1; i++) {
    int cs, res = 0;
    int fd;
    struct stat s;
  fd = open(argv[i + 1], O_RDONLY);
    if (fd < 0)
      return EXIT_FAILURE;
    fstat(fd, &s);
    /* PROT_READ disallows writing to buff: will segv */
    char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (buff != (void *)-1) {
      scan((char *)buff);
      munmap(buff, s.st_size);
    }
    close(fd);
}}

