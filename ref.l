%{
int balanced;
int count;
char filename[256];
%}

%x REF
%%

"\\ref"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(REF);
}

<REF>"{" { yymore(); balanced--;}
<REF>"}" { balanced++; if(balanced){
		printf("%s->%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<REF>. { yymore(); }
<REF>\n { yymore(); }

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
	return 0;
}
