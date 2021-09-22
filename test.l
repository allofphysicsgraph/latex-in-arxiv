%{
#include <ctype.h>
int lineno=0;
%}

%%

. { int i=-1; 
    if(!isascii(yytext[0]))
	{printf("%d",lineno);} 
}

\n { lineno++; }

%%


int main(int argc, char** argv){

	yyin=fopen(argv[1],"r");
	yylex();

	return 0;
}
