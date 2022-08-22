%{
#include "globals.h"
%}
%option header="keywords.h"
%option prefix="Keywords_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x KEYWORDS
%%

\\newcommand.* ;
\\def.*	;

"\\keywords"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(KEYWORDS);
}

<KEYWORDS>"{" { yymore(); balanced--;}
<KEYWORDS>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<KEYWORDS>. { yymore(); }
<KEYWORDS>\n { yymore(); }

.	;
\n	;
%%
