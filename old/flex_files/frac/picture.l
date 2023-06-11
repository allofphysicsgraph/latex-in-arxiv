%{
#include "globals.h"
%}
%option header="picture.h"
%option prefix="Picture_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x PICTURE
%%

"\\begin{picture}" {
	yymore();
	balanced--;
	BEGIN(PICTURE);
}

<PICTURE>"\\begin{picture}" { yymore(); balanced--;}
<PICTURE>"\\end{picture}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<PICTURE>. { yymore(); }
<PICTURE>\n { yymore(); }

.	;
\n	;
%%

