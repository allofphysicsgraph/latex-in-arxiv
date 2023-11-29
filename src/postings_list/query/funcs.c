#include "globals.h"
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
#include <sys/param.h>

void print_context(char *filename, int offset, int match_len, int lhs_context,
                   int rhs_context) {
  // printf("opening filename %s:",filename);
  int fd;
  struct stat s;

  fd = open(filename, O_RDONLY);
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    int lhs = MAX(offset-lhs_context,0);
    int rhs = MIN(offset+match_len+rhs_context,s.st_size);
    int window_size = (rhs-lhs)+1;
    char temp[window_size];
    memset(temp, '\0', window_size);
    printf("<<%d:%d:%d>>\n",lhs,rhs,window_size);
    strncpy(temp, &buff[lhs], window_size-1);
    printf("\n%s\n\n", temp);
    munmap(buff, s.st_size);
  }
  close(fd);
}
