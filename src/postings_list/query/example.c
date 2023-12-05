#include "globals.h"
#include "uthash.h"
#include "xxhash.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */

struct my_struct *tokens = NULL;

void add_token(XXH64_hash_t token_id, const char *token, int tok_len,
               char filename[256]) {
  struct my_struct *s;

  HASH_FIND_INT(tokens, &token_id, s); /* id already in the hash? */
  if (s == NULL) {
    s = (struct my_struct *)malloc(sizeof *s);
    s->id = token_id;
    s->count = 1;
    s->length = tok_len;
    s->doc_count = 1;
    s->tf_idf = 0.0;
    memset(s->current_file, '\0', 256);
    strncpy(s->current_file, filename, 256);
    HASH_ADD_INT(tokens, id, s); /* id is the key field */
  } else {
    s->count++;
    if (strncmp(s->current_file, filename, 256) != 0) {
      s->doc_count++;
      strncpy(s->current_file, filename, 256);
    }
  }
  strcpy(s->token, token);
}

struct my_struct *find_token(XXH64_hash_t token_id) {
  struct my_struct *s;
  HASH_FIND_INT(tokens, &token_id, s); /* s: output pointer */
  if (s != NULL) {
    printf("%s", s->token);
  }
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

void update_tf_idf(int total_doc_count) {
  struct my_struct *s;
  for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
    float tf = 1 + log10(s->count + 1);
    float idf = log10(total_doc_count / s->doc_count);
    float tf_idf = tf * idf;
    s->tf_idf = tf_idf;
  }
}

float avg_tfidf() {
  struct my_struct *s;
  float avg;
  float total;
  int counter = 0;
  for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
    total += s->tf_idf;
    counter++;
  }
  assert(counter > 0);
  return total / counter;
}

void print_tokens() {
  struct my_struct *s;
  if (avg_tfidf() > .05) {
    for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
      // don't print tf_idf where the scores are all 0 ie a single document.
      printf("id:%lx: count:%d docs:%d tf_idf:%f tok:%s\n", s->id, s->count,
             s->doc_count, s->tf_idf, s->token);
    }
  } else {
    for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
      printf("id:%lx: count:%d docs:%d tok:%s\n", s->id, s->count, s->doc_count,
             s->token);
    }
  }
}

int by_token(const struct my_struct *a, const struct my_struct *b) {
  return strcmp(a->token, b->token);
}

int by_id(const struct my_struct *a, const struct my_struct *b) {
  return (a->id - b->id);
}

int by_tf_idf(const struct my_struct *a, const struct my_struct *b) {
  return ((int)(100 * (a->tf_idf)) - (int)(100 * (b->tf_idf)));
}

int by_count(const struct my_struct *a, const struct my_struct *b) {
  return (a->count - b->count);
}

void srt() {
  if (avg_tfidf() > .05) {
    HASH_SORT(tokens, by_tf_idf);
  } else {
    HASH_SORT(tokens, by_count);
  }
}

void count() {
  int temp;
  temp = HASH_COUNT(tokens);
  printf("%d", temp);
}
