#include "globals.h"

int n;
uint32_t seed0 = 0;
int csv=0;


struct parse_tree {
  int t_s;
  int t_e;
  uint32_t parent_id;
} array[1000];


%%{
  machine strings;
  include latex "latex.rl";


main := |* 

equation => {
if (csv != 0) {
  token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
  printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
         "length:%d,type:%s,<tok:%.*s>}\n",
         filename, (unsigned long)filepath_id, (unsigned long)token_id,
         (unsigned long)parent_id, prefix_len + ts - in, te - ts, "equation",
         te - ts, &in[ts - in]);
} else {
  printf("%.*s", te - ts, &in[ts - in]);
}};

any;
*|;
}%%

    %% write data;
int scanner(const char *in, int length, char filename[], uint32_t filepath_id,
            uint32_t parent_id,int prefix_len,int suffix_len) {
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

