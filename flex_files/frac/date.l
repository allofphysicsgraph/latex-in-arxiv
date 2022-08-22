%{
#include "globals.h"
%}
%option header="date.h"
%option prefix="Date_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x DATE
%%

\\newcommand.* ;
\\def.*	;

"\\date"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(DATE);
}

<DATE>"{" { yymore(); balanced--;}
<DATE>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<DATE>. { yymore(); }
<DATE>\n { yymore(); }

.	;
\n	;
%%
