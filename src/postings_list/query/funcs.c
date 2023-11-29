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

void print_context(char *filename, int offset, int lhs_context,
                   int rhs_context) {
  // printf("opening filename %s:",filename);
  int fd;
  struct stat s;

  fd = open(filename, O_RDONLY);
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    int buffer_len = lhs_context + rhs_context + 1;
    char temp[buffer_len];
    memset(temp, '\0', buffer_len);
    strncpy(temp, &buff[offset - lhs_context], buffer_len);
    printf("%s\n\n", temp);
    for (int i = 0; i < 50; i++) {
      printf("%c", '*');
    }
    munmap(buff, s.st_size);
  }
  close(fd);
}
