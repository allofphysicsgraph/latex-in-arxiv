%{
#include "globals.h"
%}
%option header="eqnarray.h"
%option prefix="Eqnarray_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x EQNARRAY
%%

"\\begin{eqnarray}" {
	yymore();
	balanced--;
	BEGIN(EQNARRAY);
}

<EQNARRAY>"\\begin{eqnarray}" { yymore(); balanced--;}
<EQNARRAY>"\\end{eqnarray}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<EQNARRAY>. { yymore(); }
<EQNARRAY>\n { yymore(); }

.	;
\n	;
%%

