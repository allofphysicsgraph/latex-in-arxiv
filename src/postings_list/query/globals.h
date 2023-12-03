#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */
#include "uthash.h"
#include "xxhash.h"

#define MAX_DOCUMENT_COUNT 250
#define MAX_FILE_PATH_LENGTH 256

#define MAX_TOKEN_COUNT 100000
#define MAX_TOKEN_LENGTH 10000
#define MAX_OFFSETS 750

void print_context(char *filename,int offset, int match_len, int lhs_context, int rhs_context);
int cmp_Canonical_XXH64(const char *hashStr, XXH64_hash_t hash);
int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index);

int scanner(const char *in, char* filename);
int reader(const char *source);


struct my_struct {
  XXH64_hash_t id; /* key */
  int count;
  int length;

  int offsets[MAX_OFFSETS];
  int index;
  
  int doc_count;
  char token[MAX_TOKEN_LENGTH];
  UT_hash_handle hh; /* makes this structure hashable */
};


void srt();
void add_token(XXH64_hash_t token_id, const char *token,int length,int tok_offset);
struct my_struct *find_token(XXH64_hash_t token_id);
void delete_all();
void print_tokens();
int by_token(const struct my_struct *a, const struct my_struct *b);
int by_id(const struct my_struct *a, const struct my_struct *b);
//const char *getl(const char *prompt);

