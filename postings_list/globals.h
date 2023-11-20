
typedef struct token {
	int offset[10000];
	int length[10000];
	int index;
}Token;

int scan(const char *in, Token * d);
