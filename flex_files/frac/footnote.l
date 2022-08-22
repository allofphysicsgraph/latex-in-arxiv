%{
#include "globals.h"
%}
%option header="footnote.h"
%option prefix="Footnote_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x FOOTNOTE
%%

\\newcommand.* ;
\\def.*	;

"\\footnote"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(FOOTNOTE);
}

<FOOTNOTE>"{" { yymore(); balanced--;}
<FOOTNOTE>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<FOOTNOTE>. { yymore(); }
<FOOTNOTE>\n { yymore(); }

.	;
\n	;
%%
