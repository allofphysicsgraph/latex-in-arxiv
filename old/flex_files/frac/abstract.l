%{
#include "globals.h"
%}
%option header="abstract.h"
%option prefix="Abstract_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x ABSTRACT
%%

"\\begin{abstract}" {
	yymore();
	balanced--;
	BEGIN(ABSTRACT);
}

<ABSTRACT>"\\begin{abstract}" { yymore(); balanced--;}
<ABSTRACT>"\\end{abstract}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<ABSTRACT>. { yymore(); }
<ABSTRACT>\n { yymore(); }

.	;
\n	;
%%

