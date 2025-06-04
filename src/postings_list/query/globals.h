#include "uthash.h"
#include <ftw.h>
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */

#define _XOPEN_SOURCE 500 // Required for nftw in some systems
#include <errno.h>
#include <ftw.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_TOKEN_LENGTH 2000

int scanner(const char *in, int length,char filename[],uint32_t filenpath_id,uint32_t parent_id,int prefix_len,int suffix_len);
uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len);
//const uint32_t seed0 = 0x293ae76f;

struct my_struct {
  uint32_t id;
  int count;
  int length;
  char current_file[256];
  int doc_count; /* number of docs that contains this token */
  float tf_idf;
  char token[MAX_TOKEN_LENGTH];
  UT_hash_handle hh; /* makes this structure hashable */
};

//void write_tf_idf();
void add_token(uint32_t token_id, const char *token, int length,
               char filename[256]);
//void delete_all();
//void srt();
