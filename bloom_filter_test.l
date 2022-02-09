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

#include "hashmap.h"
#include <ncurses.h>
#define MAX_LEN 1024
struct bloom eng_bloom; 
struct bloom latex_bloom; 
struct hashmap_s hashmap;
int line_count=0;
int known_word_count=0;
int unknown_word_count=0;
int counter=1;
#define initial_size  65536
int word_counting[initial_size];

%}


%option 8bit
%%

[a-zA-Z]+	{
	if ( bloom_check(&eng_bloom, yytext, yyleng)){
	attron(COLOR_PAIR(1));
	printw("%s",yytext,yyleng);
	known_word_count++;
	if (NULL == hashmap_get(&hashmap, yytext, yyleng)){
	if (0 != hashmap_put(&hashmap, yytext, yyleng, &word_counting[1])) {
	  puts("failed hashmap_put");
	  return -1;
	}
	      
	} else {
	counter = *(int *)hashmap_get(&hashmap, yytext, yyleng)+1;
	if (0 != hashmap_put(&hashmap, yytext, yyleng, &word_counting[counter])) {
	  puts("failed hashmap_put");
	  return -1;
	}
	
	}
	} else {
		attron(COLOR_PAIR(2));
		printw("%s",yytext,yyleng);
		unknown_word_count++;
}}	

.	{ 
		attron(COLOR_PAIR(3));
	printw("%s",yytext,yyleng); refresh(); }
\n	{  line_count++; if(line_count %40 == 0) { getch(); clear(); } 
		printw("%s",yytext,yyleng); refresh(); }

%%


int main(int argc, char **argv)
{
	int i = 0;
	for(i;i<initial_size;i++){
		word_counting[i] = i;
	}

	
	if (0 != hashmap_create(initial_size, &hashmap)) {
	  puts("failed to create hashmap");
	  return -1;
	}










	
  assert(bloom_init(&eng_bloom, 100000, 0.00001)==0); 
  assert(bloom_init(&latex_bloom, 100000, 0.00001)==0); 

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
	bloom_add(&eng_bloom, tmp_buffer, strlen(tmp_buffer));
    }

 
  if( fclose(fp) == EOF ) {			/* close input file   */
	  fprintf ( stderr, "couldn't close file '%s'; %s\n",
			  fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }



  FILE	*latex_fp;										/* input-file pointer */
  char	*latex_fp_file_name = "latex_vocab";		/* input-file name    */

  char  latex_tmp_buffer[100000];

  
  latex_fp	= fopen( latex_fp_file_name, "r" );
  if ( fp == NULL ) {
	  fprintf ( stderr, "couldn't open file '%s'; %s\n",
			  latex_fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }
 
  while (fgets(latex_tmp_buffer, MAX_LEN - 1, fp))
    {
        // Remove trailing newline
        latex_tmp_buffer[strcspn(latex_tmp_buffer, "\n")] = 0;
	bloom_add(&latex_bloom, latex_tmp_buffer, strlen(latex_tmp_buffer));
    }

 
  if( fclose(latex_fp) == EOF ) {			/* close input file   */
	  fprintf ( stderr, "couldn't close file '%s'; %s\n",
			  latex_fp_file_name, strerror(errno) );
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
	refresh();
  getch();
   endwin();
  }

  counter = *(int *)hashmap_get(&hashmap, "constants", strlen("constants"));
  printf("test count:%d\n",counter);

	hashmap_destroy(&hashmap);
	unsigned num_entries = hashmap_num_entries(&hashmap);
	printf("\n%d",num_entries);
	


  bloom_free(&eng_bloom);
  bloom_free(&latex_bloom);
  printf("known words:%d\tunknowns:%d",known_word_count,unknown_word_count);
	return 0;
}




	

