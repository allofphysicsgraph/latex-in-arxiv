%{

#include "words.h"
#include "file_utils.h"
#include "enum.h"
#include <err.h>
//#include "EVP_MD.h"
#include "sdsalloc.h"
#include "sds.h"

sds temp_str_buffer ;

int print_abstract=0;
int print_gather=0;
int print_equation=0;
int print_proof=0;
int print_eqnarray=0;

int bal_parens=0;
size_t beginbalanced = 0;

int wordCount = 0;
int charCount = 0;
int fileCount = 0;
char current_word[10000];
int print_title=0;

#define MAX_FILE_COUNT 10000

#ifdef YY_BUF_SIZE
#undef YY_BUF_SIZE
#endif
#define YY_BUF_SIZE 335544320
void consume_until_balanced(char *buf,int buf_len,char start_delimiter, char stop_delimiter);

// BINARY OPERATORS
// \\pm { yyval.str=strdup(yytext); return(pm); }
// \\cap { yyval.str=strdup(yytext); return(cap); }
// \\vee { yyval.str=strdup(yytext); return(vee); }
// \\mp { yyval.str=strdup(yytext); return(mp); }
// \\cup { yyval.str=strdup(yytext); return(cup); }
// \\wedge { yyval.str=strdup(yytext); return(wedge); }
// \\setminus { yyval.str=strdup(yytext); return(setminus); }
// \\uplus { yyval.str=strdup(yytext); return(uplus); }
// \\oplus { yyval.str=strdup(yytext); return(oplus); }
// \\cdot { yyval.str=strdup(yytext); return(cdot); }
// \\sqcap { yyval.str=strdup(yytext); return(sqcap); }
// \\ominus { yyval.str=strdup(yytext); return(ominus); }
// \\times { yyval.str=strdup(yytext); return(times); }
// \\sqcup { yyval.str=strdup(yytext); return(sqcup); }
// \\otimes { yyval.str=strdup(yytext); return(otimes); }
// \\ast { yyval.str=strdup(yytext); return(ast); }
// \\triangleleft { yyval.str=strdup(yytext); return(triangleleft); }
// \\oslash { yyval.str=strdup(yytext); return(oslash); }
// \\star { yyval.str=strdup(yytext); return(star); }
// \\triangleright { yyval.str=strdup(yytext); return(triangleright); }
// \\odot { yyval.str=strdup(yytext); return(odot); }
// \\diamond { yyval.str=strdup(yytext); return(diamond); }
// \\wr { yyval.str=strdup(yytext); return(wr); }
// \\dagger { yyval.str=strdup(yytext); return(dagger); }
// \\circ { yyval.str=strdup(yytext); return(circ); }
// \\bigcirc { yyval.str=strdup(yytext); return(bigcirc); }
// \\ddagger { yyval.str=strdup(yytext); return(ddagger); }
// \\bullet { yyval.str=strdup(yytext); return(bullet); }
// \\bigtriangleup { yyval.str=strdup(yytext); return(bigtriangleup); }
// \\amalg { yyval.str=strdup(yytext); return(amalg); }
// \\div { yyval.str=strdup(yytext); return(div); }
// \\bigtriangledown { yyval.str=strdup(yytext); return(bigtriangledown); }

%}



%option 8bit 
%option nounput  
%option warn stack 
%option noyy_top_state
%option noyy_pop_state
%option noyy_push_state
%option noyymore

%s gather abstract proof equation eqnarray

word [^\\][a-z]{3,10}
latex "\\"[a-z]{1,20}

%s title

%%


{latex} {
	//printf("LATEX:%s\n",yytext);
	wordCount++; charCount += yyleng;
	if(vocabulary_lookup(yytext)==1){
		int match = 0;
		match = lookup_word(yytext,0);
		if (match == 0){
			printf("adding word:%s\n",yytext);
			add_word(1,yytext);
		} else {
			printf("updating word:%s\n",yytext);
			update_word(yytext);
		}
		
		offset+= yyleng;

	} else {printf("UNKNOWN:%s\n",yytext); }

}


{word} {
	wordCount++; charCount += yyleng;
	if(vocabulary_lookup(yytext)==1){
		int match = 0;
		match = lookup_word(yytext,0);
		if (match == 0){
			printf("adding word:%s\n",yytext);
			add_word(1,yytext);
		} else {
			printf("updating word:%s\n",yytext);
			update_word(yytext);
		}
	}
	offset+= yyleng;
}


\\title { memset(current_word,'\0',10000); strcat(current_word,"\\title"); BEGIN(title); }
<title>\n	{ lineCount++; offset=1; }
<title>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                strcat(buf,"{");
                consume_until_balanced(buf,1000,'{','}');
		strcat(current_word,buf);
		
	if(print_title==1){
			printf("%s",current_word);	
		}
        }
<title>"[" {
                char buf[1000];
                memset(buf,'\0',1000);
                strcat(buf,"[");
                consume_until_balanced(buf,1000,'[',']');
		strcat(current_word,buf);
		if(print_title==0){
			printf("%s",current_word);	
		
        }
}
<title>. { printf("\n"); BEGIN(0); }


\\begin"{abstract}" {
        beginbalanced--;
        if(temp_str_buffer==NULL){
                temp_str_buffer=sdsnew(yytext);
        } else {
                temp_str_buffer=sdscat(temp_str_buffer,"\n\n");
                temp_str_buffer=sdscat(temp_str_buffer,yytext);
        }
        BEGIN(abstract);
}
<abstract>\n	{ lineCount++; offset=1; }
<abstract>[^\\\n]{1,9} {
        temp_str_buffer = sdscat(temp_str_buffer,yytext);
}
<abstract>\\ { temp_str_buffer = sdscat(temp_str_buffer,yytext); }
<abstract>\\end"{abstract}" { beginbalanced++;
        temp_str_buffer=sdscat(temp_str_buffer,yytext);
        if(beginbalanced==0){
                if(print_abstract==1){
			printf("%s",temp_str_buffer);
		}
                sdsclear(temp_str_buffer);
                BEGIN(0);
        }}


\\begin"{gather}" {
            beginbalanced--;
            if(temp_str_buffer==NULL){
                    temp_str_buffer=sdsnew(yytext);
            } else {
                    temp_str_buffer=sdscat(temp_str_buffer,"\n\n");
                    temp_str_buffer=sdscat(temp_str_buffer,yytext);
            }
            BEGIN(gather);
    }
<gather>\n	{ lineCount++; offset=1; }
<gather>[^\\\n]{1,9} {
            temp_str_buffer = sdscat(temp_str_buffer,yytext);
    }
<gather>\\ { temp_str_buffer = sdscat(temp_str_buffer,yytext); }
<gather>\\end"{gather}" { beginbalanced++;
            temp_str_buffer=sdscat(temp_str_buffer,yytext);
            if(beginbalanced==0){
                    if(print_gather==1){
                printf("%s",temp_str_buffer);
            }
                    sdsclear(temp_str_buffer);
                    BEGIN(0);
            }}


\\begin"{proof}" {
            beginbalanced--;
            if(temp_str_buffer==NULL){
                    temp_str_buffer=sdsnew(yytext);
            } else {
                    temp_str_buffer=sdscat(temp_str_buffer,"\n\n");
                    temp_str_buffer=sdscat(temp_str_buffer,yytext);
            }
            BEGIN(proof);
    }
<proof>\n	{ lineCount++; offset=1; }
<proof>[^\\\n]{1,10} {
            temp_str_buffer = sdscat(temp_str_buffer,yytext);
    }
<proof>\\ { temp_str_buffer = sdscat(temp_str_buffer,yytext); }
<proof>\\end"{proof}" { beginbalanced++;
            temp_str_buffer=sdscat(temp_str_buffer,yytext);
            if(beginbalanced==0){
                    if(print_proof==1){
                	printf("%s",temp_str_buffer);
                    }
                    sdsclear(temp_str_buffer);
                    BEGIN(0);
}}

\\begin"{eqnarray}" {
            beginbalanced--;
            if(temp_str_buffer==NULL){
                    temp_str_buffer=sdsnew(yytext);
            } else {
                    temp_str_buffer=sdscat(temp_str_buffer,"\n\n");
                    temp_str_buffer=sdscat(temp_str_buffer,yytext);
            }
            BEGIN(eqnarray);
    }
<eqnarray>\n	{ lineCount++; offset=1; }
<eqnarray>[^\\\n]{1,9} {
            		temp_str_buffer = sdscat(temp_str_buffer,yytext);
    		}
<eqnarray>\\ { temp_str_buffer = sdscat(temp_str_buffer,yytext); }
<eqnarray>\\end"{eqnarray}" { beginbalanced++;
            temp_str_buffer=sdscat(temp_str_buffer,yytext);
            if(beginbalanced==0){
            	if(print_eqnarray==1){
                	printf("%s",temp_str_buffer);
            	}
                sdsclear(temp_str_buffer);
                BEGIN(0);
            }}

\\begin"{equation}" {
            beginbalanced--;
            if(temp_str_buffer==NULL){
                    temp_str_buffer=sdsnew(yytext);
            } else {
                    
                temp_str_buffer=sdscat(temp_str_buffer,"\n\n");
		temp_str_buffer=sdscat(temp_str_buffer,yytext);
            }
            BEGIN(equation);
    }

<equation>\n	{ lineCount++; offset=1; }
<equation>[^\\\n]{1,9} {
            temp_str_buffer = sdscat(temp_str_buffer,yytext);
    }
<equation>\\ { temp_str_buffer = sdscat(temp_str_buffer,yytext); }
<equation>\\end"{equation}" { beginbalanced++;
            temp_str_buffer=sdscat(temp_str_buffer,yytext);
            if(beginbalanced==0){
            	if(print_equation==1){
               		printf("%s",temp_str_buffer);
            }
                    sdsclear(temp_str_buffer);
                    BEGIN(0);
            }}

.	{ offset++; }

\n	{ lineCount++; offset=1; }
%%


int 
main(int argc,char **argv)
{
	//int match = -1;
	vocabulary_add_word("\\begin");
	/*match = vocabulary_lookup("\\bxegin");
	if(match){
		printf("%d",match);
	}
	return 0;
	*/
	read_vocabulary_file("english_vocab.txt");
	read_vocabulary_file("latex_math.txt");
	read_vocabulary_file("latex_misc.txt");
	/*match = vocabulary_lookup("\\begin");
	if(match){
		printf("%d",match);
	}*/

	yyin=fopen(argv[1],"r");
	yylex();
	lookup_word(argv[2],1);
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
                        buf[index]=c;
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

                }
}


