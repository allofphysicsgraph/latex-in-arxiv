#include "uthash.h"
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */
#include <ftw.h>

#define _XOPEN_SOURCE 500 // Required for nftw in some systems
#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>
#include <errno.h>

#define MAX_FILE_PATH_LENGTH 128
#define MAX_TOKEN_COUNT 2560
#define MAX_TOKEN_LENGTH 2500

int scanner(const char *in, int length);

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

void write_tf_idf();
void add_token(uint32_t token_id, const char *token, int length,
               char filename[256]);
void delete_all();
void srt();
