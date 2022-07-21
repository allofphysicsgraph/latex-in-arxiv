%{
int balanced;
int count;
%}

%x AUTHOR
%%

"\\author"[ ]{0,4}"{" {
	yymore();
	BEGIN(AUTHOR);
}

<AUTHOR>"{" { yymore(); balanced--;}
<AUTHOR>"}" { balanced++; if(balanced){
		//printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<AUTHOR>. { yymore(); }

.	;
\n	;
%%

int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	printf("%d",count);
	return 0;
}
