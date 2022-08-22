%{
#include "globals.h"
char results_filename[256];
int print_count;
int count;
%}
%option header="equation.h"
%option prefix="Equation_"
%option 8bit nounput nomain noyywrap noinput
%option warn stack noyy_top_state

%x EQUATION
%%

"\\begin{equation}" {
	yymore();
	balanced--;
	BEGIN(EQUATION);
}

<EQUATION>"\\begin{equation}" { yymore(); balanced--;}
<EQUATION>"\\end{equation}" { balanced++; if(balanced==0){
		fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<EQUATION>. { yymore(); }
<EQUATION>\n { yymore(); }

.	;
\n	;
%%

