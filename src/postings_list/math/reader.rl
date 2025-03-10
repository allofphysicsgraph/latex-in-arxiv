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
#include "globals.h"
#
#define MAX_LEN 1024
#define MAX_WORD_SIZE 1024

int counter;
char temp[MAX_WORD_SIZE];
char *buff, *buff1;

char filename[256];

struct stat s, s1;
int offset;
int match_len;

int scan(const char *in);
%%{
	machine strings;
	main := |*
  [0-9]+[ ]  => { 
  char temp[te-ts];
  memset(temp,'\0',te-ts);
  strncpy(temp,&buff[ts-in],te-ts-1);
  offset = atoi(temp);
};

  [0-9]+[ ]{2} => {

  char temp[te-ts];
  memset(temp,'\0',te-ts);
  strncpy(temp,&buff[ts-in],te-ts-2);
  match_len = atoi(temp);
  char output[match_len+10];
  memset(output,'\0',match_len+10);
  strncpy(output,&buff1[offset],match_len);
  //printf("<< %d %d>>\n",offset,match_len);
   printf("%s▁ ",output);
  };
	any => {printf("%c\n", fc);};
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


int reader(const char *source, Token * offsets) {
	strncpy(filename, source,256);
  int cs, res = 0;
  int fd;
  fd = open(source, O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);

  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
  for(int i = 0;i<offsets->index;i++){
  //	printf("%zd %zd\n", offsets->offset[i],  offsets->length[i]);
		int length =(offsets->length[i])+1;
		char output[length];
		memset(output, '\0', length);
		strncpy(output,&buff[offsets->offset[i]], length-1);
       counter++;
       printf("%s\n",output);
	   printf("**********************************************\n");
    }
    munmap(buff, s.st_size);
}
  close(fd);
  printf("\n\tcounts:%d\n",counter);
return 0;
}
