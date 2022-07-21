%{
int balanced;
int count;
%}

%x DATE
%%

"\\date"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(DATE);
}

<DATE>"{" { yymore(); balanced--;}
<DATE>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<DATE>. { yymore(); }
<DATE>\n { yymore(); }

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
