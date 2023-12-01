#include "uthash.h"
#include "xxhash.h"
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */

struct my_struct {
  XXH64_hash_t id; /* key */
  char token[21];
  UT_hash_handle hh; /* makes this structure hashable */
};

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

int main() {
  XXH64_hash_t id = XXH64("hello", 5, 0);
  int running = 1;
  struct my_struct *s;
  int temp;

  while (running) {
    printf(" 1. add token\n");
    printf(" 2. add or rename token by id\n");
    printf(" 5. delete all tokens\n");
    printf(" 6. sort items by name\n");
    printf(" 7. sort items by id\n");
    printf(" 8. print tokens\n");
    printf(" 9. count tokens\n");
    printf("10. quit\n");
    switch (atoi(getl("Command"))) {
    case 1:
      static char buf[21];
      memset(buf, '\0', 21);
      strncpy(buf, getl("Name (20 char max"), 21);
      add_token(XXH64(buf, strlen(buf), 0), buf);
      break;
    case 2:
      temp = atoi(getl("ID"));
      add_token(temp, getl("Name (20 char max)"));
      break;
    case 3:
      // s = find_token(atoi(getl("ID to find")));
      // printf("token: %s\n", s ? s->token : "unknown");
      break;
    case 4:
      s = find_token(atoi(getl("ID to delete")));
      if (s) {
        delete_token(s);
      } else {
        printf("id unknown\n");
      }
      break;
    case 5:
      delete_all();
      break;
    case 6:
      HASH_SORT(tokens, by_token);
      break;
    case 7:
      HASH_SORT(tokens, by_id);
      break;
    case 8:
      print_tokens();
      break;
    case 9:
      temp = HASH_COUNT(tokens);
      printf("there are %d tokens\n", temp);
      break;
    case 10:
      running = 0;
      break;
    }
  }

  delete_all(); /* free any structures */
  return 0;
}
