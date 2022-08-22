%{
#include "globals.h"
%}
%option header="setcounter.h"
%option prefix="Setcounter_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x SETCOUNTER
%%

\\newcommand.* ;
\\def.*	;

"\\setcounter"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(SETCOUNTER);
}

<SETCOUNTER>"{" { yymore(); balanced--;}
<SETCOUNTER>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<SETCOUNTER>. { yymore(); }
<SETCOUNTER>\n { yymore(); }

.	;
\n	;
%%
