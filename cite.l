%{
int balanced;
int count;
%}

%x CITE
%%

"\\cite"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(CITE);
}

<CITE>"{" { yymore(); balanced--;}
<CITE>"}" { balanced++; if(balanced){
		//printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<CITE>. { yymore(); }
<CITE>\n { yymore(); }

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
