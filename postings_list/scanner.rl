#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "globals.h"
#
	//printf("index:%zd offset:%zd len:%zd\n",tok->index,ts-in,te-ts);
	//printf("index:%zd offset:%zd len:%zd\n",tok->index,ts-in,te-ts);

int n;
%%{
  
  machine strings;
  	include strings "vocab.rl";
  	include latex "latex.rl";
  
  main := |*

    word => {
	int index = tok->index;
	tok->offset[index]=ts-in;
	tok->length[index]=te-ts;
	tok->index++;};

    latex => { 
	int index = tok->index;
	tok->offset[index]=ts-in;
	tok->length[index]=te-ts;
	tok->index++;};
  
    any ;

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
    printf("Error near %zd\n", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);

  return EXIT_SUCCESS;
}
