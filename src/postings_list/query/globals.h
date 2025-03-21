#include "uthash.h"
#include "xxhash.h"
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

void print_context(char *filename, int offset, int match_len, int lhs_context,
                   int rhs_context);
int cmp_Canonical_XXH64(const char *hashStr, XXH64_hash_t hash);

int scanner(const char *in, FILE* hash_test,int length,char *filename);
//int scanner(const char *in, char *filename, int length);
int reader(const char *source);

struct my_struct {
  XXH64_hash_t id; /* key */
  int count;
  int length;

  char current_file[256];
  int doc_count; /* number of docs that contains this token */
  float tf_idf;
  char token[MAX_TOKEN_LENGTH];
  UT_hash_handle hh; /* makes this structure hashable */
};

void write_tf_idf();
int by_id(const struct my_struct *a, const struct my_struct *b);
int by_token(const struct my_struct *a, const struct my_struct *b);
struct my_struct *find_token(XXH64_hash_t token_id);
void add_token(XXH64_hash_t token_id, const char *token, int length,
               char filename[256]);
void delete_all();
void update_tf_idf(int total_doc_count);
void print_tokens();
void print_tf_idf();
void srt();
const char *getl(const char *prompt);
