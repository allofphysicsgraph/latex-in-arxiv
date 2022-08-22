%{
#include "globals.h"
%}
%option header="quotation.h"
%option prefix="Quotation_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x QUOTATION
%%

"\\begin{quotation}" {
	yymore();
	balanced--;
	BEGIN(QUOTATION);
}

<QUOTATION>"\\begin{quotation}" { yymore(); balanced--;}
<QUOTATION>"\\end{quotation}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<QUOTATION>. { yymore(); }
<QUOTATION>\n { yymore(); }

.	;
\n	;
%%

