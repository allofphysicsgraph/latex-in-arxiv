%{
#include "globals.h"
%}
%option header="minipage.h"
%option prefix="Minipage_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x MINIPAGE
%%

"\\begin{minipage}" {
	yymore();
	balanced--;
	BEGIN(MINIPAGE);
}

<MINIPAGE>"\\begin{minipage}" { yymore(); balanced--;}
<MINIPAGE>"\\end{minipage}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<MINIPAGE>. { yymore(); }
<MINIPAGE>\n { yymore(); }

.	;
\n	;
%%

