%{

%}
%option header-file="find.h"
%option prefix="find"
%option nomain
%option noyywrap
%%


%%

int main(int argc, char** argv);

int main(int argc, char** argv){

	char cmd[512];
	memset(cmd,'\0',512);
	strcpy(cmd,"find ");
	strcat(cmd, argv[1]);	//path
	strcat(cmd," -type f");
	if (argc==3) {strcat(cmd," -name \"*."); strcat(cmd,argv[2]); strcat(cmd,"\"");} //filetype
 	findin=popen(cmd,"r");
	findlex();	
	return 0;
}
