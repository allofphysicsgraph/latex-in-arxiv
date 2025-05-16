#include "globals.h"
int n;
%%{
  machine strings;
  include latex "latex.rl";
main :=|*
 equation  => {
    printf("%.*s",te-ts,&in[ts-in]);
};

any ;
*| ;
}%%

    %% write data;
int scanner(const char *in,int length) {
  int in_size = length;
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + length;
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  %% write init;
  %% write exec;

  if (cs == strings_error)
    printf("Error near %zd\n", p - in);
}

