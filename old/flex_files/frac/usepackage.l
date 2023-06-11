%{
#include "globals.h"
%}
%option header="usepackage.h"
%option prefix="Usepackage_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x USEPACKAGE
%%

\\newcommand.* ;
\\def.*	;

"\\usepackage"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(USEPACKAGE);
}

<USEPACKAGE>"{" { yymore(); balanced--;}
<USEPACKAGE>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<USEPACKAGE>. { yymore(); }
<USEPACKAGE>\n { yymore(); }

.	;
\n	;
%%
