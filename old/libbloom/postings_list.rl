/*
 * @LANG: c
 */
#include "bloom.h"
#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define MAX_LEN 1024
#define MAX_WORD_SIZE 32
//'$' (any - '$')* '$' => { 
char temp[MAX_WORD_SIZE];
char *buff;
struct bloom bloom;
char filename[128];
struct stat s;

int i;

int lookup_word(char *word);

enum {
  LOOKUP = 0, /* default - looking rather than defining. */
  ENGLISH,
};

int state;

int add_word(int type, char *word);
int lookup_word(char *word);
int line_no = 1;
int col_number = 1;
int char_offset = 0;

/* define a linked list of words and types */
struct word {
  char word_name[32];
  int offset_idx;
  int count;
  int word_type;
  struct word *next;
  int offset[];
};

struct word *word_list; /* first element in word list */

extern void *malloc();

int add_word(int type, char *word) {
  struct word *wp;

  if (lookup_word(word) != LOOKUP) {
    return -1;
  }

  /* word not there, allocate a new entry and link it on the list */
  wp = (struct word *)malloc(sizeof(struct word));

  wp->next = word_list;

  /* have to copy the word itself as well */
  memset(wp->word_name, '\0', 32);
  strncpy(wp->word_name, word, strlen(word));
  wp->word_name[strnlen(word, MAX_WORD_SIZE) + 1] = '\0';
  wp->word_type = type;
  wp->count = 1;
  wp->offset_idx=0;
  word_list = wp;
  return 1; /* it worked */
}

int lookup_word(char *word) {
  struct word *wp = word_list;

  /* search down the list looking for the word */
  for (; wp; wp = wp->next) {
    if (strcmp(wp->word_name, word) == 0)
      return wp->word_type;
  }
  return LOOKUP; /* not found */
}

void update_word(int type, char *word) {
  struct word *wp = word_list;
  /* search down the list looking for the word */
  for (; wp; wp = wp->next) {
    if (strcmp(wp->word_name, word) == 0)
      {
      //wp->offset_idx++;
      //wp->offset[wp->offset_idx]=1;
      wp->count++;
      }
  }
}



int print_word(char *word) {
  struct word *wp = word_list;
  /* search down the list looking for the word */
  for (; wp; wp = wp->next) {
    if (strcmp(wp->word_name, word) == 0)
      printf("<%s>:<%d>", wp->word_name,wp->count);
      }
  return LOOKUP; /* not found */
}
void freeList(struct word *head) {

  struct word *n = head;
  while (n) {
    struct word *n1 = n;
    n = n->next;
    free(n1);
  }
}

int scan(const char *in);
%%{
	machine part_token;
word = [a-zA-Z]{1,20};
	main := |*
  word => { 
memset(temp, '\0', MAX_WORD_SIZE);
strncpy(temp, &buff[ts - in], te - ts);
//printf("%s", temp);
if (bloom_check(&bloom, temp, te - ts)) {
  printf("%s,%zd,%zd,%s\n", filename, ts - in, te - ts, temp);
  if (!lookup_word(temp)) {
    add_word(1, temp);
  } else {
    update_word(1,temp);
  }
}
}
;
  

  any ;
	*|;
}%%

%% write data;

int scan(const char *in) {
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  %% write init;
  %% write exec;

  if (cs == part_token_error)
    printf("Error near %zd\n", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);

  return EXIT_SUCCESS;
}

int main(int argc, char **argv) {
  if (argc != 2) {
    printf("input filename\n");
    return -1;
  }

strncpy(filename, argv[1],128);

  i = -1;
  assert(bloom_init(&bloom, 100000, 0.00001) == 0);

  FILE *fp;                             /* input-file pointer */
  char *fp_file_name = "english.vocab"; /* input-file name    */

  char buffer[s.st_size];

  fp = fopen(fp_file_name, "r");
  if (fp == NULL) {
    fprintf(stderr, "couldn't open file '%s'; %s\n", fp_file_name,
            strerror(errno));
    exit(EXIT_FAILURE);
  }

  while (fgets(buffer, MAX_LEN - 1, fp)) {
    // Remove trailing newline
    buffer[strcspn(buffer, "\n")] = 0;
    // printf("%s",buffer);
    bloom_add(&bloom, buffer, strlen(buffer));
    // vocabulary_add_word(buffer);
  }

  if (fclose(fp) == EOF) { /* close input file   */
    fprintf(stderr, "couldn't close file '%s'; %s\n", fp_file_name,
            strerror(errno));
    exit(EXIT_FAILURE);
  }

  int cs, res = 0;

  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    scan((char *)buff);
    munmap(buff, s.st_size);
  }
  close(fd);
  bloom_free(&bloom);
  print_word("data");
  freeList(word_list);
  return 0;
}
