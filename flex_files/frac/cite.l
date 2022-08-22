%{
#include "globals.h"
%}
%option header="cite.h"
%option prefix="Cite_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x CITE
%%

\\newcommand.* ;
\\def.*	;

"\\cite"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(CITE);
}

<CITE>"{" { yymore(); balanced--;}
<CITE>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<CITE>. { yymore(); }
<CITE>\n { yymore(); }

.	;
\n	;
%%
