%{
#include "globals.h"
%}
%option header="figure.h"
%option prefix="Figure_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x FIGURE
%%

"\\begin{figure}" {
	yymore();
	balanced--;
	BEGIN(FIGURE);
}

<FIGURE>"\\begin{figure}" { yymore(); balanced--;}
<FIGURE>"\\end{figure}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<FIGURE>. { yymore(); }
<FIGURE>\n { yymore(); }

.	;
\n	;
%%

