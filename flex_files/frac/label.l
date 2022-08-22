%{
#include "globals.h"
%}
%option header="label.h"
%option prefix="Label_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x LABEL
%%

\\newcommand.* ;
\\def.*	;

"\\label"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(LABEL);
}

<LABEL>"{" { yymore(); balanced--;}
<LABEL>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<LABEL>. { yymore(); }
<LABEL>\n { yymore(); }

.	;
\n	;
%%
