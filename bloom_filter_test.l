%{
#include <assert.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include "hashmap.h"
#include "bloom.h"

#define MAX_LEN 1024
#define initial_size  65536
#define max_page_size 25000
#define page_length_line_count 40

struct bloom eng_bloom; 
struct bloom latex_bloom; 
struct hashmap_s hashmap;
struct hashmap_s unknown_hashmap;

int line_count=0;
int known_word_count=0;
int unknown_word_count=0;
int counter=1;
int word_counting[initial_size];
int current_page_number=0;
char page_buffer[initial_size][max_page_size];

static int hashmap_print_all(void *context, struct hashmap_element_s *e);
int balanced_parens(const char * fname, char * start_pattern, char * l_delimiter, char * r_delimiter, int start_position);

 
FILE	*latex_fp;										/* input-file pointer */
char	*latex_fp_file_name = "latex_vocab";		/* input-file name    */
char  latex_tmp_buffer[100000];

FILE	*fp;										/* input-file pointer */
char	*fp_file_name = "english_vocab";		/* input-file name    */
char  tmp_buffer[100000];

YY_BUFFER_STATE flex_page_buffer;

%}


%option 8bit
%%
"\\"[a-zA-Z]+	{
        //printw("latex");
	strncat(page_buffer[current_page_number],yytext,yyleng);
	if ( bloom_check(&eng_bloom, yytext, yyleng)){
	attron(COLOR_PAIR(4));
	printw("%s",yytext,yyleng);
	known_word_count++;
	if (NULL == hashmap_get(&hashmap, yytext, yyleng)){
	if (0 != hashmap_put(&hashmap, yytext, yyleng, &word_counting[1])) {
	  //puts("failed hashmap_put");
	  return -1;
	}
	      
	} else {
	counter = *(int *)hashmap_get(&hashmap, yytext, yyleng)+1;
	if (0 != hashmap_put(&hashmap, yytext, yyleng, &word_counting[counter])) {
	  //puts("failed hashmap_put");
	  return -1;
	}
	
	}
	} else {
		attron(COLOR_PAIR(5));
		printw("%s",yytext,yyleng);
		attroff(COLOR_PAIR(5));
		unknown_word_count++;
}}	

[a-zA-Z]+	{
 	//printw("eng");
	strncat(page_buffer[current_page_number],yytext,yyleng);
	if ( bloom_check(&eng_bloom, yytext, yyleng)){
	attron(COLOR_PAIR(1));
	printw("%s",yytext,yyleng);
	attroff(COLOR_PAIR(1));
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
		//puts("else");
		attron(COLOR_PAIR(2));
		printw("%s",yytext,yyleng);
		attroff(COLOR_PAIR(2));
		unknown_word_count++;
	if (NULL == hashmap_get(&unknown_hashmap, yytext, yyleng)){
	if (0 != hashmap_put(&unknown_hashmap, yytext, yyleng, &word_counting[1])) {
	  puts("failed hashmap_put");
	  return -1;
	}
	      
	} else {
	counter = *(int *)hashmap_get(&unknown_hashmap, yytext, yyleng)+1;
	//printf("counter:%d",counter);
	if (0 != hashmap_put(&unknown_hashmap, yytext, yyleng, &word_counting[counter])) {
	  puts("failed hashmap_put");
	  return -1;
	}


}}}	

.	{ 
		strncat(page_buffer[current_page_number],yytext,yyleng);
		attron(COLOR_PAIR(3));
		printw("%s",yytext,yyleng); refresh(); 
		attroff(COLOR_PAIR(3));
	}
\n	{ 
		 strncat(page_buffer[current_page_number],yytext,yyleng);
		 line_count++; 
		 if(line_count % page_length_line_count == 0) { current_page_number++; getch(); clear(); } 
		 printw("%s",yytext,yyleng); refresh(); 
}

%%


int main(int argc, char **argv)
{

 /*
  * balanced_parens(argv[1], "\\begin{equation}", "\\begin{equation}", "\\end{equation}", atoi(argv[2]));
  * balanced_parens(argv[1], "\\title", "{", "}", atoi(argv[2]));
  * balanced_parens(argv[1], "\\author", "{", "}", atoi(argv[2]));
  * balanced_parens(argv[1], "\\affiliation", "{", "}", atoi(argv[2]));
  * balanced_parens(argv[1], "\\begin{abstract}", "\\begin{abstract}", "\\end{abstract}", atoi(argv[2]));
  * balanced_parens(argv[1], "\\cite", "{", "}", atoi(argv[2]));
  * balanced_parens(argv[1], "\\begin{thebibliography}", "\\begin{thebibliography}", "\\end{thebibliography}", atoi(argv[2]));
  */
  
  initscr();
  start_color();
  init_pair(1, COLOR_GREEN, COLOR_BLACK);
  init_pair(2, COLOR_RED, COLOR_BLACK);
  init_pair(3, COLOR_YELLOW, COLOR_BLACK);
  init_pair(4, COLOR_BLUE, COLOR_BLACK);
  init_pair(5, COLOR_CYAN, COLOR_BLACK);
  cbreak(); 	//ctrl-c to exit
  noecho(); 
  assert(bloom_init(&eng_bloom, 100000, 0.00001)==0); 
  assert(bloom_init(&latex_bloom, 100000, 0.00001)==0); 
	int i = 0;
	int total =0; 
	for(i;i<initial_size;i++){
		word_counting[i] = i;
	}


	if (0 != hashmap_create(initial_size, &hashmap)) {
	  puts("failed to create hashmap");
	  return -1;
	}

	if (0 != hashmap_create(initial_size, &unknown_hashmap)) {
	  puts("failed to create hashmap");
	  return -1;
	}
	


  
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

  
  latex_fp	= fopen( latex_fp_file_name, "r" );
  if ( fp == NULL ) {
	  fprintf ( stderr, "couldn't open file '%s'; %s\n",
			  latex_fp_file_name, strerror(errno) );
	  exit (EXIT_FAILURE);
  }
 
  while (fgets(latex_tmp_buffer, MAX_LEN - 1, latex_fp))
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
  yylex();
  refresh();
  getch();
  }

  if (NULL != hashmap_get(&hashmap, yytext, yyleng)){
  	counter = *(int *)hashmap_get(&hashmap, "constants", strlen("constants"));
  	//printf("test count:%d\n",counter);
  }
	//hashmap_iterate_pairs(&unknown_hashmap, hashmap_print_all, &total);


  clear();
  flex_page_buffer = yy_scan_string(page_buffer[0]);
  yy_switch_to_buffer(flex_page_buffer);
  yylex();
  getch();


	hashmap_destroy(&hashmap);
	hashmap_destroy(&unknown_hashmap);
	unsigned num_entries = hashmap_num_entries(&hashmap);
	//printf("\n%d",num_entries);
	

  printf("known words:%d\tunknowns:%d\n",known_word_count,unknown_word_count);
  //printf("page 0:%s\n",page_buffer[0]);
  getch();
  endwin();
  exit_curses(EXIT_SUCCESS);
  bloom_free(&eng_bloom);
  bloom_free(&latex_bloom);
  yylex_destroy();

	return 0;
}


static int hashmap_print_all(void *context, struct hashmap_element_s *e) {
  //puts("print all");
  printf("\nprint_all:%s\n",e->key);
  //(*(int *)context)+=e->key_len;
  return -1;
}


	
int balanced_parens(const char * fname, char * start_pattern, char * l_delimiter, char * r_delimiter, int start_position) {
  //https://rosettacode.org/wiki/Read_a_file_line_by_line#Using_mmap.28.29
  int fd = open(fname, O_RDONLY);
  struct stat fs;
  char * buf;
  int start_index = 0;
  int i = start_position;

  int balanced = 0;
  if (!strcmp(start_pattern, l_delimiter)) {
    balanced = -1;
  }

  if (fd == -1) {
    err(1, "open: %s", fname);
    return 0;
  }

  if (fstat(fd, & fs) == -1) {
    err(1, "stat: %s", fname);
    return 0;
  }

  char tmp_data[fs.st_size];
  char result_data[fs.st_size];
  memset(tmp_data, '\0', fs.st_size);
  memset(result_data, '\0', fs.st_size);

  /* fs.st_size could have been 0 actually */
  buf = mmap(0, fs.st_size, PROT_READ, MAP_SHARED, fd, 0);
  if (buf == (void * ) - 1) {
    err(1, "mmap: %s", fname);
    close(fd);
    return 0;
  }
  for (i; i < fs.st_size; i++) {
    strncpy(tmp_data, & buf[i], strlen(start_pattern));
    if (strcmp(tmp_data, start_pattern) == 0) {
      start_index = i;
      break;
    }
  }

  for (i; i < fs.st_size; i++) {
    memset(tmp_data, '\0', fs.st_size);
    strncpy(tmp_data, & buf[i], strlen(r_delimiter));
    if (!strcmp(tmp_data, r_delimiter)) {
      balanced++;
      //printf("++");
      if (balanced == 0) {
        strncpy(result_data, & buf[start_index], i - start_index + 1);
        if (!strcmp(start_pattern, l_delimiter)) {
          if (r_delimiter[0] == '\\') {
            strcat(result_data, & r_delimiter[1]);
          } else {
            strcat(result_data, r_delimiter);
          }
        }
        printf("(%d,%d):%s\n", start_index, i, result_data);
        munmap(buf, fs.st_size);
        close(fd);
        balanced_parens(fname, start_pattern, l_delimiter, r_delimiter, i + 1);
        break;
      }
    }

    if (!strcmp(tmp_data, l_delimiter)) {
      //printf("--");
      balanced--;
    }
  }

  munmap(buf, fs.st_size);
  close(fd);
  return 1;
}


