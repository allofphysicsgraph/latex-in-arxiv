%{

#include "words.h"
#include "file_utils.h"
#include "enum.h"
#include <err.h>
#include "EVP_MD.h"

int bal_parens=0;

void consume_until_balanced(char *buf,int buf_len, char start_delimiter, char stop_delimiter);
void consume_until_match(char * stop_word);

int wordCount = 0;
int charCount = 0;
int fileCount = 0;
int stateCount = 0;

int beginbalanced = 0;

int temp_buffer_index=0;
char temp_buffer[10000];

#define MAX_FILE_COUNT 10000
%}

%s shit  math affiliation newtheorem delta  epsfig  date  title dfrac  email  ion  stackrel  providecommand  centerline  mathscr  oalign  mathit  mfrak  setlength  operatorname  subsubsection  set  check  includegraphics  citeauthoryear  mathsf  mathfrak  multicolumn  cal  hbox  colhead  hspace  dot  citenamefont  special  ket  ensuremath  citep  citet  widehat  caption  subsection  widetilde  mbox  section  mathbf  ref eqref  overline  mathbb  emph  hat  mathrm  sqrt  mathcal  cite  label  end 


word [a-z]+ 

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


\\begin"{equation}" { BEGIN(shit); }
<shit>.{1,13} { printf("%s",yytext); } 
<shit>\\end"{equation}" { printf("stopping"); BEGIN(0); }


\\email    { printf("\\email"); BEGIN(email); }
<email>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                consume_until_balanced(buf,1000,'{','}');
                printf("{%s\n",buf);
		BEGIN(0);
        }



\\affiliation    { printf("\\affiliation"); BEGIN(affiliation); }
<affiliation>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                consume_until_balanced(buf,1000,'{','}');
                printf("{%s\n",buf);
		BEGIN(0);
        }

\\cite    { printf("\\cite"); BEGIN(cite); }
<cite>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                consume_until_balanced(buf,1000,'{','}');
                printf("{%s\n",buf);
		BEGIN(0);
        }


\\ref    { printf("\\ref"); BEGIN(ref); }
<ref>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                consume_until_balanced(buf,1000,'{','}');
                printf("{%s\n",buf);
		BEGIN(0);
        }

\\label    { printf("\n\\label"); BEGIN(label); }
<label>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                consume_until_balanced(buf,1000,'{','}');
                printf("{%s\n",buf);
		BEGIN(0);
        }


\\emph    { printf("\\emph"); BEGIN(emph); }
<emph>"{" {
                char buf[1000];
                memset(buf,'\0',1000);
                consume_until_balanced(buf,1000,'{','}');
                printf("{%s\n",buf);
		BEGIN(0);
        }





\\subsection	{ printf("\\subsection"); BEGIN(title); }
<subsection>"{" {
		char buf[1000];
		memset(buf,'\0',1000);
		consume_until_balanced(buf,1000,'{','}');
		printf("{%s",buf);
	}
<subsection>"[" {
		char buf[1000];
		memset(buf,'\0',1000);
		consume_until_balanced(buf,1000,'[',']');
		printf("[%s",buf);
	}
<subsection>. { printf("\n"); BEGIN(0); }



\\title	{ printf("\\title"); BEGIN(title); }
<title>"{" {
		char buf[1000];
		memset(buf,'\0',1000);
		consume_until_balanced(buf,1000,'{','}');
		printf("{%s",buf);
	}
<title>"[" {
		char buf[1000];
		memset(buf,'\0',1000);
		consume_until_balanced(buf,1000,'[',']');
		printf("[%s",buf);
	}
<title>. { printf("\n"); BEGIN(0); }



\\newtheorem { printf("\n\\newtheorem"); BEGIN(newtheorem); }
<newtheorem>"{" {
		char buf[1000];
		memset(buf,'\0',1000);
		consume_until_balanced(buf,1000,'{','}');
		printf("{%s",buf);
	}
<newtheorem>"[" {
		char buf[1000];
		memset(buf,'\0',1000);
		consume_until_balanced(buf,1000,'[',']');
		printf("[%s",buf);
	}
<newtheorem>. { printf("\n\n"); BEGIN(0); }



\\delta:[ ]+    { BEGIN(delta); }
<delta>.*     { printf("delta:%s\n",yytext); BEGIN(0); }

\\epsfig:[ ]+    { BEGIN(epsfig); }
<epsfig>.*     { printf("epsfig:%s\n",yytext); BEGIN(0); }

\date:[ ]+    { BEGIN(date); }
<date>.*     { printf("date:%s\n",yytext); BEGIN(0); }

\\dfrac:[ ]+    { BEGIN(dfrac); }
<dfrac>.*     { printf("dfrac:%s\n",yytext); BEGIN(0); }

\\ion:[ ]+    { BEGIN(ion); }
<ion>.*     { printf("ion:%s\n",yytext); BEGIN(0); }

\\stackrel:[ ]+    { BEGIN(stackrel); }
<stackrel>.*     { printf("stackrel:%s\n",yytext); BEGIN(0); }

\\providecommand:[ ]+    { BEGIN(providecommand); }
<providecommand>.*     { printf("providecommand:%s\n",yytext); BEGIN(0); }


\\centerline:[ ]+    { BEGIN(centerline); }
<centerline>.*     { printf("centerline:%s\n",yytext); BEGIN(0); }

\\mathscr:[ ]+    { BEGIN(mathscr); }
<mathscr>.*     { printf("mathscr:%s\n",yytext); BEGIN(0); }


\\Eqref:[ ]+    { BEGIN(eqref); }
<eqref>.*     { printf("eqref:%s\n",yytext); BEGIN(0); }


\\mathit:[ ]+    { BEGIN(mathit); }
<mathit>.*     { printf("mathit:%s\n",yytext); BEGIN(0); }

\\mfrak:[ ]+    { BEGIN(mfrak); }
<mfrak>.*     { printf("mfrak:%s\n",yytext); BEGIN(0); }

\\setlength:[ ]+    { BEGIN(setlength); }
<setlength>.*     { printf("setlength:%s\n",yytext); BEGIN(0); }

\\operatorname:[ ]+    { BEGIN(operatorname); }
<operatorname>.*     { printf("operatorname:%s\n",yytext); BEGIN(0); }

\\set:[ ]+    { BEGIN(set); }
<set>.*     { printf("set:%s\n",yytext); BEGIN(0); }

\\check:[ ]+    { BEGIN(check); }
<check>.*     { printf("check:%s\n",yytext); BEGIN(0); }

\\includegraphics:[ ]+    { BEGIN(includegraphics); }
<includegraphics>.*     { printf("includegraphics:%s\n",yytext); BEGIN(0); }

\\citeauthoryear:[ ]+    { BEGIN(citeauthoryear); }
<citeauthoryear>.*     { printf("citeauthoryear:%s\n",yytext); BEGIN(0); }


\\mathsf:[ ]+    { BEGIN(mathsf); }
<mathsf>.*     { printf("mathsf:%s\n",yytext); BEGIN(0); }

\mathfrak:[ ]+    { BEGIN(mathfrak); }
<mathfrak>.*     { printf("mathfrak:%s\n",yytext); BEGIN(0); }

\\multicolumn:[ ]+    { BEGIN(multicolumn); }
<multicolumn>.*     { printf("multicolumn:%s\n",yytext); BEGIN(0); }


\\cal:[ ]+    { BEGIN(cal); }
<cal>.*     { printf("cal:%s\n",yytext); BEGIN(0); }


\\hbox:[ ]+    { BEGIN(hbox); }
<hbox>.*     { printf("hbox:%s\n",yytext); BEGIN(0); }

\\colhead:[ ]+    { BEGIN(colhead); }
<colhead>.*     { printf("colhead:%s\n",yytext); BEGIN(0); }

\\hspace:[ ]+    { BEGIN(hspace); }
<hspace>.*     { printf("hspace:%s\n",yytext); BEGIN(0); }

\\dot:[ ]+    { BEGIN(dot); }
<dot>.*     { printf("dot:%s\n",yytext); BEGIN(0); }

\\citenamefont:[ ]+    { BEGIN(citenamefont); }
<citenamefont>.*     { printf("citenamefont:%s\n",yytext); BEGIN(0); }

\\special:[ ]+    { BEGIN(special); }
<special>.*     { printf("special:%s\n",yytext); BEGIN(0); }

\\ket:[ ]+    { BEGIN(ket); }
<ket>.*     { printf("ket:%s\n",yytext); BEGIN(0); }

\\ensuremath:[ ]+    { BEGIN(ensuremath); }
<ensuremath>.*     { printf("ensuremath:%s\n",yytext); BEGIN(0); }

\\citet:[ ]+    { BEGIN(citet); }
<citet>.*     { printf("citet:%s\n",yytext); BEGIN(0); }

\\widehat:[ ]+    { BEGIN(widehat); }
<widehat>.*     { printf("widehat:%s\n",yytext); BEGIN(0); }


\\caption:[ ]+    { BEGIN(caption); }
<caption>.*     { printf("caption:%s\n",yytext); BEGIN(0); }



\\widetilde:[ ]+    { BEGIN(widetilde); }
<widetilde>.*     { printf("widetilde:%s\n",yytext); BEGIN(0); }

\\mbox:[ ]+    { BEGIN(mbox); }
<mbox>.*     { printf("mbox:%s\n",yytext); BEGIN(0); }

\\section:[ ]+    { BEGIN(section); }
<section>.*     { printf("section:%s\n",yytext); BEGIN(0); }

\\mathbf:[ ]+    { BEGIN(mathbf); }
<mathbf>.*     { printf("mathbf:%s\n",yytext); BEGIN(0); }

\\overline:[ ]+    { BEGIN(overline); }
<overline>.*     { printf("overline:%s\n",yytext); BEGIN(0); }

\\mathbb:[ ]+    { BEGIN(mathbb); }
<mathbb>.*     { printf("mathbb:%s\n",yytext); BEGIN(0); }

\\hat:[ ]+    { BEGIN(hat); }
<hat>.*     { printf("hat:%s\n",yytext); BEGIN(0); }

\\mathrm:[ ]+    { BEGIN(mathrm); }
<mathrm>.*     { printf("mathrm:%s\n",yytext); BEGIN(0); }

\\sqrt:[ ]+    { BEGIN(sqrt); }
<sqrt>.*     { printf("sqrt:%s\n",yytext); BEGIN(0); }

\\mathcal:[ ]+    { BEGIN(mathcal); }
<mathcal>.*     { printf("mathcal:%s\n",yytext); BEGIN(0); }





.	{ offset++; }
\n	{ lineCount++; offset=1; }
%%


int 
main(int argc,char **argv)
{
	
	//Max file count
	char *array[MAX_FILE_COUNT];
	int i = 0;
	int array_index=0;
	memset(array,0,sizeof(array));
	int r = walk_dir(".", "\\.tex$", WS_DEFAULT|WS_MATCHDIRS,array,array_index);
	switch(r) {
	case WALK_OK:		break;
	case WALK_BADIO:	err(1, "IO error");
	case WALK_BADPATTERN:	err(1, "Bad pattern");
	case WALK_NAMETOOLONG:	err(1, "Filename too long");
	default:
		err(1, "Unknown error?");
	}

	
	//print file matches
	for(i=0;i<MAX_FILE_COUNT;i++){	
		if(array[i] != 0){
			fileCount++;
			yyin=fopen(array[i],"r");
			yylex();
			printf("\nfile_match:%s\n",array[i]);
			file_md5(array[i]);
		}
	}
	

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
	lookup_word(argv[2],1);
	printf("\nfileCount:%d:\n",fileCount);
	return 0;
}

void consume_until_balanced(char *buf,int buf_len,char start_delimiter, char stop_delimiter)
{
		printf("balanced");
		int c;
		int index=0;
		memset(buf,'\0',buf_len);
		bal_parens--;
		while((c = input()) != 0)
		{

                    if ( c == EOF )
                        {
                        printf( "EOF " );
                        break;
                        }
		if(index<buf_len){
			buf[index]=c;
			index++;
		} else {
				printf("buffer passed was too small");
				break;	
		}

		offset++;
		if(c == '\n') { ++lineCount;}
		if(c == start_delimiter)  { bal_parens--; }
		if(c == stop_delimiter)  { bal_parens++; }
                if(bal_parens == 0) { break; }
				
		}
};


int match(const char *s, const char *p, int overlap)
{
	//Rosetta Code count-occurrences-of-a-substring-1.c
	int c = 0, l = strlen(p);
        while (*s != '\0') {
                if (strncmp(s++, p, l)) continue;
                if (!overlap) s += l - 1;
                c++;
		printf("%d",c);
        }
        return c;
}



void consume_until_match(char * stop_word)
{
		printf("balanced");
		int c;
		int index=0;
		char buf[1000];
		memset(buf,'\0',1000);
		while( c = input() )
		{
		    if ( match(buf,stop_word,0) == 0 ){
				printf("fuck:");
			} 
                    if ( c == EOF )
                        {
                        printf( "EOF " );
                        break;
                        }
		if(index<1000){
			buf[index]=c;
			index++;
		} else {
				printf("buffer passed was too small");
				break;	
		}

		offset++;
		if(c == '\n') { ++lineCount;}
				
		}
};





