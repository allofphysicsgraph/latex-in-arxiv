#include "globals.h"
int n;
uint32_t seed0 = 0;

int prefix_len = 0;
int suffix_len = 0;
uint32_t token_id;

%%{
  machine strings;
  include latex "latex.rl";

action pr(str,prefix_len,suffix_len) { 
token_id = murmur3_seeded_v2(seed0, &in[ts - in], te - ts);
printf("{<filepath:%s>,filepath_id:%lu,token_id:%lu,parent_id:%lu,offset:%d,"
       "length:%d,type:%s,<tok:%.*s>}\n",
       filename, (unsigned long)filepath_id, (unsigned long)token_id,
       (unsigned long)parent_id, prefix_len + ts - in, te - ts, $str, te - ts,
       &in[ts - in]);
int prefix_len = $prefix_len;
int suffix_len = $suffix_len;
}



	action eqtn_str {"equation"}
	action eqtn_prfx {16}
	action eqtn_sffx {14}
	action null_prefix {0}
	action null_suffix {0}

action nested {
scanner(&in[ts + prefix_len - in], te - (prefix_len + suffix_len) - ts,
        filename, filepath_id, token_id, prefix_len, suffix_len);
}

  action strip_nl {
	int start = (int)(ts - in);
	int len = (int)(te - ts);
	char temp_buf[len + 1];
	memset(temp_buf, '\0', len + 1);
	strncpy(temp_buf, &in[ts - in], len);
	for (int i = 0; i < len; i++) {
	  if (temp_buf[i] != '\n')
	    printf("%c", temp_buf[i]);
	}
	printf("\n");
  }

action pr_hello {
	printf("hello");
}

main := |* 
equation@pr(eqtn_str,eqtn_prfx,eqtn_sffx)@nested;
frac</pr_hello;
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

