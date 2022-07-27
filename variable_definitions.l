%{

%}

WORD ([A-Z][a-z]+|[a-z]+)("-"[a-z]+){0,2}
WS [ ]
LATEX "\$"[^\$]+"\$"

%%
"."[ ]+/([A-Z]|$)	{ printf("%s:::\n\n",yytext); }
"."/($|'\n')	{ printf("%s:::\n\n",yytext); }

"the"[ ]({WORD}({WS}|", "|",")){1,3}{LATEX} { printf("<:%s:>",yytext); }
"where"[ ]{LATEX}[ ]"is the "({WORD}{WS}){1,8} { printf("<:%s:>",yytext);}
"in terms of"[ ]({WORD}{WS}){2}{LATEX}","[ ] { printf("<:%s:>",yytext);} //need to check the rest of the sent
{LATEX}{WS}"is related to "(({WORD}{WS}){1,3}|{WORD}", "|{WORD}",") { printf("<:%s:>",yytext); }
%%


int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}
