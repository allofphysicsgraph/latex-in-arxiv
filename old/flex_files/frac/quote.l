%{
#include "globals.h"
%}
%option header="quote.h"
%option prefix="Quote_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x QUOTE
%%

"\\begin{quote}" {
	yymore();
	balanced--;
	BEGIN(QUOTE);
}

<QUOTE>"\\begin{quote}" { yymore(); balanced--;}
<QUOTE>"\\end{quote}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<QUOTE>. { yymore(); }
<QUOTE>\n { yymore(); }

.	;
\n	;
%%

