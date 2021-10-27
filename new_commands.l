%{
int balanced=0;
int lbrace_count=0;
int rbrace_count=0;
char cmd[100];
char replacement[100];

%}
%x newcommand def
%%

\\newcommand {
	memset(cmd,'\0',100); memset(replacement,'\0',100);  BEGIN(newcommand); }
<newcommand>"{" {  yymore(); balanced--; lbrace_count++; }

<newcommand>"}" { balanced++; rbrace_count++; 
		if( (balanced==0) && ( rbrace_count>=2 )){
			strncpy(replacement,&yytext[1],(yyleng-2));
			printf("\"%s\"[^a-zA-Z]\t\{ printf\(\"%s\"); }\n",cmd,replacement);
			lbrace_count=0;
			rbrace_count=0;
			BEGIN(0);
		} else {
			if ((balanced==0) && (rbrace_count==1)){
				strncpy(cmd,&yytext[1],(yyleng-2));
			} else {
				yymore();
			  }
		}
}
<newcommand>.	{ yymore();}

\\def {
	memset(cmd,'\0',100); memset(replacement,'\0',100);  BEGIN(def); }
<def>"{" {  yymore(); balanced--; lbrace_count++; }

<def>"}" { balanced++; rbrace_count++; 
		if( (balanced==0) && ( rbrace_count>=2 )){
			strncpy(replacement,&yytext[1],(yyleng-2));
			printf("\"%s\"[^a-zA-Z]\t\{ printf\(\"%s\"); }\n",cmd,replacement);
			lbrace_count=0;
			rbrace_count=0;
			BEGIN(0);
		} else {
			if ((balanced==0) && (rbrace_count==1)){
				strncpy(cmd,&yytext[1],(yyleng-2));
			} else {
				yymore();
			  }
		}
}
<def>.	{ yymore();}

.	;
\n	;
%%


int main(int argc, char* argv[]){
	if(argc!=2) { 
		printf("argv[1]=filename to lex");
		return -1;	
	}
	printf("%{\n\n%}\n\n%%%%\n\n");
	yyin=fopen(argv[1],"r");
	yylex();
	printf("\n\n%%%%\n\n");
	printf("int main(int argc, char* argv[]){\n");
	printf("\tif(argc!=2) {\n"); 
	printf("\t\tprintf(\"argv[1]=filename to lex\");\n");
	printf("\t\treturn -1;\n");	
	printf("\t}\n");
	printf("\n\t return 0;\n}\n\n");
	return 0;
}
