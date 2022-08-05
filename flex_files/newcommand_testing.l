%{
int delete_file=0;
char buffer[1000000];
char cmd[100];
//deleting files where newcommand.c has errors 

%}


%%
.	{ strcat(buffer,yytext); }
"Sorry - I expected a {}" { delete_file=1; }
"Problem at \"" { delete_file=1; }
"Sorry, a large expansion ran me out of space" { delete_file=1; }
\n	{ strcat(buffer,yytext); }
%%

int main(int argc, char** argv){
	memset(buffer,'\0',100000);
	memset(cmd,'\0',100);
	strcat(cmd,"cat  ");
	strcat(cmd,argv[1]);
	strcat(cmd, " | newcommand 2>&1");
	//printf("%s",cmd);

	yyin=popen(cmd,"r");
	yylex();
	if(delete_file ==1){
		printf("deleting file");
		memset(buffer,'\0',100000);
		strcat(buffer,"rm -rf ");
		strcat(buffer,argv[1]);
		//printf("%s",buffer);
		FILE *fp;
		fp=popen(buffer,"r");
		pclose(fp);
	}
	return 0;
}
