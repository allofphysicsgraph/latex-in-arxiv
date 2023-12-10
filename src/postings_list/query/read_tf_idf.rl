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

char *buff;

struct stat s, s1;
int offset;
int match_len;
int match;
int lhs_context = 25;
int rhs_context = 50;

typedef struct output {
  char filename[256];
  // XXH64_hash_t hash;
  int offset;
  int length;
} OUTPUT;

// filename hash offset and length

int scan(const char *in);
%%{
	machine strings;
	main:=|*
"id:" xdigit{16} => {
  char temp[te-ts+1];
  memset(temp, '\0', te-ts+1);
  strncpy(temp, &in[ts-in+3], te-ts-3);
  printf("<%s>", temp);
};

":"[ ]+"count:" digit{1,10} =>{
	char temp[te - ts + 1];
	memset(temp, '\0', te-ts);
	strncpy(temp, &in[ts-in+2+6], te-ts-2-6);
	printf("<%s>", temp);
};

[ ]+"docs:" digit{1,6} =>{
	char temp[te-ts+1];
	memset(temp, '\0', te - ts + 1);
	strncpy(temp, &in[ts - in+1+5], te - ts-1-5);
	printf("<%s>", temp);
};

[ ]+"tf_idf:" digit{1}"."digit{6} =>{
	char temp[te-ts+1];
	memset(temp, '\0', te-ts+1);
	strncpy(temp, &in[ts-in+1+7], te-ts-1-7);
	printf("<%s>", temp);
};

any => {
printf("%c", fc);
};
	*|;
}%%



%% write data;

int scan(const char *in) {
OUTPUT test_data;
int cs = 0, act = 0;
const char *p = in;
const char *pe = in + strlen(in);
const char *ts = NULL, *te = NULL;
const char *eof = pe;

  %% write init;
  %% write exec;

if (cs == strings_error)
  printf("Error near %zd\n", p - in);
else if(ts)
  printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);
return EXIT_SUCCESS;
}


int main(int argc, const char **argv) {
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
