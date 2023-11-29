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
int match;
int lhs_context = 5;
int rhs_context = 5;

typedef struct output {
  char filename[256];
  XXH64_hash_t hash;
  int offset;
  int length;
}OUTPUT;

//filename hash offset and length 

int scan(const char *in);
%%{
	machine strings;
	main := |*
"./"(any-'\n')+'\n' =>{
  memset(test_data.filename,'\0',256);
  strncpy(test_data.filename,&buff[ts-in],te-ts-1);
};

[a-f0-9]{16} =>{
  char temp[te-ts+1];
  memset(temp,'\0',te-ts+1);
  strncpy(temp,&buff[ts-in],te-ts);
  if(!cmp_Canonical_XXH64(temp ,XXH64("derivation", 10, 0) )){
    match=1 ; 

} 
};


[ ][0-9]+[ ]{2}=>{
  if(match){
  char temp[te-ts+1];
  memset(temp,'\0',te-ts+1);
  strncpy(temp,&buff[(ts+1)-in],te-ts-3);
  test_data.offset=atoi(temp);
}};

[0-9]+'\n'=>{
if(match){
  char temp[te-ts+1];
  memset(temp,'\0',te-ts+1);
  strncpy(temp,&buff[ts-in],te-ts-1);
  atoi(temp);
  printf("%d",test_data.offset);
 print_context(test_data.filename,test_data.offset,10, lhs_context,rhs_context);
  match=0;
}};

	any;
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
