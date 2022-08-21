%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int balanced;
char numerator[4096];
char denominator[4096];
char output[8192];
char filename[256];
char results_filename[256];
%}

%option header="base_flex.h"
%option prefix="Frac_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x	NUMERATOR
%x 	DENOMINATOR
%%
"\\frac{"|"\\tfrac{"	{
			memset(numerator,'\0',4096);
			memset(denominator,'\0',4096); 
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
			fprintf(Frac_out,"%s%s%s<T_SPLIT>%s\n",output,numerator,denominator,filename);
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

