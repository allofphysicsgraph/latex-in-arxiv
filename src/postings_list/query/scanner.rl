#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include "globals.h"
	//printf("index:%zd offset:%zd len:%zd\n",tok->index,ts-in,te-ts);
	//printf("index:%zd offset:%zd len:%zd\n",tok->index,ts-in,te-ts);

int n;
%%{
  
  machine strings;
  	include strings "vocab.rl";
  	include latex "latex.rl";
  
  main := |*

    word => {
		XXH64_canonical_t dst;
		char temp[te-ts+1];
		memset(temp,'\0',te-ts+1);
    int offset = ts-in;
    int length = te-ts;
		strncpy(temp,&in[offset],length);
		XXH64_hash_t test_hash = XXH64(temp,length, 0);
    add_token(test_hash,temp,length,offset);
		XXH64_canonicalFromHash(&dst, test_hash);
		for(size_t i=0;i<8;i++){
			fprintf(hash_test,"%02x", dst.digest[i]);
    }
		fprintf(hash_test," %zd  %zd\n",(ts-in),(te-ts));
	};

    latex => { 
		XXH64_canonical_t dst;
		char temp[te-ts+1];
		memset(temp,'\0',te-ts+1);
    int offset = ts-in;
    int length = te-ts;
		strncpy(temp,&in[offset],length);
		XXH64_hash_t test_hash = XXH64(temp,length, 0);
    if((te-ts)<1000){
      add_token(test_hash,temp,length,offset);
    }
    XXH64_canonicalFromHash(&dst, test_hash);
		for(size_t i=0;i<8;i++){
			fprintf(hash_test,"%02x", dst.digest[i]);
    }
		fprintf(hash_test," %zd  %zd\n",offset,length);
	};
    any ;
  	*|;
}%%


%% write data;
 int scanner(const char *in, char* filename) {
	FILE	*hash_test;										/* output-file pointer */
	char	*hash_test_file_name = "hello_word";		/* output-file name    */

	hash_test	= fopen( hash_test_file_name, "a+" );
	if ( hash_test == NULL ) {
		fprintf ( stderr, "couldn't open file '%s'; %s\n",
				hash_test_file_name, strerror(errno) );
		exit (EXIT_FAILURE);
	}

	fprintf(hash_test,"%s\n",filename);

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

	if( fclose(hash_test) == EOF ) {			/* close output file   */
		fprintf ( stderr, "couldn't close file '%s'; %s\n",
				hash_test_file_name, strerror(errno) );
		exit (EXIT_FAILURE);
	}
return EXIT_SUCCESS;
}
