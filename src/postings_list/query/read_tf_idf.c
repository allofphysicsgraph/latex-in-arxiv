#line 1 "read_tf_idf.rl"
#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

char *buff;

struct stat s, s1;
int offset;
int match_len;
int match;
int lhs_context = 25;
int rhs_context = 50;

typedef struct output {
  char filename[256];
  int offset;
  int length;
} OUTPUT;

int scan(const char *in);

#line 68 "read_tf_idf.rl"

#line 41 "read_tf_idf.c"
static const int strings_start = 44;
static const int strings_first_final = 44;
static const int strings_error = -1;

static const int strings_en_main = 44;

#line 70 "read_tf_idf.rl"

int scan(const char *in) {
  OUTPUT test_data;
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

#line 61 "read_tf_idf.c"
  {
    cs = (int)strings_start;
    ts = 0;
    te = 0;
  }

#line 80 "read_tf_idf.rl"

#line 71 "read_tf_idf.c"
  {
    switch (cs) {
    case 44:
      goto st_case_44;
    case 45:
      goto st_case_45;
    case 0:
      goto st_case_0;
    case 1:
      goto st_case_1;
    case 2:
      goto st_case_2;
    case 3:
      goto st_case_3;
    case 4:
      goto st_case_4;
    case 5:
      goto st_case_5;
    case 46:
      goto st_case_46;
    case 47:
      goto st_case_47;
    case 48:
      goto st_case_48;
    case 49:
      goto st_case_49;
    case 50:
      goto st_case_50;
    case 6:
      goto st_case_6;
    case 7:
      goto st_case_7;
    case 8:
      goto st_case_8;
    case 9:
      goto st_case_9;
    case 10:
      goto st_case_10;
    case 11:
      goto st_case_11;
    case 12:
      goto st_case_12;
    case 13:
      goto st_case_13;
    case 14:
      goto st_case_14;
    case 15:
      goto st_case_15;
    case 16:
      goto st_case_16;
    case 17:
      goto st_case_17;
    case 18:
      goto st_case_18;
    case 19:
      goto st_case_19;
    case 51:
      goto st_case_51;
    case 20:
      goto st_case_20;
    case 21:
      goto st_case_21;
    case 22:
      goto st_case_22;
    case 23:
      goto st_case_23;
    case 24:
      goto st_case_24;
    case 25:
      goto st_case_25;
    case 26:
      goto st_case_26;
    case 52:
      goto st_case_52;
    case 53:
      goto st_case_53;
    case 54:
      goto st_case_54;
    case 55:
      goto st_case_55;
    case 56:
      goto st_case_56;
    case 57:
      goto st_case_57;
    case 58:
      goto st_case_58;
    case 59:
      goto st_case_59;
    case 60:
      goto st_case_60;
    case 61:
      goto st_case_61;
    case 27:
      goto st_case_27;
    case 28:
      goto st_case_28;
    case 29:
      goto st_case_29;
    case 30:
      goto st_case_30;
    case 31:
      goto st_case_31;
    case 32:
      goto st_case_32;
    case 33:
      goto st_case_33;
    case 34:
      goto st_case_34;
    case 35:
      goto st_case_35;
    case 36:
      goto st_case_36;
    case 37:
      goto st_case_37;
    case 38:
      goto st_case_38;
    case 39:
      goto st_case_39;
    case 40:
      goto st_case_40;
    case 41:
      goto st_case_41;
    case 42:
      goto st_case_42;
    case 43:
      goto st_case_43;
    }
  _ctr0 : {
#line 66 "read_tf_idf.rl"
    {
      p = ((te)) - 1;
      {
#line 66 "read_tf_idf.rl"
        printf("%c", (((*(p)))));
      }
    }
  }

#line 208 "read_tf_idf.c"

    goto _st44;
  _ctr22 : {
#line 59 "read_tf_idf.rl"
    {
      te = p + 1;
      {
#line 59 "read_tf_idf.rl"

        char temp[te - ts + 1];
        memset(temp, '\0', te - ts + 1);
        strncpy(temp, &in[ts - in + 1 + 7], te - ts - 1 - 7);
        printf("<%s>", temp);
      }
    }
  }

#line 224 "read_tf_idf.c"

    goto _st44;
  _ctr47 : {
#line 38 "read_tf_idf.rl"
    {
      te = p + 1;
      {
#line 38 "read_tf_idf.rl"

        char temp[te - ts + 1];
        memset(temp, '\0', te - ts + 1);
        strncpy(temp, &in[ts - in + 3], te - ts - 3);
        printf("<%s>", temp);
      }
    }
  }

#line 240 "read_tf_idf.c"

    goto _st44;
  _ctr49 : {
#line 66 "read_tf_idf.rl"
    {
      te = p + 1;
      {
#line 66 "read_tf_idf.rl"
        printf("%c", (((*(p)))));
      }
    }
  }

#line 251 "read_tf_idf.c"

    goto _st44;
  _ctr53 : {
#line 66 "read_tf_idf.rl"
    {
      te = p;
      p = p - 1;
      {
#line 66 "read_tf_idf.rl"
        printf("%c", (((*(p)))));
      }
    }
  }

#line 262 "read_tf_idf.c"

    goto _st44;
  _ctr54 : {
#line 52 "read_tf_idf.rl"
    {
      te = p;
      p = p - 1;
      {
#line 52 "read_tf_idf.rl"

        char temp[te - ts + 1];
        memset(temp, '\0', te - ts + 1);
        strncpy(temp, &in[ts - in + 1 + 5], te - ts - 1 - 5);
        printf("<%s>", temp);
      }
    }
  }

#line 278 "read_tf_idf.c"

    goto _st44;
  _ctr59 : {
#line 52 "read_tf_idf.rl"
    {
      te = p + 1;
      {
#line 52 "read_tf_idf.rl"

        char temp[te - ts + 1];
        memset(temp, '\0', te - ts + 1);
        strncpy(temp, &in[ts - in + 1 + 5], te - ts - 1 - 5);
        printf("<%s>", temp);
      }
    }
  }

#line 294 "read_tf_idf.c"

    goto _st44;
  _ctr60 : {
#line 45 "read_tf_idf.rl"
    {
      te = p;
      p = p - 1;
      {
#line 45 "read_tf_idf.rl"

        char temp[te - ts + 1];
        memset(temp, '\0', te - ts);
        strncpy(temp, &in[ts - in + 2 + 6], te - ts - 2 - 6);
        printf("<%s>", temp);
      }
    }
  }

#line 310 "read_tf_idf.c"

    goto _st44;
  _ctr69 : {
#line 45 "read_tf_idf.rl"
    {
      te = p + 1;
      {
#line 45 "read_tf_idf.rl"

        char temp[te - ts + 1];
        memset(temp, '\0', te - ts);
        strncpy(temp, &in[ts - in + 2 + 6], te - ts - 2 - 6);
        printf("<%s>", temp);
      }
    }
  }

#line 326 "read_tf_idf.c"

    goto _st44;
  _st44:
    if (p == eof)
      goto _out44;
    {
#line 1 "NONE"
      { ts = 0; }
    }

#line 336 "read_tf_idf.c"

    p += 1;
  st_case_44:
    if (p == pe && p != eof)
      goto _out44;
    {
#line 1 "NONE"
      { ts = p; }
    }

#line 346 "read_tf_idf.c"

    if (p == eof) {
      goto _st44;
    } else {
      switch (((*(p)))) {
      case 32: {
        goto _ctr50;
      }
      case 58: {
        goto _ctr51;
      }
      case 105: {
        goto _ctr52;
      }
      }
      goto _ctr49;
    }
  _ctr50 : {
#line 1 "NONE"
    { te = p + 1; }
  }

#line 369 "read_tf_idf.c"

    goto _st45;
  _st45:
    if (p == eof)
      goto _out45;
    p += 1;
  st_case_45:
    if (p == pe && p != eof)
      goto _out45;
    if (p == eof) {
      goto _ctr53;
    } else {
      switch (((*(p)))) {
      case 32: {
        goto _st0;
      }
      case 100: {
        goto _st1;
      }
      case 116: {
        goto _st6;
      }
      }
      goto _ctr53;
    }
  _st0:
    if (p == eof)
      goto _out0;
    p += 1;
  st_case_0:
    if (p == pe && p != eof)
      goto _out0;
    if (p == eof) {
      goto _ctr0;
    } else {
      switch (((*(p)))) {
      case 32: {
        goto _st0;
      }
      case 100: {
        goto _st1;
      }
      case 116: {
        goto _st6;
      }
      }
      goto _ctr0;
    }
  _st1:
    if (p == eof)
      goto _out1;
    p += 1;
  st_case_1:
    if (p == pe && p != eof)
      goto _out1;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 111) {
        goto _st2;
      }
      goto _ctr0;
    }
  _st2:
    if (p == eof)
      goto _out2;
    p += 1;
  st_case_2:
    if (p == pe && p != eof)
      goto _out2;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 99) {
        goto _st3;
      }
      goto _ctr0;
    }
  _st3:
    if (p == eof)
      goto _out3;
    p += 1;
  st_case_3:
    if (p == pe && p != eof)
      goto _out3;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 115) {
        goto _st4;
      }
      goto _ctr0;
    }
  _st4:
    if (p == eof)
      goto _out4;
    p += 1;
  st_case_4:
    if (p == pe && p != eof)
      goto _out4;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 58) {
        goto _st5;
      }
      goto _ctr0;
    }
  _st5:
    if (p == eof)
      goto _out5;
    p += 1;
  st_case_5:
    if (p == pe && p != eof)
      goto _out5;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st46;
      }
      goto _ctr0;
    }
  _st46:
    if (p == eof)
      goto _out46;
    p += 1;
  st_case_46:
    if (p == pe && p != eof)
      goto _out46;
    if (p == eof) {
      goto _ctr54;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st47;
      }
      goto _ctr54;
    }
  _st47:
    if (p == eof)
      goto _out47;
    p += 1;
  st_case_47:
    if (p == pe && p != eof)
      goto _out47;
    if (p == eof) {
      goto _ctr54;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st48;
      }
      goto _ctr54;
    }
  _st48:
    if (p == eof)
      goto _out48;
    p += 1;
  st_case_48:
    if (p == pe && p != eof)
      goto _out48;
    if (p == eof) {
      goto _ctr54;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st49;
      }
      goto _ctr54;
    }
  _st49:
    if (p == eof)
      goto _out49;
    p += 1;
  st_case_49:
    if (p == pe && p != eof)
      goto _out49;
    if (p == eof) {
      goto _ctr54;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st50;
      }
      goto _ctr54;
    }
  _st50:
    if (p == eof)
      goto _out50;
    p += 1;
  st_case_50:
    if (p == pe && p != eof)
      goto _out50;
    if (p == eof) {
      goto _ctr54;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _ctr59;
      }
      goto _ctr54;
    }
  _st6:
    if (p == eof)
      goto _out6;
    p += 1;
  st_case_6:
    if (p == pe && p != eof)
      goto _out6;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 102) {
        goto _st7;
      }
      goto _ctr0;
    }
  _st7:
    if (p == eof)
      goto _out7;
    p += 1;
  st_case_7:
    if (p == pe && p != eof)
      goto _out7;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 95) {
        goto _st8;
      }
      goto _ctr0;
    }
  _st8:
    if (p == eof)
      goto _out8;
    p += 1;
  st_case_8:
    if (p == pe && p != eof)
      goto _out8;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 105) {
        goto _st9;
      }
      goto _ctr0;
    }
  _st9:
    if (p == eof)
      goto _out9;
    p += 1;
  st_case_9:
    if (p == pe && p != eof)
      goto _out9;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 100) {
        goto _st10;
      }
      goto _ctr0;
    }
  _st10:
    if (p == eof)
      goto _out10;
    p += 1;
  st_case_10:
    if (p == pe && p != eof)
      goto _out10;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 102) {
        goto _st11;
      }
      goto _ctr0;
    }
  _st11:
    if (p == eof)
      goto _out11;
    p += 1;
  st_case_11:
    if (p == pe && p != eof)
      goto _out11;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 58) {
        goto _st12;
      }
      goto _ctr0;
    }
  _st12:
    if (p == eof)
      goto _out12;
    p += 1;
  st_case_12:
    if (p == pe && p != eof)
      goto _out12;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st13;
      }
      goto _ctr0;
    }
  _st13:
    if (p == eof)
      goto _out13;
    p += 1;
  st_case_13:
    if (p == pe && p != eof)
      goto _out13;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 46) {
        goto _st14;
      }
      goto _ctr0;
    }
  _st14:
    if (p == eof)
      goto _out14;
    p += 1;
  st_case_14:
    if (p == pe && p != eof)
      goto _out14;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st15;
      }
      goto _ctr0;
    }
  _st15:
    if (p == eof)
      goto _out15;
    p += 1;
  st_case_15:
    if (p == pe && p != eof)
      goto _out15;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st16;
      }
      goto _ctr0;
    }
  _st16:
    if (p == eof)
      goto _out16;
    p += 1;
  st_case_16:
    if (p == pe && p != eof)
      goto _out16;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st17;
      }
      goto _ctr0;
    }
  _st17:
    if (p == eof)
      goto _out17;
    p += 1;
  st_case_17:
    if (p == pe && p != eof)
      goto _out17;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st18;
      }
      goto _ctr0;
    }
  _st18:
    if (p == eof)
      goto _out18;
    p += 1;
  st_case_18:
    if (p == pe && p != eof)
      goto _out18;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st19;
      }
      goto _ctr0;
    }
  _st19:
    if (p == eof)
      goto _out19;
    p += 1;
  st_case_19:
    if (p == pe && p != eof)
      goto _out19;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _ctr22;
      }
      goto _ctr0;
    }
  _ctr51 : {
#line 1 "NONE"
    { te = p + 1; }
  }

#line 783 "read_tf_idf.c"

    goto _st51;
  _st51:
    if (p == eof)
      goto _out51;
    p += 1;
  st_case_51:
    if (p == pe && p != eof)
      goto _out51;
    if (p == eof) {
      goto _ctr53;
    } else {
      if (((*(p))) == 32) {
        goto _st20;
      }
      goto _ctr53;
    }
  _st20:
    if (p == eof)
      goto _out20;
    p += 1;
  st_case_20:
    if (p == pe && p != eof)
      goto _out20;
    if (p == eof) {
      goto _ctr0;
    } else {
      switch (((*(p)))) {
      case 32: {
        goto _st20;
      }
      case 99: {
        goto _st21;
      }
      }
      goto _ctr0;
    }
  _st21:
    if (p == eof)
      goto _out21;
    p += 1;
  st_case_21:
    if (p == pe && p != eof)
      goto _out21;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 111) {
        goto _st22;
      }
      goto _ctr0;
    }
  _st22:
    if (p == eof)
      goto _out22;
    p += 1;
  st_case_22:
    if (p == pe && p != eof)
      goto _out22;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 117) {
        goto _st23;
      }
      goto _ctr0;
    }
  _st23:
    if (p == eof)
      goto _out23;
    p += 1;
  st_case_23:
    if (p == pe && p != eof)
      goto _out23;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 110) {
        goto _st24;
      }
      goto _ctr0;
    }
  _st24:
    if (p == eof)
      goto _out24;
    p += 1;
  st_case_24:
    if (p == pe && p != eof)
      goto _out24;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 116) {
        goto _st25;
      }
      goto _ctr0;
    }
  _st25:
    if (p == eof)
      goto _out25;
    p += 1;
  st_case_25:
    if (p == pe && p != eof)
      goto _out25;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 58) {
        goto _st26;
      }
      goto _ctr0;
    }
  _st26:
    if (p == eof)
      goto _out26;
    p += 1;
  st_case_26:
    if (p == pe && p != eof)
      goto _out26;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st52;
      }
      goto _ctr0;
    }
  _st52:
    if (p == eof)
      goto _out52;
    p += 1;
  st_case_52:
    if (p == pe && p != eof)
      goto _out52;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st53;
      }
      goto _ctr60;
    }
  _st53:
    if (p == eof)
      goto _out53;
    p += 1;
  st_case_53:
    if (p == pe && p != eof)
      goto _out53;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st54;
      }
      goto _ctr60;
    }
  _st54:
    if (p == eof)
      goto _out54;
    p += 1;
  st_case_54:
    if (p == pe && p != eof)
      goto _out54;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st55;
      }
      goto _ctr60;
    }
  _st55:
    if (p == eof)
      goto _out55;
    p += 1;
  st_case_55:
    if (p == pe && p != eof)
      goto _out55;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st56;
      }
      goto _ctr60;
    }
  _st56:
    if (p == eof)
      goto _out56;
    p += 1;
  st_case_56:
    if (p == pe && p != eof)
      goto _out56;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st57;
      }
      goto _ctr60;
    }
  _st57:
    if (p == eof)
      goto _out57;
    p += 1;
  st_case_57:
    if (p == pe && p != eof)
      goto _out57;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st58;
      }
      goto _ctr60;
    }
  _st58:
    if (p == eof)
      goto _out58;
    p += 1;
  st_case_58:
    if (p == pe && p != eof)
      goto _out58;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st59;
      }
      goto _ctr60;
    }
  _st59:
    if (p == eof)
      goto _out59;
    p += 1;
  st_case_59:
    if (p == pe && p != eof)
      goto _out59;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _st60;
      }
      goto _ctr60;
    }
  _st60:
    if (p == eof)
      goto _out60;
    p += 1;
  st_case_60:
    if (p == pe && p != eof)
      goto _out60;
    if (p == eof) {
      goto _ctr60;
    } else {
      if (48 <= ((*(p))) && ((*(p))) <= 57) {
        goto _ctr69;
      }
      goto _ctr60;
    }
  _ctr52 : {
#line 1 "NONE"
    { te = p + 1; }
  }

#line 1051 "read_tf_idf.c"

    goto _st61;
  _st61:
    if (p == eof)
      goto _out61;
    p += 1;
  st_case_61:
    if (p == pe && p != eof)
      goto _out61;
    if (p == eof) {
      goto _ctr53;
    } else {
      if (((*(p))) == 100) {
        goto _st27;
      }
      goto _ctr53;
    }
  _st27:
    if (p == eof)
      goto _out27;
    p += 1;
  st_case_27:
    if (p == pe && p != eof)
      goto _out27;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) == 58) {
        goto _st28;
      }
      goto _ctr0;
    }
  _st28:
    if (p == eof)
      goto _out28;
    p += 1;
  st_case_28:
    if (p == pe && p != eof)
      goto _out28;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st29;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st29;
        }
      } else {
        goto _st29;
      }
      goto _ctr0;
    }
  _st29:
    if (p == eof)
      goto _out29;
    p += 1;
  st_case_29:
    if (p == pe && p != eof)
      goto _out29;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st30;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st30;
        }
      } else {
        goto _st30;
      }
      goto _ctr0;
    }
  _st30:
    if (p == eof)
      goto _out30;
    p += 1;
  st_case_30:
    if (p == pe && p != eof)
      goto _out30;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st31;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st31;
        }
      } else {
        goto _st31;
      }
      goto _ctr0;
    }
  _st31:
    if (p == eof)
      goto _out31;
    p += 1;
  st_case_31:
    if (p == pe && p != eof)
      goto _out31;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st32;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st32;
        }
      } else {
        goto _st32;
      }
      goto _ctr0;
    }
  _st32:
    if (p == eof)
      goto _out32;
    p += 1;
  st_case_32:
    if (p == pe && p != eof)
      goto _out32;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st33;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st33;
        }
      } else {
        goto _st33;
      }
      goto _ctr0;
    }
  _st33:
    if (p == eof)
      goto _out33;
    p += 1;
  st_case_33:
    if (p == pe && p != eof)
      goto _out33;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st34;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st34;
        }
      } else {
        goto _st34;
      }
      goto _ctr0;
    }
  _st34:
    if (p == eof)
      goto _out34;
    p += 1;
  st_case_34:
    if (p == pe && p != eof)
      goto _out34;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st35;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st35;
        }
      } else {
        goto _st35;
      }
      goto _ctr0;
    }
  _st35:
    if (p == eof)
      goto _out35;
    p += 1;
  st_case_35:
    if (p == pe && p != eof)
      goto _out35;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st36;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st36;
        }
      } else {
        goto _st36;
      }
      goto _ctr0;
    }
  _st36:
    if (p == eof)
      goto _out36;
    p += 1;
  st_case_36:
    if (p == pe && p != eof)
      goto _out36;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st37;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st37;
        }
      } else {
        goto _st37;
      }
      goto _ctr0;
    }
  _st37:
    if (p == eof)
      goto _out37;
    p += 1;
  st_case_37:
    if (p == pe && p != eof)
      goto _out37;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st38;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st38;
        }
      } else {
        goto _st38;
      }
      goto _ctr0;
    }
  _st38:
    if (p == eof)
      goto _out38;
    p += 1;
  st_case_38:
    if (p == pe && p != eof)
      goto _out38;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st39;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st39;
        }
      } else {
        goto _st39;
      }
      goto _ctr0;
    }
  _st39:
    if (p == eof)
      goto _out39;
    p += 1;
  st_case_39:
    if (p == pe && p != eof)
      goto _out39;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st40;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st40;
        }
      } else {
        goto _st40;
      }
      goto _ctr0;
    }
  _st40:
    if (p == eof)
      goto _out40;
    p += 1;
  st_case_40:
    if (p == pe && p != eof)
      goto _out40;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st41;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st41;
        }
      } else {
        goto _st41;
      }
      goto _ctr0;
    }
  _st41:
    if (p == eof)
      goto _out41;
    p += 1;
  st_case_41:
    if (p == pe && p != eof)
      goto _out41;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st42;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st42;
        }
      } else {
        goto _st42;
      }
      goto _ctr0;
    }
  _st42:
    if (p == eof)
      goto _out42;
    p += 1;
  st_case_42:
    if (p == pe && p != eof)
      goto _out42;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _st43;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _st43;
        }
      } else {
        goto _st43;
      }
      goto _ctr0;
    }
  _st43:
    if (p == eof)
      goto _out43;
    p += 1;
  st_case_43:
    if (p == pe && p != eof)
      goto _out43;
    if (p == eof) {
      goto _ctr0;
    } else {
      if (((*(p))) < 65) {
        if (48 <= ((*(p))) && ((*(p))) <= 57) {
          goto _ctr47;
        }
      } else if (((*(p))) > 70) {
        if (97 <= ((*(p))) && ((*(p))) <= 102) {
          goto _ctr47;
        }
      } else {
        goto _ctr47;
      }
      goto _ctr0;
    }
  _out44:
    cs = 44;
    goto _out;
  _out45:
    cs = 45;
    goto _out;
  _out0:
    cs = 0;
    goto _out;
  _out1:
    cs = 1;
    goto _out;
  _out2:
    cs = 2;
    goto _out;
  _out3:
    cs = 3;
    goto _out;
  _out4:
    cs = 4;
    goto _out;
  _out5:
    cs = 5;
    goto _out;
  _out46:
    cs = 46;
    goto _out;
  _out47:
    cs = 47;
    goto _out;
  _out48:
    cs = 48;
    goto _out;
  _out49:
    cs = 49;
    goto _out;
  _out50:
    cs = 50;
    goto _out;
  _out6:
    cs = 6;
    goto _out;
  _out7:
    cs = 7;
    goto _out;
  _out8:
    cs = 8;
    goto _out;
  _out9:
    cs = 9;
    goto _out;
  _out10:
    cs = 10;
    goto _out;
  _out11:
    cs = 11;
    goto _out;
  _out12:
    cs = 12;
    goto _out;
  _out13:
    cs = 13;
    goto _out;
  _out14:
    cs = 14;
    goto _out;
  _out15:
    cs = 15;
    goto _out;
  _out16:
    cs = 16;
    goto _out;
  _out17:
    cs = 17;
    goto _out;
  _out18:
    cs = 18;
    goto _out;
  _out19:
    cs = 19;
    goto _out;
  _out51:
    cs = 51;
    goto _out;
  _out20:
    cs = 20;
    goto _out;
  _out21:
    cs = 21;
    goto _out;
  _out22:
    cs = 22;
    goto _out;
  _out23:
    cs = 23;
    goto _out;
  _out24:
    cs = 24;
    goto _out;
  _out25:
    cs = 25;
    goto _out;
  _out26:
    cs = 26;
    goto _out;
  _out52:
    cs = 52;
    goto _out;
  _out53:
    cs = 53;
    goto _out;
  _out54:
    cs = 54;
    goto _out;
  _out55:
    cs = 55;
    goto _out;
  _out56:
    cs = 56;
    goto _out;
  _out57:
    cs = 57;
    goto _out;
  _out58:
    cs = 58;
    goto _out;
  _out59:
    cs = 59;
    goto _out;
  _out60:
    cs = 60;
    goto _out;
  _out61:
    cs = 61;
    goto _out;
  _out27:
    cs = 27;
    goto _out;
  _out28:
    cs = 28;
    goto _out;
  _out29:
    cs = 29;
    goto _out;
  _out30:
    cs = 30;
    goto _out;
  _out31:
    cs = 31;
    goto _out;
  _out32:
    cs = 32;
    goto _out;
  _out33:
    cs = 33;
    goto _out;
  _out34:
    cs = 34;
    goto _out;
  _out35:
    cs = 35;
    goto _out;
  _out36:
    cs = 36;
    goto _out;
  _out37:
    cs = 37;
    goto _out;
  _out38:
    cs = 38;
    goto _out;
  _out39:
    cs = 39;
    goto _out;
  _out40:
    cs = 40;
    goto _out;
  _out41:
    cs = 41;
    goto _out;
  _out42:
    cs = 42;
    goto _out;
  _out43:
    cs = 43;
    goto _out;
  _out : {}
  }

#line 81 "read_tf_idf.rl"

  if (cs == strings_error)
    printf("Error near %zd\n", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);
  return EXIT_SUCCESS;
}

int main(int argc, const char **argv) {
  int cs, res = 0;
  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);

  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    scan((char *)buff);
    munmap(buff, s.st_size);
  }
  close(fd);
  return 0;
}
