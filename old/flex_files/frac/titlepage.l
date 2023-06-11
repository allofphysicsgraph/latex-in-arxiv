%{
#include "globals.h"
%}
%option header="titlepage.h"
%option prefix="Titlepage_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x TITLEPAGE
%%

"\\begin{titlepage}" {
	yymore();
	balanced--;
	BEGIN(TITLEPAGE);
}

<TITLEPAGE>"\\begin{titlepage}" { yymore(); balanced--;}
<TITLEPAGE>"\\end{titlepage}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TITLEPAGE>. { yymore(); }
<TITLEPAGE>\n { yymore(); }

.	;
\n	;
%%

