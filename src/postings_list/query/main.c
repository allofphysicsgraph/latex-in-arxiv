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
  char *Documents[MAX_DOCUMENT_COUNT];
  int i = 0;
  int doc_index = 0;
  memset(Documents, 0, sizeof(Documents));
  int r;

  switch (argc) {
  case 2:
    r = walk_dir(argv[1], "tex$", WS_DEFAULT | WS_MATCHDIRS, Documents,
                 doc_index);
    break;

  case 3:
    r = walk_dir(argv[1], argv[2], WS_DEFAULT | WS_MATCHDIRS, Documents,
                 doc_index);
    break;

  default:
    printf("options:1 or 2 arguments.\n1.\tdirectory of tex ./scanner.out ../ "
           "files.\n2.\tdirectory + filename. ./scanner .. offsets_file\n");
    return -1;
    break;
  } /* -----  end switch  ----- */
  switch (r) {
  case WALK_OK:
    break;
  case WALK_BADIO:
    printf("IO error");
    break;
  case WALK_BADPATTERN:
    printf("Bad pattern");
    break;
  case WALK_NAMETOOLONG:
    printf("Filename too long");
    break;
  default:
    printf("Unknown error?");
  }
  i = 0;
  while (Documents[i] != NULL) {
    printf("%s\n", Documents[i]);
    /*   int res = 0; */
    int fd;
    struct stat s;
    fd = open(Documents[i], O_RDONLY);
    if (fd < 0) {
      printf("EXIT FAILURE");
      return EXIT_FAILURE;
    }
    fstat(fd, &s);
    /* PROT_READ disallows writing to buff: will segv */
    char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (buff != (void *)-1) {
      switch (argc) {
      case 2:
        scanner((char *)buff, Documents[i]);
        break;

      case 3:
        reader(Documents[i]);
        break;

      default:
        break;
      } /* -----  end switch  ----- */
      munmap(buff, s.st_size);
    }
    close(fd);
    free(Documents[i]);
    i++;
  }
  update_tf_idf(i); /* i is total_doc_count */
                    /*
                      int running = 0;
                      while (running) {
                        printf(" 1. print_tokens\n");
                        printf(" 2. print tf_idf\n");
                        printf(" 3. sort by tf_idf if 0 then by counts\n");
                        printf(" 4. quit\n");
                        switch (atoi(getl("Command"))) {
                        case 1:
                          print_tokens();
                          break;
                        case 2:
                          print_tf_idf();
                          break;
                        case 3:
                          srt();
                          break;
                        case 4:
                          running = 0;
                          delete_all();
                          return 0;
                          break;
                        }
                      }
                    */

  printf("sorting structs\n");
  srt();
  /* print_tokens(); */
  /* print_tf_idf(); */
  printf("writing tf_idf scores to tf_idf\n");
  write_tf_idf();
  delete_all();
  return 0;
}
