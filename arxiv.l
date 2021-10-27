%{

#include "words.h"
#include "enum.h"
#include "file_utils.h"
#include <err.h>
#include <ctype.h>

int print_abstract=0;
int print_gather=0;
int print_equation=0;
int print_proof=0;
int print_eqnarray=0;
int print_single_line_math_mode=0;
int print_ref=0;
int bal_parens=0;
int print_file_location=0;
size_t beginbalanced = 0;

int wordCount = 0;
int charCount = 0;
int fileCount = 0;
char current_word[10000];
int print_title=1;

#define MAX_FILE_COUNT 10000

#ifdef YY_BUF_SIZE
#undef YY_BUF_SIZE
#endif
#define YY_BUF_SIZE 3355000
void consume_until_balanced(char *buf,int buf_len,char start_delimiter, char stop_delimiter);
/*


[^\\][a-z]{3,10} {
	wordCount++; charCount += yyleng;
	if(vocabulary_lookup(yytext)==1){
		int match = 0;
		match = lookup_word(yytext,0);
		if (match == 0){
			//printf("adding word:%s\n",yytext);
			add_word(1,yytext);
		} else {
			//printf("updating word:%s\n",yytext);
			update_word(yytext);
		}
	}
	offset+= yyleng;
}
*/

%}


%option outfile="scanner.c" header-file="scanner.h"
%option 8bit 
%option nounput  
%option warn stack 
%option noyy_top_state
%option noyy_pop_state
%option noyy_push_state

%x gather abstract proof equation eqnarray single_line_math_mode reference

%s title

%%


\\title"{" { 
	char tmp[512];
	memset(tmp,'\0',512);
	consume_until_balanced(tmp,512,'{','}');
	tmp[strlen(tmp)-1]='\0';
	printf("%s->%s\n","title",tmp); 
}

.	{ offset++; }
\n	{ lineCount++; offset=1; }
%%


int 
main(int argc,char **argv)
{
        YY_BUFFER_STATE buf;
	char* buffer = ReadFile(argv[1]);
	size_t i = 0;
	int unprintable_characters=0;
	for(i=0;i<strlen(buffer);i++){
		if(!isascii(buffer[i])){
			unprintable_characters++;
			buffer[i]=' ';
		}
	}
	//printf("# of unprintable characters:%d\n",unprintable_characters);
        buf = yy_scan_string( buffer);
        yy_switch_to_buffer(buf);
	yylex();
	if (argc == 3) lookup_word(argv[2],1);
	return 0;
}





void consume_until_balanced(char *buf,int buf_len,char start_delimiter, char stop_delimiter)
{
                //printf("balanced");
                int c;
                int index=0;
                memset(buf,'\0',buf_len);
                bal_parens--;
                while((c = input()) != 0)
                {
                    if ( c == EOF )
                        {
                        printf( "EOF " );
                        break;
                        }
                if(index<buf_len){
			if(c=='\n'){
				buf[index]='\\';
				index++;
				buf[index]='\\';
			} else { buf[index]=c;}
                        index++;
                } else {
                                printf("buffer passed was too small");
                                break;
                }
                offset++;
                if(c == '\n') { ++lineCount;}
                if(c == start_delimiter)  { bal_parens--; }
                if(c == stop_delimiter)  { bal_parens++; }
                if(bal_parens == 0) { break; }
		//buf[index-1]='\0';
                }
}


