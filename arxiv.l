%{


int lineno = 1;
int bal_parens = 0;
enum {
	LOOKUP = 0,
	COMMENT,
	AUTHOR
};

int state;
int add_match(int type, char *results);
int lookup(char *results);
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
%s citet
%s citep
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
%s comment
%s ref
%s emph
%s url


%%

\\qquad	;
\\vspace"{".*?"}"	;

^"%"	{ BEGIN comment; }
<comment>.* { printf("commnet:lineno:%d:%s\n",lineno,yytext); BEGIN 0; }


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


\\url {bal_parens = 0; BEGIN url; printf("url:lineno:%d:%s",lineno,yytext);}
<url>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<url>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<url>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	} else {printf("%s",yytext);
}}


\\emph {bal_parens = 0; BEGIN emph; printf("emph:lineno:%d:%s",lineno,yytext);}
<emph>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<emph>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<emph>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	} else {printf("%s",yytext);
}}



\\ref {bal_parens = 0; BEGIN ref; printf("ref:lineno:%d:%s",lineno,yytext);}
<ref>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<ref>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<ref>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	} else {printf("%s",yytext);
}}


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
		printf("%s\n",yytext);
	} else {printf("%s",yytext);
}}


\\date     { BEGIN date; }
<date>.* { BEGIN 0; printf("date:lineno:%d:%s\n",lineno,yytext);}

\\begin"{document}"     { BEGIN begin_document; }
<begin_document>.* { BEGIN 0; printf("begin_document:lineno:%d:%s\n",lineno,yytext);}

\\maketitle     { BEGIN maketitle; }
<maketitle>.* { BEGIN 0; printf("maketitle:lineno:%d:%s\n",lineno,yytext);}

\\begin"{"abstract"}"     { BEGIN begin_abstract; printf("begin_abstract:lineno:%d\n",lineno,yytext); }
<begin_abstract>\n	{ printf("\n"); lineno++; }
<begin_abstract>.*	{ 
int i = 0 ;
for(i=0;i<yyleng;i++){
	if( (yyleng>(i+12)) && (yytext[i]=='\\') && (yytext[i+1]=='e') && 
	    (yytext[i+4]=='{') && (yytext[i+13]=='}') && (yytext[i+12]=='t') && (yytext[i+11]=='c') && 
	    (yytext[i+10]=='a')) {
            printf("\nend_abstract:lineno:%d\n",lineno); BEGIN 0;
} else {
	printf("%c",yytext[i]);
}}}







\\section     { BEGIN section; }
<section>.* { BEGIN 0; printf("section:lineno:%d:%s\n",lineno,yytext);}

\\begin"{figure}"     { BEGIN begin_figure; }
<begin_figure>.* { BEGIN 0; printf("begin_figure:lineno:%d:%s\n",lineno,yytext);}

\\citet  { BEGIN citet; printf("citet:lineno:%d",lineno); }
<citet>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<citet>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<citet>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	}}

\\citep  { BEGIN citet; printf("citep:lineno:%d",lineno); }
<citep>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<citep>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<citep>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	}}



\\cite  { BEGIN citet; printf("cite:lineno:%d",lineno); }
<cite>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<cite>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<cite>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	}}



	
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


\\footnote  { BEGIN citet; printf("footnote:lineno:%d",lineno); }
<footnote>"{"  { bal_parens++;
	printf("%s",yytext);
} 

<footnote>[^{}]+ {
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineno++;}
		printf("%c",yytext[i]);
	}}

<footnote>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		BEGIN 0; 
		printf("%s\n",yytext);
	}}


\\label     { BEGIN label; }
<label>.* { BEGIN 0; printf("label:lineno:%d:%s\n",lineno,yytext);}
\n	{ lineno++;}
.	;
%%
int main(int argc, char* argv[]){
	int match_found = 0;
	yyin = fopen(argv[1],"r");
	yylex();
	add_match(10,"hello");
	match_found = lookup("hello");
	printf("%d\n",match_found);
	return 0;
}

//lexandyacc.pdf///////////////////////////////
struct results {
	char *match;
	int match_type;
	struct results *next;
};

struct results *results_list;
extern void *malloc();

int add_match(int type, char* results){
	struct results *rp;
	rp = (struct results *) malloc(sizeof(struct results));
	rp->next = results_list;
	rp->match = (char *)malloc(strlen(results)+1);
	strcpy(rp->match, results);
	rp->match_type = type;
	results_list = rp;
	return 1;
}

int lookup(char *results){
	struct results *rp = results_list;
	for(; rp; rp = rp->next){
		if(strcmp(rp->match,results) == 0)
			{ return rp->match_type; }else {
			return 0;}}}
///////////////////////////////////////////
