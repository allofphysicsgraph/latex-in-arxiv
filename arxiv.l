%{

int bal_parens=0;
void consume_until_balanced();
int wordCount = 0;
int charCount = 0;
#include "words.h"


%}

word [a-z]+ 


%%

{word}	{ 
	wordCount++; charCount += yyleng; 
	int match = 0;
	match = lookup_word(yytext,0);
	if (match == 0){
		//printf("adding word:%s\n",yytext);
		add_word(1,yytext);
	} else {
		//printf("updating word:%s\n",yytext);
		update_word(yytext);
	}
	offset+= yyleng;
}

\\hello"{"		{
			consume_until_balanced();
			}
		

.	{ offset++; }
\n	{ lineCount++; offset=1; }
%%


int 
main(int argc,char **argv)
{
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
	yylex();
	lookup_word("hello",1);
	return 0;
}

void consume_until_balanced()
{
		int c;
		bal_parens--;
		while((c = input()) != 0)
		{
		offset++;
		if(c == '\n') { ++lineCount;}
		if(c == '{')  { bal_parens--; }
		if(c == '}')  { bal_parens++; }
                if(bal_parens == 0) { break; }
				
		}
};





