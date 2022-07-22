%{
int balanced;
int count;
char filename[256];
%}

%x PACS
%%

"\\pacs"([ ]{0,4}|\n)"{" {
	yymore();
	BEGIN(PACS);
}

<PACS>"{" { yymore(); balanced--;}
<PACS>"}" { balanced++; if(balanced){
		printf("%s->%s\n",yytext,filename);
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
	memset(filename,'\0',256);
	if(strlen(argv[1])<256){
		strcpy(filename,argv[1]);
	} else {exit(-1);}

	yyin=fopen(argv[1],"r");
	yylex();
	//printf("%d",count);
	return 0;
}
