%{
int balanced;
int count;
char filename[256];
int print_count;
%}

%x TITLE
%%

"\\title"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(TITLE);
}

<TITLE>"{" { yymore(); balanced--;}
<TITLE>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			printf("%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TITLE>. { yymore(); }
<TITLE>\n { yymore(); }

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
	if(strlen(argv[1])<256){
		strcpy(filename,argv[1]);
	} else {exit(-1);}

	yyin=fopen(argv[1],"r");
	yylex();
	if(argc==3 && strcmp(argv[2],"--count")==0){
		printf("%d",count);
	}
	return 0;
}
