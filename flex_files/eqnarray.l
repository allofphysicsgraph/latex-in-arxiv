%{
int balanced;
int count;
char filename[256];
%}

%x EQNARRAY
%%

"\\begin{eqnarray}" {
	yymore();
	balanced--;
	BEGIN(EQNARRAY);
}

<EQNARRAY>"\\begin{eqnarray}" { yymore(); balanced--;}
<EQNARRAY>"\\end{eqnarray}" { balanced++; if(balanced==0){
		printf("%s->%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<EQNARRAY>. { yymore(); }
<EQNARRAY>\n { yymore(); }

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
