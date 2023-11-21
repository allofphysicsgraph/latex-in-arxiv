#include "globals.h"
#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <math.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
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
  char *Documents[MAX_FILE_COUNT];
  int i = 0;
  int doc_index = 0;
  memset(Documents, 0, sizeof(Documents));
  int r = walk_dir(argv[1], "\\.tex$", WS_DEFAULT | WS_MATCHDIRS, Documents,
                   doc_index);
  switch (r) {
  case WALK_OK:
    break;
  case WALK_BADIO:
    printf("IO error");
  case WALK_BADPATTERN:
    printf("Bad pattern");
  case WALK_NAMETOOLONG:
    printf("Filename too long");
  default:
    printf("Unknown error?");
  }
  i = 0;
  while (Documents[i] != NULL) {
    printf("%s\n", Documents[i]);
    int cs, res = 0;
    int fd;
    struct stat s;
    fd = open(Documents[i], O_RDONLY);
    if (fd < 0)
      return EXIT_FAILURE;
    fstat(fd, &s);
    /* PROT_READ disallows writing to buff: will segv */
    char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (buff != (void *)-1) {
      Token vocab;
      vocab.index = 0;
      scanner((char *)buff, &vocab);
      reader(Documents[i], &vocab);
      munmap(buff, s.st_size);
    }
    close(fd);
    free(Documents[i]);
    i++;
  }

  return 0;
}

