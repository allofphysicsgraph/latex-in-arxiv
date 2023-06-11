%{
#include "globals.h"
%}
%option header="pacs.h"
%option prefix="Pacs_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x PACS
%%

\\newcommand.* ;
\\def.*	;

"\\pacs"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(PACS);
}

<PACS>"{" { yymore(); balanced--;}
<PACS>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<PACS>. { yymore(); }
<PACS>\n { yymore(); }

.	;
\n	;
%%
