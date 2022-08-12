%{
int balanced;
char numerator[2048];
char denominator[2048];
char output[8192];
char filename[256];

char filename[256];
char results_filename[256];
%}

%x	NUMERATOR
%x 	DENOMINATOR
%%
"\\frac{"|"\\tfrac{"	{
			memset(numerator,'\0',2048);
			memset(denominator,'\0',2048); 
			memset(output,'\0',8192);
			strcpy(output,yytext);	
			balanced--;
			BEGIN(NUMERATOR); 
}
<NUMERATOR>"{"	{ 
			balanced--; 
			strcat(numerator,yytext);
} 
<NUMERATOR>"}"	{ 
			balanced++; 
			strcat(numerator,yytext);
			if(balanced==0){
				BEGIN(DENOMINATOR);	
			} else { 
				strcat(numerator,yytext);
			 }
		}

<NUMERATOR>'\n' {
		strcat(numerator,yytext);
}

<NUMERATOR>. {
		strcat(numerator,yytext);
 }

<DENOMINATOR>"{" { 
		balanced--;  
		strcat(denominator,yytext);
}

<DENOMINATOR>"}"	{ 
			balanced++; 
			strcat(denominator,yytext);
			if(balanced==0){
			fprintf(yyout,"%s%s%s<T_SPLIT>%s\n",output,numerator,denominator,filename);
			BEGIN(0);	
	} else { 
		strcat(denominator,yytext);
}}
<DENOMINATOR>'\n' {  
		strcat(denominator,yytext);
}
<DENOMINATOR>. { 
	strcat(denominator,yytext); 
}
.	;
\n	;
%%

int main(int argc, char** argv){
        //argument 1, filename, required
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
        return 0;
}

