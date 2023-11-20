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
#include <regex.h>
#include "globals.h"
int i;

#define MAX_FILE_COUNT 100000

enum {
  LOOKUP = 0, /* default - looking rather than defining. */
  WALK_OK = 0,
  WALK_BADPATTERN,
  WALK_NAMETOOLONG,
  WALK_BADIO,
};

#define WS_NONE 0
#define WS_RECURSIVE (1 << 0)
#define WS_DEFAULT WS_RECURSIVE
#define WS_FOLLOWLINK (1 << 1) /* follow symlinks */
#define WS_DOTFILES (1 << 2)   /* per unix convention, .file is hidden */
#define WS_MATCHDIRS (1 << 3)  /* if pattern is used on dir names too */


int main(int argc, char **argv) {
    int cs, res = 0;
    int fd;
    struct stat s;
    fd = open(argv[1], O_RDONLY);
    if (fd < 0)
      return EXIT_FAILURE;
    fstat(fd, &s);
    /* PROT_READ disallows writing to buff: will segv */
    char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (buff != (void *)-1) {
      Token vocab;
      vocab.index = 0 ;
      scan((char *)buff,&vocab);
      
      /*for(int i = 0;i<10;i++){
      	printf("%zd",vocab.index);
      }*/

      munmap(buff, s.st_size);
    }
    close(fd);
  return 0;
}

