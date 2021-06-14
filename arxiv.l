%{

#include "words.h"
#include "file_utils.h"
#include "enum.h"
#include <err.h>
#include "EVP_MD.h"
#include "sdsalloc.h"
#include "sds.h"

sds temp_str_buffer ;

int print_abstract=1;
int print_gather=1;
int print_equation=1;
int print_proof=1;
int print_eqnarray=1;

int bal_parens=0;
int beginbalanced = 0;

int wordCount = 0;
int charCount = 0;
int fileCount = 0;


#define MAX_FILE_COUNT 10000

#ifdef YY_BUF_SIZE
#undef YY_BUF_SIZE
#endif
#define YY_BUF_SIZE 33554432
%}



%option 8bit 
%option nounput  
%option warn stack 
%s gather abstract proof equation eqnarray
%%




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
	
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}







