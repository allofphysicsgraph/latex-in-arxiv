%{
#include "globals.h"
%}
%option header="tabbing.h"
%option prefix="Tabbing_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x TABBING
%%

"\\begin{tabbing}" {
	yymore();
	balanced--;
	BEGIN(TABBING);
}

<TABBING>"\\begin{tabbing}" { yymore(); balanced--;}
<TABBING>"\\end{tabbing}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TABBING>. { yymore(); }
<TABBING>\n { yymore(); }

.	;
\n	;
%%

