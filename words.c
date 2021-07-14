#include <string.h>
#include <stdio.h>
#include <stdlib.h>
int lineCount = 1;
int offset = 1;
int word_count = 0;
enum {
	LOOKUP = 0, /* default - looking rather than defining. */
};

struct word {
	char *word_name;
	int word_type;
	int id;
	int count;
	// Making the assumption that there are less than 10K instances of the same word.
	int lineCount[10000];
	int offset[10000];
	int lineStop[10000];
	int offsetStop[10000];
	double tf;
	struct word *next;
	
};

struct word *word_list; /* first element in word list */

int
add_word(int type, char *word)
{
	word_count++;
	struct word *wp;	
	/* word not there, allocate a new entry and link it on the list */
	wp = (struct word *) malloc(sizeof(struct word));
	wp->next = word_list;
	/* have to copy the word itself as well */
	wp->word_name = (char *) malloc(strlen(word)+1);
	strcpy(wp->word_name, word);
	wp->word_type = type; //int data type
	wp->lineCount[0] = lineCount;
	wp->offset[0] = offset;
	wp->count = 1;
	//printf("%lf",1/(1.0* word_count));
	wp->tf=1/(1.0*word_count);
	word_list = wp;
	return 1;	/* it worked */
}

int
lookup_word(char *word,int print)
{
	struct word *wp = word_list;
	/* search down the list looking for the word */
	int i = 0;
        //printf("lookup_word:%s\n",word);
	for(; wp; wp = wp->next) {
		if(strcmp(wp->word_name, word) == 0){
			for(i=0;i<(wp->count);i++){
				//printf("i:%d\n",i);
				if(wp->lineCount[i]>0){
					if(print != 0){
						printf("%s:line_no:%d:offset:%d:count:%d:tf:%f\n",word,wp->lineCount[i],wp->offset[i],wp->count,wp->tf);
					}	
			}
			}
			return 1;
		}
	}
	return LOOKUP;	 /* not found */
}




int
lookup_word_by_word_type(int type,int print)
{
	struct word *wp = word_list;
	/* search down the list looking for the word */
	int i = 0;
	for(; wp; wp = wp->next) {
		if( wp->word_type == type){
			for(i=0;i<(wp->count);i++){
				//printf("i:%d\n",i);
				if(wp->lineCount[i]>0){
					if(print != 0){
						printf("%s:line_no:%d:offset:%d\n",wp->word_name,wp->lineCount[i],wp->offset[i]);
					}	
			}
			}
		}
	}
	return LOOKUP;	 /* not found */
}




int 
update_word(char *word)
{
	//printf("updating word:%s\n",word);
	struct word *wp = word_list;
	/* search down the list looking for the word */
	for(; wp; wp = wp->next) {
		if(strcmp(wp->word_name, word) == 0)
		{ wp->lineCount[wp->count] = lineCount;
			wp->offset[wp->count] = offset;
			//printf("updating count:%d\n",wp->count);
			wp->count++;
			//printf("updating count:%d\n",wp->count);
			return 0;
		}
	}
	return 1;
}


