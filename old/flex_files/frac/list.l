%{
#include "globals.h"
%}
%option header="list.h"
%option prefix="List_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x LIST
%%

"\\begin{list}" {
	yymore();
	balanced--;
	BEGIN(LIST);
}

<LIST>"\\begin{list}" { yymore(); balanced--;}
<LIST>"\\end{list}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<LIST>. { yymore(); }
<LIST>\n { yymore(); }

.	;
\n	;
%%

