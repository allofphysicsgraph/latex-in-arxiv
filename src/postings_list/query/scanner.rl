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
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, "equation",
       te - ts, &in[ts - in]);
int prefix_len = 16;
int suffix_len = 14;
scanner(&in[ts + prefix_len - in], te - (prefix_len + suffix_len) - ts,
        filename, filepath_id, token_id, prefix_len, suffix_len);
};

hspace ; 
subexpr  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "subexpr",
       te - ts, &in[ts - in]);
};

frac  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "frac",
       te - ts, &in[ts - in]);
};
parens  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, "parens",
       te - ts, &in[ts - in]);
};
inline_math  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, "inline",
       te - ts, &in[ts - in]);
};

label  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, "label",
       te - ts, &in[ts - in]);
int prefix_len = 1;
int suffix_len = 1;
};

braces  => {
if ((te-ts)<100){
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, "braces",
       te - ts, &in[ts - in]);
int prefix_len = 1;
int suffix_len = 1;
}};

brackets  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, "brackets",
       te - ts, &in[ts - in]);
};

hat  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "hat",
       te - ts, &in[ts - in]);
};

lim  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, ts - in, te - ts, "lim",
       te - ts, &in[ts - in]);
};

int  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "int",
       te - ts, &in[ts - in]);
};

e  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "e",
       te - ts, &in[ts - in]);
};

eta  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "eta",
       te - ts, &in[ts - in]);
};

sqrt  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "sqrt",
       te - ts, &in[ts - in]);
};
newcommand  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "newcommand",
       te - ts, &in[ts - in]);
};
author  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "author",
       te - ts, &in[ts - in]);
};
abstract  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "abstract",
       te - ts, &in[ts - in]);
};

section  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "section",
       te - ts, &in[ts - in]);
};

title  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "title",
       te - ts, &in[ts - in]);
};
affiliation  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "affiliation",
       te - ts, &in[ts - in]);
};
cite  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "cite",
       te - ts, &in[ts - in]);
};
ref  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "ref",
       te - ts, &in[ts - in]);
};
bibitem  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "bibitem",
       te - ts, &in[ts - in]);
};
comment  => {
       char test[2];
       memset(test,'\0',2);
       if((ts-in-1)>0){
       strncpy(test,&in[ts-in-1],1);
       if(strcmp("\\",test)!=0){
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te-1 - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in,te-1 - ts, "comment",
       te-1 - ts, &in[ts - in]);
}}};

any ;
*| ;
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

