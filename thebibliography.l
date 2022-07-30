%{
int balanced;
int count;
char filename[256];
%}

%x THEBIBLIOGRAPHY
%%

"\\thebibliography"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(THEBIBLIOGRAPHY);
}

<THEBIBLIOGRAPHY>"{" { yymore(); balanced--;}
<THEBIBLIOGRAPHY>"}" { balanced++; if(balancedi==0){
		printf("%s->%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<THEBIBLIOGRAPHY>. { yymore(); }
<THEBIBLIOGRAPHY>\n { yymore(); }

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
