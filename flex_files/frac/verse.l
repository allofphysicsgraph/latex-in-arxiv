%{
#include "globals.h"
%}
%option header="verse.h"
%option prefix="Verse_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x VERSE
%%
\\newcommand.*	;

"\\begin{verse}" {
	yymore();
	balanced--;
	BEGIN(VERSE);
}

<VERSE>"\\begin{verse}" { yymore(); balanced--;}
<VERSE>"\\end{verse}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<VERSE>. { yymore(); }
<VERSE>\n { yymore(); }

.	;
\n	;
%%

