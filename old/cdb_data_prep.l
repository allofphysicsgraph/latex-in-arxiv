%{
#include <string.h>
char k[512];
char v[512];
int key_length;
int value_length;
%}
%x value
%%
[^\-]/[^>] { yymore(); }
"->"	{  
	memset(k,'\0',512);
	strncpy(k,yytext,yyleng-2);
	key_length=(yyleng-2);
	BEGIN(value); 
}

<value>[^\n]	{ yymore(); }
<value>\n	{ 
	memset(v,'\0',512);
	strncpy(v,yytext,yyleng-1);
	value_length=(yyleng-1);
	printf("+%d,%d:%s->%s\n",key_length,value_length,k,v);
	BEGIN(0); 
}
.	;
\n	;

%%

int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}
