%{
int balanced;
char numerator[2048];
char denominator[2048];
char output[8192];
%}

%x	NUMERATOR
%x 	DENOMINATOR
%%
"\\frac"|"\\tfrac"	{
			memset(numerator,'\0',2048);
			memset(denominator,'\0',2048); 
			memset(output,'\0',8192);
			strcpy(output,yytext);	
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
			printf("%s%s%s\n",output,numerator,denominator);
			printf("\n<NUMERATOR:%s>\n\n<DENOMINATOR:%s>\n",numerator,denominator);
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

	balanced=0;	
	yyin=fopen(argv[1],"r");
	yylex();
	return 0;
}
