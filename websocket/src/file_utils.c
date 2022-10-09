#include "enum.h"
#include <dirent.h>
#include <err.h>
#include <errno.h>
#include <hiredis.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#define MAX_FILE_COUNT 100000

// rosetta code
char *ReadFile(char *filename)
// https://stackoverflow.com/a/3464656
{
  char *buffer = NULL;
  int string_size, read_size;
  FILE *handler = fopen(filename, "r");

  if (handler) {
    // Seek the last byte of the file
    fseek(handler, 0, SEEK_END);
    // Offset from the first to the last byte, or in other words, filesize
    string_size = ftell(handler);
    // go back to the start of the file
    rewind(handler);

    // Allocate a string that can hold it all
    buffer = (char *)malloc(sizeof(char) * (string_size + 1));

    // Read it all in one operation
    read_size = fread(buffer, sizeof(char), string_size, handler);

    // fread doesn't set it so put a \0 in the last position
    // and buffer is now officially a string
    buffer[string_size] = '\0';

    if (string_size != read_size) {
      // Something went wrong, throw away the memory and set
      // the buffer to NULL
      free(buffer);
      buffer = NULL;
    }

    // Always remember to close the file.
    fclose(handler);
  }

  return buffer;
}

// https://rosettacode.org/wiki/Walk_a_directory/Recursively#C
int walk_recur(char *dname, regex_t *reg, int spec, char *array[],
               int array_index) {
  struct dirent *dent;
  DIR *dir;
  struct stat st;
  char fn[FILENAME_MAX];
  int res = WALK_OK;
  int len = strlen(dname);
  if (len >= FILENAME_MAX - 1)
    return WALK_NAMETOOLONG;

  strcpy(fn, dname);
  fn[len++] = '/';

  if (!(dir = opendir(dname))) {
    warn("can't open %s", dname);
    return WALK_BADIO;
  }

  errno = 0;
  while ((dent = readdir(dir))) {
    if (!(spec & WS_DOTFILES) && dent->d_name[0] == '.')
      continue;
    if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
      continue;

    strncpy(fn + len, dent->d_name, FILENAME_MAX - len);
    if (lstat(fn, &st) == -1) {
      warn("Can't stat %s", fn);
      res = WALK_BADIO;
      continue;
    }

    /* don't follow symlink unless told so */
    if (S_ISLNK(st.st_mode) && !(spec & WS_FOLLOWLINK))
      continue;

    /* will be false for symlinked dirs */
    if (S_ISDIR(st.st_mode)) {
      /* recursively follow dirs */
      if ((spec & WS_RECURSIVE))
        walk_recur(fn, reg, spec, array, array_index);

      if (!(spec & WS_MATCHDIRS))
        continue;
    }

    /* pattern match */
    if (!regexec(reg, fn, 0, 0, 0)) {
      array[array_index] = strdup(fn);
      array_index++;
    }
  }

  if (dir)
    closedir(dir);
  return res ? res : errno ? WALK_BADIO : WALK_OK;
}

int walk_dir(char *dname, char *pattern, int spec, char *array[],
             int array_index) {
  regex_t r;
  int res;
  if (regcomp(&r, pattern, REG_EXTENDED | REG_NOSUB))
    return WALK_BADPATTERN;
  res = walk_recur(dname, &r, spec, array, array_index);
  regfree(&r);
  return res;
}

redisContext *Conn(void) {
  const char *hostname = "127.0.0.1";
  int port = 6379;
  redisContext *c;

  struct timeval timeout = {1, 500000}; // 1.5 seconds
  c = redisConnectWithTimeout(hostname, port, timeout);
  if (c == NULL || c->err) {
    if (c) {
      printf("Connection error: %s\n", c->errstr);
      redisFree(c);
    } else {
      printf("Connection error: can't allocate redis context\n");
    }
    exit(1);
  }
  return c;
}

void file_search(char *dir_path) {
  redisContext *c = Conn(); 
  redisReply *reply;
  if (c == NULL || c->err) {
    if (c) {
      printf("Connection error: %s\n", c->errstr);
      redisFree(c);
    } else {
      printf("Connection error: can't allocate redis context\n");
    }
    exit(1);
  }

  char *array[MAX_FILE_COUNT];
  int i = 0;
  int array_index = 0;
  memset(array, 0, sizeof(array));
  int r = walk_dir(dir_path, "\\.html$", WS_DEFAULT | WS_MATCHDIRS, array,
                   array_index);
  switch (r) {
  case WALK_OK:
    break;
  case WALK_BADIO:
    printf("IO error");
  case WALK_BADPATTERN:
    printf("Bad pattern");
  case WALK_NAMETOOLONG:
    printf("Filename too long");
  default:
    printf("Unknown error?");
  }
  reply = redisCommand(c, "DEL files");
  freeReplyObject(reply);

  i = 0;
  while (array[i] != NULL) {
    // printf("%s\n", array[i]);
    reply = redisCommand(c, "LPUSH files %s", array[i]);
    freeReplyObject(reply);
    free(array[i]);
    i++;
  }

  redisFree(c);
}


void query(void) {
  redisContext *c = Conn();
  redisReply *reply;

  /* Let's check what we have inside the list */
  reply = redisCommand(c, "LRANGE files 0 -1");
  if (reply->type == REDIS_REPLY_ARRAY) {
    for (unsigned int j = 0; j < reply->elements; j++) {
      printf("%u) %s\n", j, reply->element[j]->str);
    }
  }
  freeReplyObject(reply);
  redisFree(c);
}

redisReply *redisCmd(void) {
  redisContext *redisConn = Conn();
  redisReply *reply;
  reply = redisCommand(redisConn, "LRANGE files 0 -1");
  if (reply->type == REDIS_REPLY_ARRAY) {
    return reply;
  }
}
