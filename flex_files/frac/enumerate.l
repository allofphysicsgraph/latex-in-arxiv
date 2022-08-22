%{
#include "globals.h"
%}
%option header="enumerate.h"
%option prefix="Enumerate_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x ENUMERATE
%%

"\\begin{enumerate}" {
	yymore();
	balanced--;
	BEGIN(ENUMERATE);
}

<ENUMERATE>"\\begin{enumerate}" { yymore(); balanced--;}
<ENUMERATE>"\\end{enumerate}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<ENUMERATE>. { yymore(); }
<ENUMERATE>\n { yymore(); }

.	;
\n	;
%%

