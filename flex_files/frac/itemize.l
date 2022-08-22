%{
#include "globals.h"
%}
%option header="itemize.h"
%option prefix="Itemize_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x ITEMIZE
%%

"\\begin{itemize}" {
	yymore();
	balanced--;
	BEGIN(ITEMIZE);
}

<ITEMIZE>"\\begin{itemize}" { yymore(); balanced--;}
<ITEMIZE>"\\end{itemize}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<ITEMIZE>. { yymore(); }
<ITEMIZE>\n { yymore(); }

.	;
\n	;
%%

