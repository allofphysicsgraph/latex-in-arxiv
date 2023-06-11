%{
#include "globals.h"
%}
%option header="description.h"
%option prefix="Description_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x DESCRIPTION
%%

"\\begin{description}" {
	yymore();
	balanced--;
	BEGIN(DESCRIPTION);
}

<DESCRIPTION>"\\begin{description}" { yymore(); balanced--;}
<DESCRIPTION>"\\end{description}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<DESCRIPTION>. { yymore(); }
<DESCRIPTION>\n { yymore(); }

.	;
\n	;
%%

