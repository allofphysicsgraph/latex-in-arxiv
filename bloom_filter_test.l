%{
#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include "bloom.h"

#include <sys/time.h>
#include <time.h>
#include <ncurses.h>
#define MAX_LEN 1024
struct bloom bloom; 
%}

%%

[a-zA-Z]+	{
	if ( bloom_check(&bloom, yytext, yyleng)){
	attron(COLOR_PAIR(1));
	printw("%s",yytext,yyleng);
	refresh();
	} else {
		attron(COLOR_PAIR(2));
		printw("%s",yytext,yyleng);
		refresh();
	}}	

.	{ 
		attron(COLOR_PAIR(3));
	printw("%s",yytext,yyleng); refresh(); }
\n	{ printw("%s",yytext,yyleng); refresh(); }

%%


int main(int argc, char **argv)
{
  int i = -1;
  assert(bloom_init(&bloom, 100000, 0.00001)==0); 

  FILE	*fp;										/* input-file pointer */
  char	*fp_file_name = "english_vocab";		/* input-file name    */

  char  tmp_buffer[100000];

  
  fp	= fopen( fp_file_name, "r" );
  if ( fp == NULL ) {
	  fprintf ( stderr, "couldn't open file '%s'; %s\n",
			  fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }
 
  while (fgets(tmp_buffer, MAX_LEN - 1, fp))
    {
        // Remove trailing newline
        tmp_buffer[strcspn(tmp_buffer, "\n")] = 0;
	//printf("%s",tmp_buffer);
	bloom_add(&bloom, tmp_buffer, strlen(tmp_buffer));
       	//vocabulary_add_word(tmp_buffer);
    }

 
  if( fclose(fp) == EOF ) {			/* close input file   */
	  fprintf ( stderr, "couldn't close file '%s'; %s\n",
			  fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }

  if(argc == 2){
  yyin=fopen(argv[1],"r");
	initscr();
	start_color();
	init_pair(1, COLOR_GREEN, COLOR_BLACK);
	init_pair(2, COLOR_RED, COLOR_BLACK);
	init_pair(3, COLOR_YELLOW, COLOR_BLACK);
	cbreak(); 	//ctrl-c to exit
	noecho(); 
  yylex();
  getch();
   endwin();
  }

  bloom_free(&bloom);
  return 0;
}


