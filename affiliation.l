%{
int balanced;
int count;
char filename[256];
%}

%x AFFILIATION
%%

"\\affiliation"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(AFFILIATION);
}

<AFFILIATION>"{" { yymore(); balanced--;}
<AFFILIATION>"}" { balanced++; if(balanced==0){
		printf("%s->%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<AFFILIATION>. { yymore(); }
<AFFILIATION>\n { yymore(); }

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
	//printf("%d",count);
	return 0;
}
