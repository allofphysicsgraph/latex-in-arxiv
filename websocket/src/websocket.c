/*
 * Copyright (c) 2014 Joris Vink <joris@coders.se>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <kore/kore.h>
#include <kore/http.h>
#include "scanner.h"
#include "assets.h"
#include "file_utils.h"
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <hiredis.h>
#include <math.h>  
#include <stdio.h>
#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <kore/http.h>
#include <kore/kore.h>
#define MAX_FILE_SIZE 100000
#include <kore/seccomp.h>

KORE_SECCOMP_FILTER("tasks",
	KORE_SYSCALL_ALLOW(getdents64),
);

int		page(struct http_request *);
int		file_index_connect(struct http_request *);
int		websocket_message_connect(struct http_request *req);

void		websocket_connect(struct connection *);
void		websocket_disconnect(struct connection *);
void		websocket_message(struct connection *,
		    u_int8_t, void *, size_t);

void		index_files(struct connection *,u_int8_t);
void            websocket_author_search(struct connection *c, u_int8_t op, void *data, size_t len);
int refind(char *buffer, char *pattern) ;

/* Called whenever we get a new websocket connection. */
void
websocket_connect(struct connection *c)
{
		file_search("assets");
		kore_log(LOG_NOTICE, "%p: connected", c);
}


void websocket_author_search(struct connection *c, u_int8_t op, void *data,
                             size_t len) {
  struct stat s;
  char *buffer;
  int fd;
  fd = open("authors", O_RDONLY);
  // if (fd < 0)
  // kore_log(EXIT_FAILURE;

  size_t buffer_idx = 0;
  int test_buffer_idx = 0;
  char test_buffer[2056];
  memset(test_buffer, '\0', 2056);
  int line_count = 0;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */
  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {
    while (buffer_idx < strlen(buffer)) {
      if (buffer[buffer_idx] != '\n') {
        test_buffer[test_buffer_idx] = buffer[buffer_idx];
        test_buffer_idx++;
      } else {
        line_count++;
        int testing = refind(test_buffer, (char *)&data[7]);
        char filename[120];
        memset(filename, '\0', 120);
        if (strlen(test_buffer) > 10) {
          strncpy(filename, &test_buffer[2], 8);
          if (testing == 0) {
            kore_log(LOG_NOTICE, "%s\n", filename);
          }
          test_buffer_idx = 0;
          memset(test_buffer, '\0', 2056);
        }
      }
      buffer_idx++;
    }
    munmap(buffer, s.st_size);
  }
  close(fd);
}

void index_files(struct connection *c, u_int8_t op) {
size_t len2;
struct kore_buf *buf;
u_int8_t *data2;

// http_populate_get(req);
buf = kore_buf_alloc(1280000);

redisReply *reply;
redisContext *redisConn = Conn();
reply = redisCommand(redisConn, "LRANGE files 0 -1");
if (reply->type == REDIS_REPLY_ARRAY) {
  for (unsigned int j = 0; j < reply->elements; j++) {
    kore_buf_appendf(buf, "<tr><td><a href=\'%s\'>%s<td></tr>",
                     reply->element[j]->str, reply->element[j]->str);
    }
  }

data2 = kore_buf_release(buf, &len2);
freeReplyObject(reply);
redisFree(redisConn);

kore_websocket_broadcast(c, op, data2, len2, WEBSOCKET_BROADCAST_GLOBAL);
kore_free(data2);
}

void websocket_message(struct connection *c, u_int8_t op, void *data,
                       size_t len) {
  size_t len2;
  //kore_log(LOG_NOTICE, " data:%s:","*********************");
  //kore_log(LOG_NOTICE, "%d:%s",strcmp(data,"undefined"),data);
  struct kore_buf *buf;
  u_int8_t *data2;
  buf = kore_buf_alloc(128000);
  redisReply *reply;
  char tmp_file_loc[1024];
  memset(tmp_file_loc,'\0',1024);
  redisContext *redisConn = Conn();
  reply = redisCommand(redisConn, "LRANGE files 0 -1");
  if (reply->type == REDIS_REPLY_ARRAY) {
    for (unsigned int j = 0; j < reply->elements; j++) {
  	if(!strcmp(data,"undefined")==0){
	if (rematch(reply->element[j]->str,data)==0){
  	//	kore_log(LOG_NOTICE, "%s:%s\n",reply->element[j]->str,data);
		//resub(reply->element[j]->str,"assets/HTML/","",tmp_file_loc);
      	    	kore_buf_appendf(buf, "<tr><td><a href=\'%s\'>%s<td></tr>",
                         reply->element[j]->str, tmp_file_loc);
			 memset(tmp_file_loc,'\0',1024);
    }}}
  }

  data2 = kore_buf_release(buf, &len2);
  freeReplyObject(reply);
  redisFree(redisConn);

  kore_websocket_broadcast(c, op, data2, len2, WEBSOCKET_BROADCAST_GLOBAL);
  kore_free(data2);
}
void
websocket_disconnect(struct connection *c)
{
	kore_log(LOG_NOTICE, "%p: disconnecting", c);
}

int
page(struct http_request *req)
{
	//hiredis_example();
	http_response_header(req, "content-type", "text/html");
	http_response(req, 200, asset_frontend_html, asset_len_frontend_html);

	return (KORE_RESULT_OK);
}
int
websocket_author_connect(struct http_request *req)
{
	/* Perform the websocket handshake, passing our callbacks. */
	kore_websocket_handshake(req, "websocket_connect",
	    "websocket_author_search", "websocket_disconnect");

	return (KORE_RESULT_OK);
}

int
websocket_message_connect(struct http_request *req)
{
	/* Perform the websocket handshake, passing our callbacks. */
	kore_websocket_handshake(req, "websocket_connect",
	    "websocket_message", "websocket_disconnect");

	return (KORE_RESULT_OK);
}

int
file_index_connect(struct http_request *req)
{
	/* Perform the websocket handshake, passing our callbacks. */
	kore_websocket_handshake(req, "websocket_connect",
	    "index_files", "websocket_disconnect");

	return (KORE_RESULT_OK);
}
