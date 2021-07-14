%{

#include "words.h"
#include "file_utils.h"
#include "enum.h"
#include <err.h>
#include "EVP_MD.h"


void consume_until_balanced(char *buf,int buf_len, char start_delimiter, char stop_delimiter);
void consume_until_match(char * stop_word);

int wordCount = 0;
int charCount = 0;
int fileCount = 0;
int stateCount = 0;

int beginbalanced = 0;

int temp_buffer_index=0;
char temp_buffer[10000];

#define MAX_FILE_COUNT 10000
%}




int 
main(int argc,char **argv)
{
	
	//Max file count
	char *array[MAX_FILE_COUNT];
	int i = 0;
	int array_index=0;
	memset(array,0,sizeof(array));
	int r = walk_dir(".", "\\.tex$", WS_DEFAULT|WS_MATCHDIRS,array,array_index);
	switch(r) {
	case WALK_OK:		break;
	case WALK_BADIO:	err(1, "IO error");
	case WALK_BADPATTERN:	err(1, "Bad pattern");
	case WALK_NAMETOOLONG:	err(1, "Filename too long");
	default:
		err(1, "Unknown error?");
	}

	
	//print file matches
	for(i=0;i<MAX_FILE_COUNT;i++){	
		if(array[i] != 0){
			fileCount++;
			yyin=fopen(array[i],"r");
			yylex();
			printf("\nfile_match:%s\n",array[i]);
			file_md5(array[i]);
		}
	}
	

        if (argc < 3){
		printf("arg1: filename\narg2: word lookup\n");
		return 0;
		}


	if (argc > 1) {
		FILE *file;
		file = fopen(argv[1], "r");
		if (!file) {
			fprintf(stderr,"could not open %s\n",argv[1]);
			exit(1);
		}
		yyin = file;
	}
	lookup_word(argv[2],1);
	printf("\nfileCount:%d:\n",fileCount);
	return 0;
}







