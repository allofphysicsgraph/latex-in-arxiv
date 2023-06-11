%{
#include "globals.h"
%}
%option header="section.h"
%option prefix="Section_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x SECTION
%%

\\newcommand.* ;
\\def.*	;

"\\section"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(SECTION);
}

<SECTION>"{" { yymore(); balanced--;}
<SECTION>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<SECTION>. { yymore(); }
<SECTION>\n { yymore(); }

.	;
\n	;
%%
