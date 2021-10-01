int add_word(int type, char *word);
int lookup_word(char *word,int print);
int update_word(char *word);
int lookup_word_by_word_type(int type,int print);
int vocabulary_add_word(char *word);
int vocabulary_lookup(char *word);
int read_vocabulary_file();
extern int lineCount;
extern int offset;
