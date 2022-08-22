%{
#include "globals.h"
char filename[256];
%}
%option header="author.h"
%option prefix="Author_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x AUTHOR
%%

\\newcommand.* ;
\\def.*	;

"\\author"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(AUTHOR);
}

<AUTHOR>"{" { yymore(); balanced--;}
<AUTHOR>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<AUTHOR>. { yymore(); }
<AUTHOR>\n { yymore(); }

.	;
\n	;
%%
