%{


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

\\documentclass { BEGIN documentclass; }
<documentclass>.* { BEGIN 0; printf("documentclass:%s\n",yytext);}

\\usepackage     { BEGIN usepackage; }
<usepackage>.* { BEGIN 0; printf("usepackage:%s\n",yytext);}

\\renewcommand     { BEGIN renewcommand; }
<renewcommand>.* { BEGIN 0; printf("renewcommand:%s\n",yytext);}

\\newcommand     { BEGIN newcommand; }
<newcommand>.* { BEGIN 0; printf("newcommand:%s\n",yytext);}

\\title     { BEGIN title; }
<title>.* { BEGIN 0; printf("title:%s\n",yytext);}

\\author     { BEGIN author; }
<author>.* { BEGIN 0; printf("author:%s\n",yytext);}

\\date     { BEGIN date; }
<date>.* { BEGIN 0; printf("date:%s\n",yytext);}

\\begin"{document}"     { BEGIN begin_document; }
<begin_document>.* { BEGIN 0; printf("begin_document:%s\n",yytext);}

\\maketitle     { BEGIN maketitle; }
<maketitle>.* { BEGIN 0; printf("maketitle:%s\n",yytext);}

\\begin"{abstract}"     { BEGIN begin_abstract; }
<begin_abstract>.* { BEGIN 0; printf("begin_abstract:%s\n",yytext);}

\\section     { BEGIN section; }
<section>.* { BEGIN 0; printf("section:%s\n",yytext);}

\\begin"{figure}"     { BEGIN begin_figure; }
<begin_figure>.* { BEGIN 0; printf("begin_figure:%s\n",yytext);}

\\cite     { BEGIN cite; }
<cite>.* { BEGIN 0; printf("cite:%s\n",yytext);}
	
\\figref     { BEGIN figref; }
<figref>.* { BEGIN 0; printf("figref:%s\n",yytext);}
	
\\subsection     { BEGIN subsection; }
<subsection>.* { BEGIN 0; printf("subsection:%s\n",yytext);}

\\appendix     { BEGIN appendix; }
<appendix>.* { BEGIN 0; printf("appendix:%s\n",yytext);}

\\appref     { BEGIN appref; }
<appref>.* { BEGIN 0; printf("appref:%s\n",yytext);}

\\bibliography     { BEGIN bibliography; }
<bibliography>.* { BEGIN 0; printf("bibliography:%s\n",yytext);}

\\bibliographystyle     { BEGIN bibliographystyle; }
<bibliographystyle>.* { BEGIN 0; printf("bibliographystyle:%s\n",yytext);}

\\caption     { BEGIN caption; }
<caption>.* { BEGIN 0; printf("caption:%s\n",yytext);}

\\centering     { BEGIN centering; }
<centering>.* { BEGIN 0; printf("centering:%s\n",yytext);}

\\footnote     { BEGIN footnote; }
<footnote>.* { BEGIN 0; printf("footnote:%s\n",yytext);}

\\label     { BEGIN label; }
<label>.* { BEGIN 0; printf("label:%s\n",yytext);}


%%
int main(int argc, char* argv[]){
	yyin = fopen(argv[1],"r");
	return 0;
}
