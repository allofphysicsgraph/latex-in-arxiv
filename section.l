%{
int balanced;
int count;
char filename[256];
%}

%x SECTION
%%

"\\begin{section}" {
	yymore();
	BEGIN(SECTION);
}

<SECTION>"\\begin{section}" { yymore(); balanced--;}
<SECTION>"\\end{section}" { balanced++; if(balanced){
		printf("%s->%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<SECTION>. { yymore(); }
<SECTION>\n { yymore(); }

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
	//printf("%d",count);
	return 0;
}
