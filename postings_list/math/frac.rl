


int n;
%%{
  
  machine strings;
	include "counter.rl";
left_brace = '{' @{n++; };
right_brace = '}' @{n--; };
brace_body = any - (left_brace|right_brace);
braces = '{' @{n=0;} (left_brace|right_brace|brace_body)* :> '}' when{!n};



  main := |*

 "\\frac" braces braces  => {
	printf("hello world");
	int index = tok->index;
	tok->offset[index]=(ts+1)-in;
	tok->length[index]=te-ts-2;
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
