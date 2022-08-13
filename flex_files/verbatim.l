%{
int balanced;
int count;
char filename[256];
char results_filename[256];
int print_count;
%}

%x VERBATIM
%%

"\\begin{verbatim}" {
	yymore();
	balanced--;
	BEGIN(VERBATIM);
}

<VERBATIM>"\\begin{verbatim}" { yymore(); balanced--;}
<VERBATIM>"\\end{verbatim}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<VERBATIM>. { yymore(); }
<VERBATIM>\n { yymore(); }

.	;
\n	;
%%

int main(int argc, char** argv){
	//argument 1, filename, required
	//argument 2, count only, optional
	if(argc==3 && strcmp(argv[2],"--count")==0){
		print_count=1;
	}
	memset(filename,'\0',256);
	memset(results_filename,'\0',256);
	if(strlen(argv[1])<256){
		strcpy(filename,argv[1]);
	} else {exit(-1);}
	strncpy(results_filename,argv[0],strlen(argv[0])-4); //remove the file extension
	strcat(results_filename,".csv");
	//printf("%s",results_filename);
	yyin=fopen(argv[1],"r");
	yyout=fopen(results_filename,"a+");
	yylex();
	if(argc==3 && strcmp(argv[2],"--count")==0){
		printf("%d",count);
	}
	return 0;

}
