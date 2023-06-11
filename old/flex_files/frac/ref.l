%{
#include "globals.h"
%}
%option header="ref.h"
%option prefix="Ref_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x REF
%%

\\newcommand.* ;
\\def.*	;

"\\ref"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(REF);
}

<REF>"{" { yymore(); balanced--;}
<REF>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<REF>. { yymore(); }
<REF>\n { yymore(); }

.	;
\n	;
%%
