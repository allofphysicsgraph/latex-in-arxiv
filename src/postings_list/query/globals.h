#include "xxhash.h"

#define MAX_DOCUMENT_COUNT 250
#define MAX_FILE_PATH_LENGTH 256

#define MAX_TOKEN_COUNT 1000
#define MAX_TOKEN_LENGTH 1000

int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index);

int scanner(const char *in, char* filename);
int reader(const char *source);
