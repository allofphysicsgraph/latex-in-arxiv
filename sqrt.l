%{
int balanced;
int count;
%}

%x SQRT
%%

"\\sqrt"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(SQRT);
}

<SQRT>"{" { yymore(); balanced--;}
<SQRT>"}" { balanced++; if(balanced){
		//printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<SQRT>. { yymore(); }
<SQRT>\n { yymore(); }

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
