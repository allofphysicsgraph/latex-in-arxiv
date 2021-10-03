#include "file_utils.h"
#define MAX_FILE_COUNT 100000
#include <string.h>
#include <stdio.h>

enum {
        LOOKUP = 0, /* default - looking rather than defining. */
        WALK_OK = 0,
        WALK_BADPATTERN,
        WALK_NAMETOOLONG,
        WALK_BADIO,
};

#define WS_NONE         0
#define WS_RECURSIVE    (1 << 0)
#define WS_DEFAULT      WS_RECURSIVE
#define WS_FOLLOWLINK   (1 << 1)        /* follow symlinks */
#define WS_DOTFILES     (1 << 2)        /* per unix convention, .file is hidden */
#define WS_MATCHDIRS    (1 << 3)        /* if pattern is used on dir names too */

int main(int argc, char** argv){
	char *array[MAX_FILE_COUNT];
        int i = 0;
        int array_index=0;
        memset(array,0,sizeof(array));
        int r = walk_dir("/home/user", "\\.c$", WS_DEFAULT|WS_MATCHDIRS,array,array_index);
        switch(r) {
        case WALK_OK:           break;
        case WALK_BADIO:        printf("IO error");
        case WALK_BADPATTERN:   printf("Bad pattern");
        case WALK_NAMETOOLONG:  printf("Filename too long");
        default:
                printf("Unknown error?");
        }
	i = 0;
	while (array[i]!=NULL){
		printf("%s\n",array[i]);
	i++;
	}
	return 0;

}
