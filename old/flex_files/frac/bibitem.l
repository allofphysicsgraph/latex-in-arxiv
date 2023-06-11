%{
#include "globals.h"
%}
%option header="bibitem.h"
%option prefix="Bibitem_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x BIBITEM EOS
%%

"\\bibitem"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(BIBITEM);
}

<BIBITEM>"{" { yymore(); balanced--;}
<BIBITEM>"}" { balanced++; if(balanced==0){
		BEGIN(EOS);
	} else { 
		yymore();
	}
}
<BIBITEM>. { yymore(); }
<BIBITEM>\n { yymore(); }
<EOS>"\\bibitem"([ ]{0,4}|\n)"{" { 
	count++; 
	yymore();
	balanced--;
	BEGIN(BIBITEM);
}
<EOS>\n\n {
			count++; 
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename); 
}
<EOS>\n {
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename); 

}
<EOS>\\end\{thebibliography\}	{ BEGIN(0); }

<EOS>. { yymore(); }

.	;
\n	;
%%

