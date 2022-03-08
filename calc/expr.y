/*
 * rational_expr.y : A simple yacc rational_expression parser
 *          Based on the Bison manual example. 
 */

%{
#include <stdio.h>
#include <math.h>

void yyerror(char *message);

%}

%union {
   float rational;
   int   integer;
}

%token RATIONAL
%token INTEGER
%token PLUS MINUS MULT DIV EXPON
%token EOL
%token LB RB

%left  MINUS PLUS
%left  MULT DIV
%right EXPON

%type  <rational> rational_exp RATIONAL
%type  <integer> integer_exp INTEGER

%%
input   :
        | input line
        ;

line    : EOL
        | rational_exp EOL { printf("rational:%g\n",$1);}
        | integer_exp EOL { printf("integer:%d\n",$1);}
	;

rational_exp     : RATIONAL                 { $$ = $1;        }
        | rational_exp PLUS  rational_exp          { $$ = $1 + $3;   }
        | rational_exp MINUS rational_exp          { $$ = $1 - $3;   }
        | rational_exp MULT  rational_exp          { $$ = $1 * $3;   }
        | rational_exp DIV   rational_exp          { $$ = $1 / $3;   }
        | MINUS  rational_exp %prec MINUS { $$ = -$2;       }
        | rational_exp EXPON rational_exp          { $$ = pow($1,$3);}
        | LB rational_exp RB                      { $$ = $2;        }
        ;


integer_exp     : INTEGER                 { $$ = $1;        }
        | integer_exp PLUS  integer_exp          { $$ = $1 + $3;   }
        | integer_exp MINUS  integer_exp          { $$ = $1 - $3;   }
        | integer_exp MULT  integer_exp          { $$ = $1 * $3;   }
        | MINUS  integer_exp %prec MINUS { $$ = -$2;       }
        | integer_exp EXPON integer_exp          { $$ = pow($1,$3);}
        | LB integer_exp RB                      { $$ = $2;        }
        ;
%%

void yyerror(char *message)
{
  printf("%s\n",message);
}

int main(int argc, char *argv[])
{
  yyparse();
  return(0);
}








