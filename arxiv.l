%{


int lineno = 1;
int bal_parens = 0;
%}

%s appendix
%s appref
%s author
%s begin_abstract
%s begin_document
%s begin_figure
%s bibliography
%s bibliographystyle
%s caption
%s centering
%s cite
%s date
%s documentclass
%s figref
%s footnote
%s label
%s maketitle
%s newcommand
%s renewcommand
%s section
%s subsection
%s title
%s usepackage

%%

\\qquad	;

\\documentclass { BEGIN documentclass; }
<documentclass>.* { BEGIN 0; printf("documentclass:lineno:%d:%s\n",lineno,yytext);}

\\usepackage     { BEGIN usepackage; }
<usepackage>.* { BEGIN 0; printf("usepackage:lineno:%d:%s\n",lineno,yytext);}

\\renewcommand     { BEGIN renewcommand; }
<renewcommand>.* { BEGIN 0; printf("renewcommand:lineno:%d:%s\n",lineno,yytext);}

\\newcommand     { BEGIN newcommand; }
<newcommand>.* { BEGIN 0; printf("newcommand:lineno:%d:%s\n",lineno,yytext);}

\\title     { BEGIN title; }
<title>.* { BEGIN 0; printf("title:lineno:%d:%s\n",lineno,yytext);}

\\author     { BEGIN author; printf("author:lineno:%d:%s",lineno,yytext);}
<author>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<author>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<author>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s",yytext);
	}}


\\date     { BEGIN date; }
<date>.* { BEGIN 0; printf("date:lineno:%d:%s\n",lineno,yytext);}

\\begin"{document}"     { BEGIN begin_document; }
<begin_document>.* { BEGIN 0; printf("begin_document:lineno:%d:%s\n",lineno,yytext);}

\\maketitle     { BEGIN maketitle; }
<maketitle>.* { BEGIN 0; printf("maketitle:lineno:%d:%s\n",lineno,yytext);}

\\begin"{abstract}"     { BEGIN begin_abstract; }
<begin_abstract>.* { BEGIN 0; printf("begin_abstract:lineno:%d:%s\n",lineno,yytext);}

\\section     { BEGIN section; }
<section>.* { BEGIN 0; printf("section:lineno:%d:%s\n",lineno,yytext);}

\\begin"{figure}"     { BEGIN begin_figure; }
<begin_figure>.* { BEGIN 0; printf("begin_figure:lineno:%d:%s\n",lineno,yytext);}

\\cite     { BEGIN cite; }
<cite>.* { BEGIN 0; printf("cite:lineno:%d:%s\n",lineno,yytext);}
	
\\figref     { BEGIN figref; }
<figref>.* { BEGIN 0; printf("figref:lineno:%d:%s\n",lineno,yytext);}
	
\\subsection     { BEGIN subsection; }
<subsection>.* { BEGIN 0; printf("subsection:lineno:%d:%s\n",lineno,yytext);}

\\appendix     { BEGIN appendix; }
<appendix>.* { BEGIN 0; printf("appendix:lineno:%d:%s\n",lineno,yytext);}

\\appref     { BEGIN appref; }
<appref>.* { BEGIN 0; printf("appref:lineno:%d:%s\n",lineno,yytext);}

\\bibliography     { BEGIN bibliography; }
<bibliography>.* { BEGIN 0; printf("bibliography:lineno:%d:%s\n",lineno,yytext);}

\\bibliographystyle     { BEGIN bibliographystyle; }
<bibliographystyle>.* { BEGIN 0; printf("bibliographystyle:lineno:%d:%s\n",lineno,yytext);}

\\caption     { BEGIN caption; }
<caption>.* { BEGIN 0; printf("caption:lineno:%d:%s\n",lineno,yytext);}

\\centering     { BEGIN centering; }
<centering>.* { BEGIN 0; printf("centering:lineno:%d:%s\n",lineno,yytext);}

\\footnote     { BEGIN footnote; }
<footnote>.* { BEGIN 0; printf("footnote:lineno:%d:%s\n",lineno,yytext);}

\\label     { BEGIN label; }
<label>.* { BEGIN 0; printf("label:lineno:%d:%s\n",lineno,yytext);}
\n	{ lineno++;}
.	;
%%
int main(int argc, char* argv[]){
	yyin = fopen(argv[1],"r");
	yylex();
	return 0;
}
