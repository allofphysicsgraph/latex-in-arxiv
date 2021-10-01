%{
#include <wchar.h>
#include <locale.h>

void print_unicode(wchar_t unicode) {
    setlocale(LC_CTYPE, "");
    fwprintf(yyout, L"%lc", unicode);
}

%}

%option noyywrap
%option outfile="scanner.c" header-file="scanner.h"
%x italics title cite section begin_equation
%%
"\\noindent"	;
"\\maketitle"	;
"\\documentclass[aps,prl,groupedaddress,fleqn,twocolumn,10pt]{revtex4-1}" ;
"\\usepackage{"[a-z]+"}"	;
"%\\newcommand\\omicron{o}"	;
"\\begin{document}"	;
"\\raggedbottom"		;
"\\end{document}"	;

"\\cite{"	{ fprintf(yyout, "<cite>"); BEGIN(cite); }
<cite>[^}]	{ fprintf(yyout, "%c",yytext[0]); }
<cite>"}"	{ fprintf(yyout, "</cite>"); BEGIN(0); }

"\\title{"	{ fprintf(yyout, "<title>"); BEGIN(title); }
<title>[^}]	{ fprintf(yyout, "%c",yytext[0]); }
<title>"}"	{ fprintf(yyout, "</title>"); BEGIN(0); }

"\\section{"	{ fprintf(yyout, "<h3>"); BEGIN(section); }
<section>[^}]	{ fprintf(yyout, "%c",yytext[0]); }
<section>"}"	{ fprintf(yyout, "</h3>"); BEGIN(0); }


"{\\it"		{ fprintf(yyout, "<i>"); BEGIN(italics); }
<italics>[^}]	{ fprintf(yyout, "%c",yytext[0]); }
<italics>"}"	{ fprintf(yyout, "</i>"); BEGIN(0); }


"\\hbar"	{ fprintf(yyout,"&hbar;");}
"\\frac{3}{4}"  { char tmp[100]; memset(tmp,'\0',100); strcat(tmp,"&#x00BE;"); fprintf(yyout,tmp);  }
"\\frac{1}{2}"  { char tmp[100]; memset(tmp,'\0',100); strcat(tmp,"&half;"); fprintf(yyout,tmp);  }
\\alpha		{ char tmp[100]; memset(tmp,'\0',100); strcat(tmp,"&#x03B1"); fprintf(yyout,tmp);  }
\\omega		{ char tmp[100]; memset(tmp,'\0',100); strcat(tmp,"&#x03C9"); fprintf(yyout,tmp);  }
\\pi		{ char tmp[100]; memset(tmp,'\0',100); strcat(tmp,"&#x03C0"); fprintf(yyout,tmp);  }
\\rho		{ char tmp[100]; memset(tmp,'\0',100); strcat(tmp,"&#x03C1"); fprintf(yyout,tmp);  }





\n	{ fprintf(yyout,"<br>"); }

%%

