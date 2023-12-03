#include "globals.h"
#include "uthash.h"
#include "xxhash.h"
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */

struct my_struct *tokens = NULL;
void add_token(XXH64_hash_t token_id, const char *token,int tok_len,int offset) {
  struct my_struct *s;

  HASH_FIND_INT(tokens, &token_id, s); /* id already in the hash? */
  if (s == NULL) {
    s = (struct my_struct *)malloc(sizeof *s);
    s->id = token_id;
    s->count = 1;
    s->length = tok_len;
    //s->index=0;
   // s->offsets[s->index]=offset;
    //s->index++;
    HASH_ADD_INT(tokens, id, s); /* id is the key field */
  } else {
    s->count++;
    //s->offsets[s->index]=offset;
    //s->index++;
  }
  strcpy(s->token, token);
}

struct my_struct *find_token(XXH64_hash_t token_id) {
  struct my_struct *s;
  HASH_FIND_INT(tokens, &token_id, s); /* s: output pointer */
  return s;
}

void delete_token(struct my_struct *token, struct my_struct *tokens) {
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
    printf("id:%llx: count:%d tok:%s\n", s->id, s->count, s->token);
  }
}

int by_token(const struct my_struct *a, const struct my_struct *b) {
  return strcmp(a->token, b->token);
}

int by_id(const struct my_struct *a, const struct my_struct *b) {
  return (a->id - b->id);
}

int by_count(const struct my_struct *a, const struct my_struct *b) {
  return (a->count - b->count);
}

void srt() { HASH_SORT(tokens, by_count); }

void count() {
  int temp;
  temp = HASH_COUNT(tokens);
  printf("%d", temp);
}
