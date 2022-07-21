%{
int balanced;
int count;
%}

%x PACS
%%

"\\pacs"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(PACS);
}

<PACS>"{" { yymore(); balanced--;}
<PACS>"}" { balanced++; if(balanced){
		printf("%s\n",yytext);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<PACS>. { yymore(); }
<PACS>\n { yymore(); }

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
