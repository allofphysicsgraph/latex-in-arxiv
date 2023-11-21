
typedef struct token {
	int offset[10000];
	int length[10000];
	int index;
}Token;
int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index);
int scanner(const char *in, Token * d);
int reader(const char *source, Token * offsets);
