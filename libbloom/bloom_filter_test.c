
#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include "bloom.h"

#include <sys/time.h>
#include <time.h>
#define MAX_LEN 1024

int main(int argc, char **argv)
{
  struct bloom bloom; 
  int i = -1;
  assert(bloom_init(&bloom, 100000, 0.000000001)==0); 

  FILE	*fp;										/* input-file pointer */
  char	*fp_file_name = "english_vocab";		/* input-file name    */

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


if (bloom_check(&bloom, argv[1], strlen(argv[1]))) {
  printf("It may be there!\n");
}


  bloom_free(&bloom);
  return 0;
}
