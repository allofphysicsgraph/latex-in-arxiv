%{

#include "words.h"
#include "file_utils.h"
#include "enum.h"
#include <err.h>
//#include "EVP_MD.h"
#include "sdsalloc.h"
#include "sds.h"
#include "trie.h"

sds temp_str_buffer ;

int print_abstract=1;
int print_gather=1;
int print_equation=1;
int print_proof=1;
int print_eqnarray=1;

int bal_parens=0;
size_t beginbalanced = 0;

int wordCount = 0;
int charCount = 0;
int fileCount = 0;
char current_word[10000];
int print_title=0;
TrieNode *root = NULL;

#define MAX_FILE_COUNT 10000

#ifdef YY_BUF_SIZE
#undef YY_BUF_SIZE
#endif
#define YY_BUF_SIZE 335544320
void consume_until_balanced(char *buf,int buf_len,char start_delimiter, char stop_delimiter);
    // Read the file dictionary
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

greek \\(alpha|Alpha|beta|Beta|chi|delta|Delta|digamma|eta|Eta|gamma|Gamma|iota|Iota|kappa|Kappa|lambda|Lambda|mho|mu|Mu|nu|Nu|omega|Omega|phi|Phi|pi|Pi|psi|Psi|rho|Rho|sigma|Sigma|tau|Tau|theta|Theta|upsilon|varepsilon|varkappa|varphi|varpi|varrho|varsigma|vartheta|xi|Xi|zeta|Zeta)
word [a-z]{3,10}
%s title

%%

{word} {
	wordCount++; charCount += yyleng;
	int test_value= -1;
	test_value = traverse(yytext, root, yyleng);
	if(test_value==1){
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

{greek}  {
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

\\title { memset(current_word,'\0',10000); strcat(current_word,"\\title"); BEGIN(title); }
<title>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                strcat(buf,"{");
                consume_until_balanced(buf,1000,'{','}');
		strcat(current_word,buf);
		
	if(print_title==0){
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
<abstract>[^\\]{1,9} {
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
<gather>[^\\]{1,9} {
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
<proof>[^\\]{1,10} {
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
<eqnarray>[^\\]{1,9} {
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
<equation>[^\\]{1,9} {
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
    int word_count = 0;
    char *words[NUMBER_OF_WORDS];
    FILE *fp = fopen("dictionary.txt", "r");
    root = createTrieNode();

    if (fp == 0)
    {
        fprintf(stderr, "Error while opening dictionary file");
        exit(1);
    }

    words[word_count] = malloc(INPUT_WORD_SIZE);

    while (fgets(words[word_count], INPUT_WORD_SIZE, fp))
    {
        word_count++;
        words[word_count] = malloc(INPUT_WORD_SIZE);
    }

    // Push the words in to Trie
    int i;
    for (i = 0; i < NUMBER_OF_WORDS; i++)
    {
            insert(root, words[i]);
    }
	

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


