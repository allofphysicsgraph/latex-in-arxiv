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





#define MAX_AUTHORS 15000
#define MAX_AUTHORS_LEN 100000
#define MAX_FILE_SIZE 100000
#define MAX_TITLES 12000
#define MAX_TITLES_LEN 100000
#define MEM_TAG_AUTHORS 100
#define MEM_TAG_TITLES 101

int		init(int);

/* Global pointer, gets initialized to NULL when module loads/reloads. */
char		*author_ptr=NULL;
char		*title_ptr=NULL;

char *test[MAX_AUTHORS_LEN]={NULL};
char author[MAX_AUTHORS][MAX_AUTHORS_LEN];
char *title_test[MAX_TITLES_LEN]={NULL};
char title[MAX_TITLES][MAX_TITLES_LEN];
int author_line_count=0;
int title_line_count=0;

int
init(int state) {
  char *buffer;
  int fd;
  struct stat s;
  
/* Ignore unload(s). */
if (state == KORE_MODULE_UNLOAD)
  return (KORE_RESULT_OK);

/* Attempt to lookup the original pointer. */
if ((author_ptr = kore_mem_lookup(MEM_TAG_AUTHORS)) == NULL) {
  /* Failed, grab a new chunk of memory and tag it. */
  fd = open("authors", O_RDONLY);
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */

  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {
    printf("  allocating author_ptr for the first time\n");
    author_ptr = kore_malloc_tagged(strlen(buffer) + 1, MEM_TAG_AUTHORS);
    kore_strlcpy(author_ptr, buffer, strlen(buffer) + 1);
    author_line_count = kore_split_string(author_ptr, "\n", test, MAX_AUTHORS);
    for (int i = 0; i < author_line_count; i++) {
      if (test[i] != NULL) {
        //kore_log(LOG_NOTICE, "%s: connected", test[i]);
        sprintf(author[i], "<tr><td>%s</td></tr>", test[i]);
        //kore_log(LOG_NOTICE, "%s: connected", author[i]);
      }
    }
    close(fd);
    munmap(buffer, s.st_size);
  }

if ((title_ptr = kore_mem_lookup(MEM_TAG_TITLES)) == NULL) {
  /* Failed, grab a new chunk of memory and tag it. */
  fd = open("titles", O_RDONLY);
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */

  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {
    printf("  allocating title_ptr for the first time\n");
    title_ptr = kore_malloc_tagged(strlen(buffer) + 1, MEM_TAG_TITLES);
    kore_strlcpy(title_ptr, buffer, strlen(buffer) + 1);
    title_line_count = kore_split_string(title_ptr, "\n", title_test, MAX_TITLES);
    kore_log(LOG_NOTICE, ":::::%i: connected", title_line_count);
    kore_log(LOG_NOTICE, ":::::%s: connected", title_test[0]);
    for (int i = 0; i < title_line_count; i++) {
      if (title_test[i] != NULL) {
	memset(title[i],'\0',MAX_TITLES_LEN);
        //kore_log(LOG_NOTICE, "%s: connected", title[i]);
        sprintf(title[i], "<tr><td>%s</td></tr>", title_test[i]);
	
      }
    }
    close(fd);
    munmap(buffer, s.st_size);
  }

} else {
  printf("  fixed_ptr address resolved\n");
}}
return (KORE_RESULT_OK);
}


/* Called whenever we get a new websocket connection. */
void
websocket_connect(struct connection *c)
{
		file_search("assets");
		kore_log(LOG_NOTICE, "%p: connected", c);
}


void websocket_author_search(struct connection *c, u_int8_t op, void *data,
                             size_t len) {
  
	kore_log(LOG_NOTICE, "%s:\n", (char *)data);
	//char filename[120];
	int line_count = 0;
	int row_count =0;	
	int test_buffer_idx = 0;
	size_t author_idx = 0;
	size_t len2;
	struct kore_buf *buf;
	u_int8_t *data2;
	buf = kore_buf_alloc(10*1024*1024);
	for(int i=0;i<author_line_count;i++){
		if(test[i]!=NULL){
		//kore_log(LOG_NOTICE, ":::%s::",author[i]);
		if(refind(test[i],data)==0){
			row_count++;
		if (row_count > 10000) { break;}
		kore_buf_append(buf,author[i],strlen(author[i]));
		}}
	}
	
	for(int i=0;i<title_line_count;i++){
		if(title_test[i]!=NULL){
		if(refind(title_test[i],data)==0){
			row_count++;
		if (row_count > 10000) { break;}
		kore_buf_append(buf,title[i],strlen(title[i]));
		}}
	}
	
	data2 = kore_buf_release(buf, &len2);
	kore_websocket_broadcast(c, op,data2 , len2, WEBSOCKET_BROADCAST_GLOBAL);
kore_free(data2);
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
