
typedef struct token {
	int offset[10000];
	int length[10000];
	int index;
}Token;

int scanner(const char *in, Token * d);
int reader(const char *source, Token * offsets);
