#include "uthash.h"
#include "xxhash.h"
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */
#include "globals.h"

struct my_struct *tokens = NULL;

void add_token(XXH64_hash_t token_id, const char *token) {
  struct my_struct *s;

  HASH_FIND_INT(tokens, &token_id, s); /* id already in the hash? */
  if (s == NULL) {
    s = (struct my_struct *)malloc(sizeof *s);
    s->id = token_id;
    HASH_ADD_INT(tokens, id, s); /* id is the key field */
  }
  strcpy(s->token, token);
}

struct my_struct *find_token(XXH64_hash_t token_id) {
  struct my_struct *s;

  HASH_FIND_INT(tokens, &token_id, s); /* s: output pointer */
  return s;
}

void delete_token(struct my_struct *token) {
  HASH_DEL(tokens, token); /* token: pointer to deletee */
  free(token);
}

void delete_all() {
  struct my_struct *current_token;
  struct my_struct *tmp;

  HASH_ITER(hh, tokens, current_token, tmp) {
    HASH_DEL(tokens, current_token); /* delete it (tokens advances to next) */
    free(current_token);             /* free it */
  }
}

void print_tokens() {
  struct my_struct *s;

  for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
    printf("token id %llx: token %s\n", s->id, s->token);
  }
}

int by_token(const struct my_struct *a, const struct my_struct *b) {
  return strcmp(a->token, b->token);
}

int by_id(const struct my_struct *a, const struct my_struct *b) {
  return (a->id - b->id);
}

const char *getl(const char *prompt) {
  static char buf[21];
  char *p;
  printf("%s? ", prompt);
  fflush(stdout);
  p = fgets(buf, sizeof(buf), stdin);
  if (p == NULL || (p = strchr(buf, '\n')) == NULL) {
    puts("Invalid input!");
    exit(EXIT_FAILURE);
  }
  *p = '\0';
  return buf;
}

