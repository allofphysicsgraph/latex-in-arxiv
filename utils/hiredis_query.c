/*
 *  gcc -g hiredis_query.c hiredis.c alloc.c async.c sds.c net.c read.c
 * -I/usr/local/include/hiredis/
 */

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
redisContext *Conn(void) {
  unsigned int j, isunix = 0;
  redisContext *c;
  const char *hostname = "127.0.0.1";
  int port = 6379;
  redisReply *reply;

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

void query(void) {
  redisContext *c = Conn();
  redisReply *reply;

  /* Let's check what we have inside the list */
  reply = redisCommand(c, "LRANGE files 0 -1");
  if (reply->type == REDIS_REPLY_ARRAY) {
    for (int j = 0; j < reply->elements; j++) {
      printf("%u) %s\n", j, reply->element[j]->str);
    }
  }
  freeReplyObject(reply);
  redisFree(c);
}

int main() {
  query();
  return 0;
}
