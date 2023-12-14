#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

int scan(const char *in);
char column_name[10];
char str_int[10];
char bin_op[10];
%%{
  machine filters;

  integer = [0 - 9][0 - 9] *;
  gt = '>';
  lt = '<';
  eq = '=';
  ws = [ \t] + ;
  new_line = '\n';

  bin_op = gt | lt | eq;
  columns = "count" | "docs" | "tf_idf";

main:
  = | *

    columns = > {
    memset(column_name, '\0', 10);
    strncpy(column_name, &in[ts - in], te - ts);
    printf("%s\n", column_name);
  };

  bin_op = > {
    memset(bin_op, '\0', 10);
    strncpy(bin_op, &in[ts - in], te - ts);
    printf("bin_op:%s", bin_op);
  };

  integer = > {
    memset(str_int, '\0', 10);
    strncpy(str_int, &in[ts - in], te - ts);
    printf("\n<<<%d>>>\n", atoi(str_int) + 10);
  };

  new_line;
  any = > { printf("<%c>\n", fc); };
  * | ;
}%% 

    % % write data;

int scan(const char *in) {
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  % % write init;
  % % write exec;

  if (cs == filters_error)
    printf("Error near %zd\n", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);

  return EXIT_SUCCESS;
}

int main(int argc, char **argv) {
  struct stat s;
  int cs, res = 0;
  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  char *buff;
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    scan((char *)buff);
    munmap(buff, s.st_size);
  }
  close(fd);
  return 0;
}
