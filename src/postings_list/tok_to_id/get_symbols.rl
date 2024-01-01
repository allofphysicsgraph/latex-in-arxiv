#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "globals.h"
#include "xxhash.h"
int n;
%%{
  
  machine strings;
	include latex "latex.rl"; 


  main := |*


    latex => { 
	int offset=ts-in;
	int length=te-ts;
	char temp[length+1];
	memset(temp,'\0',length+1);

	XXH64_canonical_t dst;
        XXH64_hash_t test_hash = XXH64(temp, length, 0);
	size_t i = 0;
	XXH64_canonicalFromHash(&dst, test_hash);
	printf("<");
	for (i = 0; i < 8; i++) {
		printf("%02x", dst.digest[i]);
	}
	printf(">");
	};
	any  => {
		printf("%c",fc);
	};

  	*|;
}%%


%% write data;
int scanner(const char *in, Token* ptr) {
  Token *tok= ptr;
 int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  %% write init;
  %% write exec;

  if (cs == strings_error)
    printf("Error near %zd ", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd ", ts - in, te - in, pe - in);

  return EXIT_SUCCESS;
}
