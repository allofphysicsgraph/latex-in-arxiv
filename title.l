%{
int balanced;
int count;
%}

%x TITLE
%%

"\\title"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(TITLE);
}

<TITLE>"{" { yymore(); balanced--;}
<TITLE>"}" { balanced++; if(balanced){
		//printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TITLE>. { yymore(); }
<TITLE>\n { yymore(); }

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
