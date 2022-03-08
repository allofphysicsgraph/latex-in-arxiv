/*
 * expr.lex : Scanner for a simple
 *            expression parser.
 */

%{
#include "expr.tab.h"

%}
INTEGER (0|[1-9][0-9]*)

%%

{INTEGER}     { yylval.integer = atoi(yytext);
             return(INTEGER);
           }

{INTEGER}\.{INTEGER}? { 
             sscanf(yytext,"%f",&yylval.rational);
             return(RATIONAL);
           }
"+"        return(PLUS);
"-"        return(MINUS);
"*"        return(MULT);
"/"        return(DIV);
"^"        return(EXPON);
"("        return(LB);
")"        return(RB);
\n         return(EOL);
[\t ]*     /* throw away whitespace */
.          { yyerror("Illegal character"); 
             return(EOL);
           }
%%



