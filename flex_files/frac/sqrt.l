%{
#include "globals.h"
%}
%option header="sqrt.h"
%option prefix="Sqrt_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x SQRT
%%

\\newcommand.* ;
\\def.*	;

"\\sqrt"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(SQRT);
}

<SQRT>"{" { yymore(); balanced--;}
<SQRT>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<SQRT>. { yymore(); }
<SQRT>\n { yymore(); }

.	;
\n	;
%%
