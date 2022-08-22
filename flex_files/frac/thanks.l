%{
#include "globals.h"
%}
%option header="thanks.h"
%option prefix="Thanks_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x THANKS
%%

\\newcommand.* ;
\\def.*	;

"\\thanks"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(THANKS);
}

<THANKS>"{" { yymore(); balanced--;}
<THANKS>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<THANKS>. { yymore(); }
<THANKS>\n { yymore(); }

.	;
\n	;
%%
