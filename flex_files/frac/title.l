%{
#include "globals.h"
%}
%option header="title.h"
%option prefix="Title_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state


%x TITLE
%%

\\newcommand.* ;
\\def.*	;

"\\title"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(TITLE);
}

<TITLE>"{" { yymore(); balanced--;}
<TITLE>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<TITLE>. { yymore(); }
<TITLE>\n { yymore(); }

.	;
\n	;
%%
