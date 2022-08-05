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
int current_offset=0;
int current_page_number=0;
int append_offset=0;
char page_buffer[initial_size][max_page_size];

static int hashmap_print_all(void *context, struct hashmap_element_s *e);
int balanced_parens(const char *data,
                    char       *start_pattern,
                    char       *l_delimiter,
                    char       *r_delimiter,
                    int         start_position);

 
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

	current_offset+=append_offset;
        append_offset=yyleng;

        //printw("latex");
	strncat(page_buffer[current_page_number],yytext,yyleng); //copies match to page_buffer
	if ( bloom_check(&eng_bloom, yytext, yyleng)){           //verifies word is in the bloom filter
	attron(COLOR_PAIR(4));											
	printw("%s",yytext,yyleng);
	known_word_count++;
	if (NULL == hashmap_get(&hashmap, yytext, yyleng)){
		if (0 != hashmap_put(&hashmap, yytext, yyleng, &word_counting[1])) {
		  //puts("failed hashmap_put");
		  return -1;}
	} else {
	counter = *(int *)hashmap_get(&hashmap, yytext, yyleng)+1;
		if (0 != hashmap_put(&hashmap, yytext, yyleng, &word_counting[counter])) {
		  //puts("failed hashmap_put");
		  return -1;}
        }
	} else {
		attron(COLOR_PAIR(5));
		printw("%s",yytext,yyleng);
		attroff(COLOR_PAIR(5));
		unknown_word_count++;
}
}	

[a-zA-Z]+	{
	current_offset+=append_offset;
        append_offset=yyleng;
		
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
	current_offset+=append_offset;
        append_offset=yyleng;
		
                strncat(page_buffer[current_page_number],yytext,yyleng);
		attron(COLOR_PAIR(3));
		printw("%s",yytext,yyleng); refresh(); 
		attroff(COLOR_PAIR(3));
	}
\n	{ 
	current_offset+=append_offset;
        append_offset=yyleng;
		 strncat(page_buffer[current_page_number],yytext,yyleng);
		 line_count++; 
		 if(line_count % page_length_line_count == 0) { current_page_number++; getch(); clear(); } 
		 printw("%s",yytext,yyleng); refresh(); 
}

%%


int main(int argc, char **argv)
{

  char *file_buffer;
  struct stat file_s;

  int fd = open(argv[1], O_RDONLY);
  if (fd < 0 ) return EXIT_FAILURE;
  fstat(fd, &file_s);
  /* PROT_READ disallows writing to buffer: will segv */
  file_buffer = mmap(0, file_s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  //if ( file_buffer != (void*)-1 )
  
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
  if ( latex_fp == NULL ) {
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
  //flex_page_buffer = yy_scan_string(page_buffer[0]);
  //yy_switch_to_buffer(flex_page_buffer);
  //yylex();
  getch();


	hashmap_destroy(&hashmap);
	hashmap_destroy(&unknown_hashmap);
	unsigned num_entries = hashmap_num_entries(&hashmap);
	//printf("\n%d",num_entries);
	
  //balanced parens test
  char test[128];
  memset(test, 0, 128);
  strcpy(test, "abcd\\cite{hello}");
  balanced_parens(test, "\\cite", "{", "}", 0);

  printw("known words:%d\tunknowns:%d\n",known_word_count,unknown_word_count);
  printw("current offset:%d",current_offset);
 //printf("page 0:%s\n",page_buffer[0]);
  getch();
  endwin();
  exit_curses(EXIT_SUCCESS);
  bloom_free(&eng_bloom);
  bloom_free(&latex_bloom);
  yylex_destroy();
  munmap(file_buffer, file_s.st_size);
  close(fd);
  return 0;
}


static int hashmap_print_all(void *context, struct hashmap_element_s *e) {
  //puts("print all");
  printf("\nprint_all:%s\n",e->key);
  //(*(int *)context)+=e->key_len;
  return -1;
}




int balanced_parens(const char *data,
                    char       *start_pattern,
                    char       *l_delimiter,
                    char       *r_delimiter,
                    int         start_position) {
  size_t data_sz = strlen(data);
  int    start_index = 0;
  int    i           = start_position;
  int    balanced = 0;
  char   tmp_data[data_sz];
  char   result_data[data_sz];

  memset(tmp_data,    '\0', data_sz);
  memset(result_data, '\0', data_sz);

  if (strcmp(start_pattern, l_delimiter) == 0) {
    balanced = -1;

    // printf("balanced:%d",balanced);
  }

  for (i; i < (int)data_sz; i++) {
    strncpy(tmp_data, &data[i], strlen(start_pattern));

    if (strcmp(tmp_data, start_pattern) == 0) {
      start_index = i;
      strncpy(result_data, &data[start_index], strlen(start_pattern));
      break;
    }
  }

  for (i = start_index; i < (int)data_sz; i++) {
    memset(tmp_data, '\0', data_sz);
    strncpy(tmp_data, &data[i], strlen(r_delimiter));

    if (strcmp(tmp_data, r_delimiter) == 0) {
      balanced++;

      // printf("%d\n",balanced);
      if (balanced == 0) {
        strncpy(result_data, &data[start_index], (size_t)(i - start_index +1 ));

        // printf("%s",result_data);
        if (strcmp(start_pattern, l_delimiter) == 0) {
          if (r_delimiter[0] == '\\') {
            strcat(result_data, &r_delimiter[1]);
          } else {
            strcat(result_data, r_delimiter);
          }
        }
        

	attron(COLOR_PAIR(4));
	printw("(%d,%d):%s\n", start_index, i, result_data);
        attroff(COLOR_PAIR(4));
	break;
      }
    }

    if (strcmp(tmp_data, l_delimiter) == 0) {
      // printf("--");
      balanced--;
      strcat(result_data, tmp_data);

      // printf("%s",result_data);
    }
  }

  
  return 1;
}
	



