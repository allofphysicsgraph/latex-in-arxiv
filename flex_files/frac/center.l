%{
#include "globals.h"
%}
%option header="center.h"
%option prefix="Center_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x CENTER
%%

"\\begin{center}" {
	yymore();
	balanced--;
	BEGIN(CENTER);
}

<CENTER>"\\begin{center}" { yymore(); balanced--;}
<CENTER>"\\end{center}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<CENTER>. { yymore(); }
<CENTER>\n { yymore(); }

.	;
\n	;
%%

