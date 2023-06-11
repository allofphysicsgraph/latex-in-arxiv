%{
#include "globals.h"
%}
%option header="verbatim.h"
%option prefix="Verbatim_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x VERBATIM
%%

"\\begin{verbatim}" {
	yymore();
	balanced--;
	BEGIN(VERBATIM);
}

<VERBATIM>"\\begin{verbatim}" { yymore(); balanced--;}
<VERBATIM>"\\end{verbatim}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<VERBATIM>. { yymore(); }
<VERBATIM>\n { yymore(); }

.	;
\n	;
%%

