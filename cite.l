%{
int balanced;
int count;
char filename[256];
%}

%x CITE
%%

"\\cite"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(CITE);
}

<CITE>"{" { yymore(); balanced--;}
<CITE>"}" { balanced++; if(balanced){
		printf("%s->%s\n",yytext,&filename[2]);
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
	memset(filename,'\0',256);
	if(strlen(argv[1])<256){
		strcpy(filename,argv[1]);
	} else {exit(-1);}

	yyin=fopen(argv[1],"r");
	yylex();
	memset(yytext,'\0',yyleng);
	printf("%d",count);
	return 0;
}