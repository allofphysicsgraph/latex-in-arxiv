%{
#include "globals.h"
%}
%option header="displaymath.h"
%option prefix="Displaymath_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x DISPLAYMATH
%%

"\\begin{displaymath}" {
	yymore();
	balanced--;
	BEGIN(DISPLAYMATH);
}

<DISPLAYMATH>"\\begin{displaymath}" { yymore(); balanced--;}
<DISPLAYMATH>"\\end{displaymath}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<DISPLAYMATH>. { yymore(); }
<DISPLAYMATH>\n { yymore(); }

.	;
\n	;
%%

