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
eqnarray  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "eqnarray",
       te - ts, &in[ts - in]);
};
enumerate  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "enumerate",
       te - ts, &in[ts - in]);
};
itemize  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "itemize",
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


align  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "align",
       te - ts, &in[ts - in]);
};
alignat  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "alignat",
       te - ts, &in[ts - in]);
};
aligned  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "aligned",
       te - ts, &in[ts - in]);
};
array  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "array",
       te - ts, &in[ts - in]);
};
cases  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "cases",
       te - ts, &in[ts - in]);
};
center  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "center",
       te - ts, &in[ts - in]);
};
displaymath  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "displaymath",
       te - ts, &in[ts - in]);
};
enumerate  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "enumerate",
       te - ts, &in[ts - in]);
};
figure  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "figure",
       te - ts, &in[ts - in]);
};
gather  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "gather",
       te - ts, &in[ts - in]);
};
itemize  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "itemize",
       te - ts, &in[ts - in]);
};
matrix  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "matrix",
       te - ts, &in[ts - in]);
};
minipage  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "minipage",
       te - ts, &in[ts - in]);
};
multline  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "multline",
       te - ts, &in[ts - in]);
};
pmatrix  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "pmatrix",
       te - ts, &in[ts - in]);
};
proof  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "proof",
       te - ts, &in[ts - in]);
};
split  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "split",
       te - ts, &in[ts - in]);
};
subequations  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "subequations",
       te - ts, &in[ts - in]);
};
table  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "table",
       te - ts, &in[ts - in]);
};
tabular  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "tabular",
       te - ts, &in[ts - in]);
};
widetext  => {
uint32_t token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id,  ts - in, te - ts, "widetext",
       te - ts, &in[ts - in]);
};
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

