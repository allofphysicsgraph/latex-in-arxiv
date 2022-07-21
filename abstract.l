%{
int balanced;
int count;
%}

%x ABSTRACT
%%

"\\abstract"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(ABSTRACT);
}

<ABSTRACT>"{" { yymore(); balanced--;}
<ABSTRACT>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<ABSTRACT>. { yymore(); }
<ABSTRACT>\n { yymore(); }

.	;
\n	;
%%

int main(int argc, char** argv){
	yyin=fopen(argv[1],"r");
	yylex();
	memset(yytext,'\0',yyleng);
	printf("%d",count);
	return 0;
}
