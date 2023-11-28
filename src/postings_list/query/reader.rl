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
#define MAX_WORD_SIZE 10240
#
int counter;
char temp[MAX_WORD_SIZE];
char *buff, *buff1;

char filename[256];

struct stat s, s1;
int offset;
int match_len;

//filename hash offset and length 

int scan(const char *in);
%%{
	machine strings;
	main := |*
"./"(any-'\n'){4,80}'\n' =>{
  char temp[te-ts];
  memset(temp,'\0',te-ts);
  strncpy(temp,&buff[ts-in],te-ts-1);
  printf("<filename:%s>\n",temp);
};

[a-f0-9]{16} => { 
  char temp[te-ts];
  memset(temp,'\0',te-ts);
  strncpy(temp,&buff[ts-in],te-ts-1);
  printf("<hash:%s>",temp);
  };

  [ ][0-9]+  => { 
  char temp[te-ts];
  memset(temp,'\0',te-ts);
  strncpy(temp,&buff[(ts+1)-in],te-(ts+1));
  offset = atoi(temp);
  printf("<offset:%d>",offset);
};

  [ ]{2}[0-9]+'\n' => {
  char temp[te-ts];
  memset(temp,'\0',te-ts);
  strncpy(temp,&buff[(ts+2)-in],te-(ts+2));
  temp[(te-1)-(ts+2)]='\0';
  printf("<len:%s>\n",temp);
  };
	any;
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


int reader(const char *source) {
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
   scan((char *)buff);
   munmap(buff, s.st_size);
   }
  close(fd);
  //printf("\n\tcounts:%d\n",counter);
return 0;
}
