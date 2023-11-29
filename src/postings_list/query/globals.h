#include "xxhash.h"

#define MAX_DOCUMENT_COUNT 250
#define MAX_FILE_PATH_LENGTH 256

#define MAX_TOKEN_COUNT 10000
#define MAX_TOKEN_LENGTH 1000

void print_context(char *filename,int offset, int match_len, int lhs_context, int rhs_context);
int cmp_Canonical_XXH64(const char *hashStr, XXH64_hash_t hash);
int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index);

int scanner(const char *in, char* filename);
int reader(const char *source);
