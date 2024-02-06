#include <stdbool.h>
#include <stdarg.h>
#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <math.h>
#include <stdint.h>
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
#include "globals.h"


int n;
int in_size = 0;
char temp_buffer[10024];

int write_to_file(const char *filename, const char *format, ...);
%%{

  machine strings;
  include strings "vocab.rl";
  include latex "latex.rl";
  include context "context.rl";
  include transformations "transformations.rl";

main :=|*

    inline => {
int lhs_ctxt = 0;
int rhs_ctxt = 0;

if ((te - ts) < 1000) {
  XXH64_canonical_t dst;
  char temp[te - ts + 1];
  memset(temp, '\0', te - ts + 1);
  int offset = ts - in;
  int length = te - ts;
  int lhs = MAX(offset - lhs_ctxt, 0);
  int rhs =
      MIN(offset + rhs_ctxt,
          in_size); /* in_size is the input length passed to the scanner. */
  int context_len = te - ts + 1 + rhs - lhs;
  char context[context_len];
  memset(context, '\0', context_len);
  memcpy(context, &in[lhs], context_len - 1);
  /* hash original token */
  strncpy(temp, &in[offset], length);
  XXH64_hash_t test_hash = XXH64(temp, length, 0);
  add_token(test_hash, temp, length, filename);
      size_t i = 0;
      XXH64_canonicalFromHash(&dst, test_hash);
      //for (i = 0; i < 8; i++) {
        //fprintf(hash_test, "%02x", dst.digest[i]);
      //}
      //fprintf(hash_test, " %d  %d\n", offset, length);

  /* hash token + context for post-processing */
  if ((lhs_ctxt > 0) | (rhs_ctxt > 0))
    test_hash = XXH64(context, context_len, 0);
  add_token(test_hash, context, context_len, filename);
      i = 0;
      XXH64_canonicalFromHash(&dst, test_hash);
      for (i = 0; i < 8; i++) {
        //fprintf(hash_test, "%02x", dst.digest[i]);
      }
      //fprintf(hash_test, " %d  %d\n", offset, length);
    }
  };


  latex  => {
    if ((te - ts) < 1000) {
      XXH64_canonical_t dst;
      char temp[te - ts + 1];
      memset(temp, '\0', te - ts + 1);
      int offset = ts - in;
      int length = te - ts;
      strncpy(temp, &in[offset], length);
      XXH64_hash_t test_hash = XXH64(temp, length, 0);
      add_token(test_hash, temp, length, filename);
      XXH64_canonicalFromHash(&dst, test_hash);
      size_t i;
      for (i = 0; i < 8; i++) {
        //fprintf(hash_test, "%02x", dst.digest[i]);
        //write_to_file("offsets","%02x",dst.digest[i]);
      }
      //fprintf(hash_test, " %d  %d\n", offset, length);
    }
  };
  any;
  *| ;
}%%

    %% write data;
int scanner(const char *in, char *filename,int length) {
  in_size = length;
  write_to_file("offsets","%s",filename);
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + length;
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



int write_to_file(const char *filename, const char *format, ...) {
    FILE *file;
    int result;
    file = fopen(filename, "a+");
    if (file == NULL) {
        return -1; // error opening file
    }
    va_list args;
    va_start(args, format);
    result = vfprintf(file, format, args);
    va_end(args);
    fclose(file);
    return result;
}

