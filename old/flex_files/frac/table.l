%{
#include "globals.h"
%}
%option header="table.h"
%option prefix="Table_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x TABLE
%%

"\\begin{table}" {
	yymore();
	balanced--;
	BEGIN(TABLE);
}

<TABLE>"\\begin{table}" { yymore(); balanced--;}
<TABLE>"\\end{table}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TABLE>. { yymore(); }
<TABLE>\n { yymore(); }

.	;
\n	;
%%

