%{
int balanced;
%}

%x CITE
%%

"\\cite"[ ]{0,4}"{" {
	yymore();
	BEGIN(CITE);
}

<CITE>"{" { yymore(); balanced--;}
<CITE>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		BEGIN(0);
	} else { 
		yymore();
	}
}
<CITE>. { yymore(); }

.	;
\n	;
%%

int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}
