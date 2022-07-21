%{
int balanced;
int count;
%}

%x AFFILIATION
%%

"\\affiliation"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(AFFILIATION);
}

<AFFILIATION>"{" { yymore(); balanced--;}
<AFFILIATION>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<AFFILIATION>. { yymore(); }
<AFFILIATION>\n { yymore(); }

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
