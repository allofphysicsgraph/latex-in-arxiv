%{
int balanced;
%}

%x AUTHOR
%%

"\\author{" {
	yymore();
	BEGIN(AUTHOR);
}

<AUTHOR>"{" { yymore(); balanced--;}
<AUTHOR>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		BEGIN(0);
	}}
<AUTHOR>. { yymore(); }

.	;
\n	;
%%

int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}
