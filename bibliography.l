%{
int balanced;
int count;
%}

%x BIBLIOGRAPHY
%%

"\\bibliography"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(BIBLIOGRAPHY);
}

<BIBLIOGRAPHY>"{" { yymore(); balanced--;}
<BIBLIOGRAPHY>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<BIBLIOGRAPHY>. { yymore(); }
<BIBLIOGRAPHY>\n { yymore(); }

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
