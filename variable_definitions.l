%{
//{COMMA}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{LATEX}
//"the"[ ]({WORD}({WS}|", "|",")){1,3}{LATEX} { printf("<:%s:>",yytext); }
//"The"[ ]({WORD}{WS}){4}"is "{LATEX}{COMMA} { printf("<:%s:>",yytext); }
//"in terms of"[ ]({WORD}{WS}){2}{LATEX}","[ ] { printf("<:%s:>",yytext);} //need to check the rest of the sent
%}
TITLE ([A-Z][a-z]+)
WORD ([a-z]+)("-"[a-z]+){0,2}
WS [ ]
LATEX "\$"[^\$]+"\$"
COMMA ","
THE "the"
AND "and"
IS "is"
WHERE "where"
EOS "."
FOR "for"
IN "in"
TERMS "terms"
COLON ":"
%%
"."[ ]+/([A-Z]|$)	{ printf("%s:::\n\n",yytext); }
"."/($|'\n')	{ printf("%s:::\n\n",yytext); }
{COMMA}{WS}{IN}{WS}{TERMS}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{LATEX}/{COMMA} {
	printf("<:%s:>",yytext);  
}
{TITLE}{WS}{WORD}{COMMA}{WS}{LATEX}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{AND}{WS}{WORD}{EOS} { printf("<:%s:>",yytext); }

{COMMA}{WS}{WORD}{WS}{LATEX}/{COMMA}
{
	printf("<:%s:>",yytext);  
}

{COMMA}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{THE}{WS}{WORD}{WS}{WORD}{WS}{LATEX}{WS}{AND}{WS}{THE}{WS}{WORD}{WS}{WORD}{WS}{LATEX}{COLON}{WS}{LATEX}/{COMMA} {

	printf("<:%s:>",yytext);  
}

{COMMA}{WS}{WORD}{WS}{LATEX}{COMMA}{WS}{AND}{WS}{TITLE}{WS}{WORD}{WS}{LATEX}
{
	printf("<:%s:>",yytext);  

}
{COMMA}{WS}{WHERE}{WS}{LATEX}/{COMMA} { printf("<:%s:>",yytext);  }
{COMMA}{WS}{LATEX}{WS}{IS}{WS}{THE}{WS}{WORD}{WS}{WORD}/{COMMA} { printf("<:%s:>",yytext);  } 
{TITLE}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{IS}{WS}{LATEX}/{COMMA} { printf("<:%s:>",yytext);  }
{COMMA}{WS}{THE}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{LATEX} { printf("<:%s:>",yytext); }
{AND}{WS}{THE}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{LATEX} { printf("<:%s:>",yytext); }
{THE}{WS}{WORD}{WS}{WORD}{WS}{FOR}{WS}{THE}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{IN}{WS}{WORD}{WS}{WORD}{COMMA}{WS}{LATEX} {

	printf("<:%s:>",yytext);   
}
{TITLE}{WS}{WORD}{WS}{WORD}{WS}{LATEX}/{COMMA} {
	printf("<:%s:>",yytext);   
}
{COMMA}{WS}{WHERE}{WS}{LATEX}{WS}{IS}{WS}{THE}{WS}({WORD}{WS}){4}{WORD}{EOS} { 
	printf("<:%s:>",yytext);  
} 

{COMMA}{WS}{AND}{WS}{LATEX}{WS}{IS}{WS}{THE}{WS}{WORD} { 
	printf("<:%s:>",yytext);  

}
{WHERE}{WS}{LATEX}{WS}{AND}{WS}{LATEX}{WS}{WORD}{WS}{WORD}{WS}{WORD}{WS}{AND}{WS}{WORD} {
	printf("<:%s:>",yytext);  

}

{LATEX}{WS}{IS}{WS}{THE}{WS}{WORD}{WS}{WORD} {

	printf("<:%s:>",yytext);  
}

{LATEX}{WS}"is related to "(({WORD}{WS}){1,3}|{WORD}", "|{WORD}",") { printf("<:%s:>",yytext); }

{COMMA}{WS}{AND}{WS}{WORD}{WS}{WORD}{WS}{LATEX}  {
	printf("<:%s:>",yytext);  
}

"where"[ ]{LATEX}[ ]"is the "({WORD}{WS}){1,9} { printf("<:%s:>",yytext);}
%%


int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}
