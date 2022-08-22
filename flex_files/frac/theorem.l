%{
#include "globals.h"
%}
%option header="theorem.h"
%option prefix="Theorem_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x THEOREM
%%

"\\begin{theorem}" {
	yymore();
	balanced--;
	BEGIN(THEOREM);
}

<THEOREM>"\\begin{theorem}" { yymore(); balanced--;}
<THEOREM>"\\end{theorem}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<THEOREM>. { yymore(); }
<THEOREM>\n { yymore(); }

.	;
\n	;
%%

