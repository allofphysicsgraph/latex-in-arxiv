#include "globals.h"
int n;
uint32_t seed0 = 0;

%%{
  machine strings;
  include latex "latex.rl";
main :=|*
 equation  => {
   uint32_t test = murmur3_seeded_v2(seed0, &in[ts-in], te-ts);
    printf("{id:%lu,offset:%d,length:%d,type:%s,tok:%.*s}\n",(unsigned long)test,ts-in,te-ts,"equation",te-ts,&in[ts-in]);
};
 inline_math  => {
   uint32_t test = murmur3_seeded_v2(seed0, &in[ts-in], te-ts);
    printf("{id:%lu,offset:%d,length:%d,type:%s,tok:%.*s}\n",(unsigned long)test,ts-in,te-ts,"inline_math",te-ts,&in[ts-in]);
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

