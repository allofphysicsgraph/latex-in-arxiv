%{
unsigned charCount = 0, wordCount = 0, lineCount = 1;
int bal_parens = 0;
int offset=1;
int add_word(int type, char *word);
int lookup_word(char *word,int print);
void update_word(char *word);
char* auth;
int count_chars;

int lookup_word_by_word_type(int type,int print);

enum {
	LOOKUP = 0, /* default - looking rather than defining. */

/*
1:[a-zA-Z]+
2:latex author
3:latex citet
4:latex cite
5:latex citep
6:latex footnote
*/


/*
\\documentclass
\\usepackage
\\renewcommand
\\newcommand
\\title
\\date
\\begin"{document}"
\\maketitle
\\begin"{abstract}"
\\section
\\begin"{figure}"
\\figref
\\subsection
\\appendix
\\appref
\\bibliography
\\bibliographystyle
\\caption
\\centering
\\label
*/

};
%}

%s author
%s citet
%s cite
%s citep
%s footnote
%s appendix
%s appref
%s begin_abstract
%s begin_document
%s begin_figure
%s bibliography
%s bibliographystyle
%s caption
%s centering
%s date
%s documentclass
%s figref
%s label
%s maketitle
%s newcommand
%s renewcommand
%s section
%s subsection
%s title
%s usepackage


word [a-zA-Z]+
eol  \n
%%

{word}	{ 
	wordCount++; charCount += yyleng; 
	int match = 0;
	match = lookup_word(yytext,0);
	if (match == 0){
		//printf("adding word:%s\n",yytext);
		add_word(1,yytext);
	} else {
		//printf("updating word:%s\n",yytext);
		update_word(yytext);
	}
	offset+= yyleng;
}


\\author     { 
	count_chars=yyleng; 
	BEGIN author; 
	}

<author>"{"  {
	count_chars++; 
	bal_parens++;
} 

<author>[^{}]+ {
	add_word(2,yytext);
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineCount++;}
		//printf("%c",yytext[i]);
	}}

<author>"}"	{ bal_parens--; 
	if(bal_parens == 0 ){
		count_chars++;
		BEGIN 0;
	}}


\\citet  { 
	count_chars=yyleng; 
	BEGIN citet; 
	}

<citet>"{"   {
	count_chars++; 
	bal_parens++;
} 

<citet>[^{}]+ {
	add_word(3,yytext);
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineCount++;}
		//printf("%c",yytext[i]);
	}}

<citet>"}" { bal_parens--; 
		if(bal_parens == 0 ){
			count_chars++;
			BEGIN 0;
		}
	}


\\cite  { 
	count_chars=yyleng; 
	BEGIN cite; 
	}

<cite>"{"   {
	count_chars++; 
	bal_parens++;
} 

<cite>[^{}]+ {
	add_word(4,yytext);
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineCount++;}
		//printf("%c",yytext[i]);
	}}

<cite>"}" { bal_parens--; 
		if(bal_parens == 0 ){
			count_chars++;
			BEGIN 0;
		}
	}



\\citep  { 
	count_chars=yyleng; 
	BEGIN citep; 
	}

<citep>"{"   {
	count_chars++; 
	bal_parens++;
} 

<citep>[^{}]+ {
	add_word(5,yytext);
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineCount++;}
		//printf("%c",yytext[i]);
	}}

<citep>"}" { bal_parens--; 
		if(bal_parens == 0 ){
			count_chars++;
			BEGIN 0;
		}
	}


\\footnote  {
	count_chars=yyleng; 
	BEGIN footnote; 
	}


<footnote>"{"  {
	count_chars++; 
	bal_parens++;
} 

<footnote>[^{}]+ {
	add_word(6,yytext);
	int i = 0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='\n'){lineCount++;}
		//printf("%c",yytext[i]);
	}}

<footnote>"}"	{ bal_parens--; 
		if(bal_parens == 0 ){
			count_chars++;
			BEGIN 0;
		}
	}




{eol}	{ 

	charCount++; lineCount++; offset=1; 
	
	}
.	{ 	
charCount++; offset++;
}


%%

int 
main(int argc,char **argv)
{
	if (argc < 3){
		printf("arg1: filename\narg2: word lookup\n");
		return 0;
		}


	if (argc > 1) {
		FILE *file;

		file = fopen(argv[1], "r");
		if (!file) {
			fprintf(stderr,"could not open %s\n",argv[1]);
			exit(1);
		}
		yyin = file;
	}
	yylex();

	lookup_word_by_word_type(2,1);

	//lookup_word(argv[2],1);
	printf("%s %d %s %d %s %d\n","Char Count: ",charCount, "Word Count: ",wordCount,"Line Count: ",lineCount);
	return 0;
}



/* define a linked list of words and types */
struct word {
	char *word_name;
	int word_type;
	int count;
	// Making the assumption that there are less than 10K instances of the same word.
	int lineCount[10000];
	int offset[10000];
	struct word *next;
};

struct word *word_list; /* first element in word list */
extern void *malloc();

int
add_word(int type, char *word)
{
	struct word *wp;	
	/* word not there, allocate a new entry and link it on the list */
	wp = (struct word *) malloc(sizeof(struct word));
	wp->next = word_list;
	/* have to copy the word itself as well */
	wp->word_name = (char *) malloc(strlen(word)+1);
	strcpy(wp->word_name, word);
	wp->word_type = type; //int data type
	wp->lineCount[0] = lineCount;
	wp->offset[0] = offset;
	wp->count = 1;
	word_list = wp;
	return 1;	/* it worked */
}

int
lookup_word(char *word,int print)
{
	struct word *wp = word_list;
	/* search down the list looking for the word */
	int i = 0;
	for(; wp; wp = wp->next) {
		if(strcmp(wp->word_name, word) == 0){
			for(i=0;i<(wp->count);i++){
				//printf("i:%d\n",i);
				//fixme?? not sure why lineCount is ever less than one
				if(wp->lineCount[i]>0){
					if(print != 0){
						printf("%s:line_no:%d:offset:%d\n",word,wp->lineCount[i],wp->offset[i]);
					}	
			}
			}
			return 1;
		}
	}
	return LOOKUP;	 /* not found */
}




int
lookup_word_by_word_type(int type,int print)
{
	struct word *wp = word_list;
	/* search down the list looking for the word */
	int i = 0;
	for(; wp; wp = wp->next) {
		if( wp->word_type == type){
			for(i=0;i<(wp->count);i++){
				//printf("i:%d\n",i);
				//fixme?? not sure why lineCount is ever less than one
				if(wp->lineCount[i]>0){
					if(print != 0){
						printf("%s:line_no:%d:offset:%d\n",wp->word_name,wp->lineCount[i],wp->offset[i]);
					}	
			}
			}
			return 1;
		}
	}
	return LOOKUP;	 /* not found */
}




void
update_word(char *word)
{
	//printf("updating word:%s\n",word);
	struct word *wp = word_list;
	/* search down the list looking for the word */
	for(; wp; wp = wp->next) {
		if(strcmp(wp->word_name, word) == 0)
			wp->lineCount[wp->count] = lineCount;
			wp->offset[wp->count] = offset;
			wp->count++;
	}
}

