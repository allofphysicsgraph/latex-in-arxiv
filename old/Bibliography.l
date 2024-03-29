%{
#include <stdio.h>
%}
%s bibitem
%s newblock
%s arxiv

LBRACKET "["
RBRACKET "]"
DIGIT [0-9]
FIRST_INITIAL [A-Z]"."
MIDDLE_INITIAL [A-Z]"."(" "[A-Z]".")?
LAST_NAME ("Mc")?[A-Z][a-z]+([-][a-zA-Z]+)?(" et al,")?
WS [ \t]
LPAREN "("
RPAREN ")"
YEAR (18|19|20){DIGIT}{2}
PAGE_NO "pp."{WS}*{DIGIT}+({HYPHEN}{DIGIT}+)?
HYPHEN "-"
NOT_WS [^{WS}]
JRNL "Physical Review"|"Nature Communications"
PAPER "arXiv:"[0-9]{4}"."[0-9]{4}
TEXT [a-zA-Z :]+
COMMA ","
%x LEXER
%%

\\bibitem { BEGIN(LEXER) ; }

<LEXER>{LBRACKET}{DIGIT}+{RBRACKET} { printf("\n\nID:%s\n",yytext);}
<LEXER>{FIRST_INITIAL}{WS}+({MIDDLE_INITIAL}{WS}+)?{LAST_NAME} { printf("NAME:%s\n",yytext);}
<LEXER>{LPAREN}({TEXT}{COMMA}{WS}*)?{YEAR}{RPAREN}	{ printf("year:%s\n\n",yytext);}
<LEXER>{JRNL} { printf("journal:%s\n",yytext);}
<LEXER>{PAPER} { printf("paper:%s\n",yytext);}
<LEXER>. { printf("%s",yytext); }

[ ]+"arXiv," { BEGIN(arxiv); }
<arxiv>[ ]+ ; 
<arxiv>{LPAREN}{YEAR}{RPAREN}{WS}* { printf("year:%s\n",yytext);}
<arxiv>[0-9]{4}"."[0-9]{4} { printf("paper:arXiv:%s",yytext); BEGIN(0); }



<bibitem>"["{NOT_WS}+"]""{"{NOT_WS}+"}" { printf("bibitem:%s",yytext);}
<bibitem>^[^\\]newblock { BEGIN 0; printf("bibitem:%s",yytext);}
\\newblock.* { printf("%s",yytext);}

. ;
\n	;



%%

int
main(int argc, char* argv[]){
	yyin = fopen(argv[1],"r");
	yylex();
	return 0;
}
