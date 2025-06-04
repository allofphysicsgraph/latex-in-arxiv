#include "globals.h"
int n;
uint32_t seed0 = 0;

%%{
  machine strings;
  include latex "latex.rl";
main :=|*
 equation  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)filepath_id, ts - in, te - ts, "equation", te - ts,
       &in[ts - in]);

scanner(&in[ts + 16 - in], te - 31 - ts, filename, filepath_id, token_id);
};

parens  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "parens", te - ts,
       &in[ts - in]);

scanner(&in[ts + 1 - in], te - 1 - ts, filename, filepath_id, token_id);
};
 
braces  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "braces", te - ts,
       &in[ts - in]);

scanner(&in[ts + 1 - in], te - 1 - ts, filename, filepath_id, token_id);
};


frac  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "frac", te - ts,
       &in[ts - in]);
scanner(&in[ts + 1 - in], te - 1 - ts, filename, filepath_id, token_id);
};

inline_math  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "inline_math", te - ts,
       &in[ts - in]);
scanner(&in[ts + 1 - in], te - 1 - ts, filename, filepath_id, token_id);
};

label  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "label", te - ts,
       &in[ts - in]);
};

cite  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "cite", te - ts,
       &in[ts - in]);
};
ref  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "ref", te - ts,
       &in[ts - in]);
};
integer  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "integer", te - ts,
       &in[ts - in]);
};
any ;
thebibliography ;
*| ;
}%%

    %% write data;
int scanner(const char *in, int length, char filename[], uint32_t filepath_id,
            uint32_t parent_id) {
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

