#define MAX_TOKEN_COUNT 10000

typedef struct token {
	int offset[MAX_TOKEN_COUNT];
	int length[MAX_TOKEN_COUNT];
	int index;
}Token;
int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index);
int scanner(const char *in, Token * d);
int reader(const char *source, Token * offsets);
