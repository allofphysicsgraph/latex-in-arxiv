%{
#include <stdio.h>
%}
%s bibitem
%s newblock

LBRACKET "["
RBRACKET "]"
DIGIT [0-9]
FIRST_INITIAL [A-Z]"."
MIDDLE_INITIAL [A-Z]"."
LAST_NAME [A-Z][a-z]+
WS [ \t]
LPAREN "("
RPAREN ")"
YEAR (18|19|20){DIGIT}{2}
PAGE_NO "pp."{WS}*{DIGIT}+({HYPHEN}{DIGIT}+)?
HYPHEN "-"
NOT_WS [^{WS}]

%%
{LBRACKET}{DIGIT}+{RBRACKET} { printf("ID:%s\n",yytext);}
{FIRST_INITIAL}{WS}+({MIDDLE_INITIAL}{WS}+)?{LAST_NAME} { printf("NAME:%s\n",yytext);}
{LPAREN}{YEAR}{RPAREN}	{ printf("year:%s",yytext);}
\\bibitem { BEGIN bibitem; }
<bibitem>"["{NOT_WS}+"]""{"{NOT_WS}+"}" { printf("bibitem:%s",yytext);}
<bibitem>^[^\\]newblock { BEGIN 0; printf("bibitem:%s",yytext);}
\\newblock.* { printf("%s",yytext);}
. ;




%%

int
main(int argc, char* argv[]){
	yyin = fopen(argv[1],"r");
	yylex();
	return 0;
}
