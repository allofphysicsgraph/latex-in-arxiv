%{
#include "globals.h"
%}
%option header="tabular.h"
%option prefix="Tabular_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x TABULAR
%%

"\\begin{tabular}" {
	yymore();
	balanced--;
	BEGIN(TABULAR);
}

<TABULAR>"\\begin{tabular}" { yymore(); balanced--;}
<TABULAR>"\\end{tabular}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TABULAR>. { yymore(); }
<TABULAR>\n { yymore(); }

.	;
\n	;
%%

