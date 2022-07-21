%{
int balanced;
int count;
%}

%x KEYWORDS
%%

"\\keywords"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(KEYWORDS);
}

<KEYWORDS>"{" { yymore(); balanced--;}
<KEYWORDS>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<KEYWORDS>. { yymore(); }
<KEYWORDS>\n { yymore(); }

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
