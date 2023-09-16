/*
 * @LANG: c
 */
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
#include <unistd.h>
#include "bloom.h"

#define MAX_LEN 1024
#define MAX_WORD_SIZE 128
#
char temp[MAX_WORD_SIZE];
char *buff;
struct bloom bloom; 

int i;




int scan(const char *in);
%%{
	machine part_token;
	main := |*
  [a-zA-Z]{1,127} => { 
  memset(temp,'\0',MAX_WORD_SIZE);
  strncpy(temp,&buff[ts-in],te-ts);
  //printf("%s,",temp);
  if (bloom_check(&bloom, temp, te-ts)) {
  printf("%s,",temp);
  printf("%zd,%zd\n",ts-in,te-ts);};
  };
  

  any => {};
	*|;
}%%

%% write data;

int scan(const char *in)
{
	int cs = 0, act = 0;
	const char *p = in;
	const char *pe = in + strlen(in);
	const char *ts = NULL, *te = NULL;
	const char *eof = pe;

	%% write init;
	%% write exec;

	if (cs == part_token_error)
		printf("Error near %zd\n", p-in);
	else if(ts)
		printf("offsets: ts %zd te: %zd pe: %zd\n", ts-in, te-in, pe-in);

	return EXIT_SUCCESS;
}


int main(int argc, char **argv) {
i = -1;
assert(bloom_init(&bloom, 1000000, 0.000000001)==0); 

  FILE	*fp;										/* input-file pointer */
  char	*fp_file_name = "english.vocab";		/* input-file name    */

  char  buffer[2056];

  fp	= fopen( fp_file_name, "r" );
  if ( fp == NULL ) {
	  fprintf ( stderr, "couldn't open file '%s'; %s\n",
			  fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }
 
  while (fgets(buffer, MAX_LEN - 1, fp))
    {
        // Remove trailing newline
        buffer[strcspn(buffer, "\n")] = 0;
	//printf("%s",buffer);
	bloom_add(&bloom, buffer, strlen(buffer));
       	//vocabulary_add_word(buffer);
    }

  if( fclose(fp) == EOF ) {			/* close input file   */
	  fprintf ( stderr, "couldn't close file '%s'; %s\n",
			  fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }



int cs, res = 0;
  struct stat s;

  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    	scan((char*)buff);
	munmap(buff, s.st_size);
  }
  close(fd);
  bloom_free(&bloom);
  return 0;
}
