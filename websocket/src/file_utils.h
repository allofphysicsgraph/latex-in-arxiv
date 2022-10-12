#include <regex.h>
#include <hiredis.h>

char *ReadFile(char *filename);
int walk_recur(char *dname, regex_t *reg, int spec,char * array[],int array_index);
int walk_dir(char *dname, char *pattern, int spec, char * array[], int array_index);
void file_search(char* dir_path);
int rematch(char *buffer, char *pattern);
redisContext *Conn(void);
