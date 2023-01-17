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
#include <curl/curl.h>
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



#define MAX_AFFILIATIONS 1500
#define MAX_AFFILIATIONS_LEN 10000

#define MAX_EQUATIONS 70000
#define MAX_EQUATIONS_LEN 50000

#define MAX_CITATIONS 490000
#define MAX_CITATIONS_LEN 10000

#define MAX_AUTHORS 14000
#define MAX_AUTHORS_LEN 100000

#define MAX_TITLES 13000
#define MAX_TITLES_LEN 100000

#define MAX_FILE_SIZE 100000
#define SEARCH_STATES 5

#define MEM_TAG_AUTHORS 100
#define MEM_TAG_TITLES 101
#define MEM_TAG_AFFILIATIONS 102
#define MEM_TAG_EQUATIONS 103
#define MEM_TAG_CITATIONS 104


int		init(int);

/* Global pointer, gets initialized to NULL when module loads/reloads. */
char		*author_ptr=NULL;
char		*title_ptr=NULL;
char		*affiliations_ptr=NULL;
char		*equations_ptr=NULL;
char		*citations_ptr=NULL;

char *author_test[MAX_AUTHORS_LEN]={NULL};
char author[MAX_AUTHORS][MAX_AUTHORS_LEN];

char *title_test[MAX_TITLES_LEN]={NULL};
char title[MAX_TITLES][MAX_TITLES_LEN];

char *affiliation_test[MAX_AFFILIATIONS_LEN]={NULL};
char affiliation[MAX_AFFILIATIONS][MAX_AFFILIATIONS_LEN];

char *equations_test[MAX_EQUATIONS_LEN]={NULL};
char equations[MAX_EQUATIONS][MAX_EQUATIONS_LEN];

char *citations_test[MAX_CITATIONS_LEN]={NULL};
char citations[MAX_CITATIONS][MAX_CITATIONS_LEN];

int author_line_count=0;
int title_line_count=0;
int affiliation_line_count=0;
int equations_line_count=0;
int citations_line_count=0;



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
    author_line_count = kore_split_string(author_ptr, "\n", author_test, MAX_AUTHORS);
    for (int i = 0; i < author_line_count; i++) {
      if (author_test[i] != NULL) {
        sprintf(author[i], "<tr><td>%s</td></tr>", author_test[i]);
      }
    }
    close(fd);
    munmap(buffer, s.st_size);
  }}

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
        sprintf(title[i], "<tr><td>%s</td></tr>", title_test[i]);
	
      }
    }
    close(fd);
    munmap(buffer, s.st_size);
  }} 

if ((equations_ptr = kore_mem_lookup(MEM_TAG_EQUATIONS)) == NULL) {
  /* Failed, grab a new chunk of memory and tag it. */
  fd = open("equations", O_RDONLY);
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */
  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {
    equations_ptr = kore_malloc_tagged(strlen(buffer) + 1, MEM_TAG_EQUATIONS);
    kore_strlcpy(equations_ptr, buffer, strlen(buffer) + 1);
    equations_line_count = kore_split_string(equations_ptr, "\n", equations_test, MAX_EQUATIONS);
    kore_log(LOG_NOTICE, "%s: equations", equations_test[0]);
    for (int i = 0; i < equations_line_count; i++) {
      if (equations_test[i] != NULL) {
        memset(equations[i],'\0', MAX_EQUATIONS_LEN);
        // kore_log(LOG_NOTICE, "%s: connected", equations[i]);
	//char test_var[128] = "katex.render(\"c = \\pm\\sqrt{a^2 + b^2}\", {throwOnError: false});";
        //sprintf(equations[i], "<tr><td>%s</td></tr>", test_var);
        sprintf(equations[i], "<tr><td>%s</td></tr>", equations_test[i]);
      }
    }
    close(fd);
    munmap(buffer, s.st_size);
  }
}

return (KORE_RESULT_OK);
}

void json_print(unsigned char *s) {
  if (*s == '\"')
    s++;
  while (*s && *s != ',' && *s != '{' && *s != '[' && *s != ']' && *s != '}' &&
         *s != '\"' && *s != '\r' && *s != '\n')
    putchar(*s++);
}

void json_dump(const char *jsonstr) {
  unsigned char *c = (unsigned char *)jsonstr, *k[33], *v;
  int l = 0, j = 1, i, n, x[33] = {0};
  if (!jsonstr || !jsonstr[0])
    return;
  while (1) {
    while (*c && *c <= ' ')
      c++;
    if (j) {
      j = 0;
      k[l] = v = c;
    }
    switch (*c) {
    case '\"':
      c++;
      while (*c && *c != '\"') {
        if (*c == '\\') {
          c++;
        }
        c++;
      }
      break;
    case ':':
      c++;
      while (*c && *c <= ' ') {
        c++;
      }
      v = c--;
      break;
    case 0:
    case ',':
    case '{':
    case '[':
    case '}':
    case ']':
      if (*v != ',' && *v != '{' && *v != '[' && *v != ']' && *v != '}') {
        n = k[0][0] == '{' ? 1 : 0;
        /* print path */
        for (i = n; i <= l; i++) {
          if (i != n)
            printf(".");
          if (k[i][0] == '\"' && k[i] != v)
            json_print(k[i]);
          else
            printf("%d", x[i]);
        }
        /* print value */
        printf("\t\t");
        json_print(v);
        printf("\n");
      }
      switch (*c) {
      case 0:
        return;
      case '{':
      case '[':
        x[++l] = 0;
        if (l >= sizeof(x) - 1)
          return NULL;
        break;
      case '}':
      case ']':
        l--;
        break;
      case ',':
        x[l]++;
        break;
      }
      j++;
      break;
    }
    c++;
  }
}

struct MemoryStruct {
  char *memory;
  size_t size;
};

static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb,
                                  void *userp) {
  size_t realsize = size * nmemb;
  struct MemoryStruct *mem = (struct MemoryStruct *)userp;

  char *ptr = realloc(mem->memory, mem->size + realsize + 1);
  if (!ptr) {
    /* out of memory! */
    printf("not enough memory (realloc returned NULL)\n");
    return 0;
  }

  mem->memory = ptr;
  memcpy(&(mem->memory[mem->size]), contents, realsize);
  mem->size += realsize;
  mem->memory[mem->size] = 0;

  return realsize;
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
  // char filename[120];
  int line_count = 0;
  int row_count = 0;
  int test_buffer_idx = 0;
  size_t author_idx = 0;
  size_t len2;
  struct kore_buf *buf;
  u_int8_t *data2;
  buf = kore_buf_alloc(10 * 1024 * 1024);
  int search_titles = 0;
  int search_authors = 0;
  int search_affiliations = 0;
  int search_equations = 0;
  int search_citations = 0;
  char search_state[SEARCH_STATES];
  memset(search_state, '\0', SEARCH_STATES);
  strncpy(search_state, data, SEARCH_STATES);
  // kore_log(LOG_NOTICE, "%s",(char *)&data[SEARCH_STATES]);

  if (search_state[0] == '1') {
    for (int i = 0; i < title_line_count; i++) {
      if (title_test[i] != NULL) {
        if (refind(title_test[i], &data[SEARCH_STATES]) == 0) {
          row_count++;
          if (row_count > 1000) {
            break;
          }
          kore_buf_append(buf, title[i], strlen(title[i]));
        }
      }
    }
  }

  if (search_state[1] == '1') {
    for (int i = 0; i < author_line_count; i++) {
      if (author_test[i] != NULL) {
        if (refind(author_test[i], &data[SEARCH_STATES]) == 0) {
          row_count++;
          if (row_count > 1000) {
            break;
          }
          kore_buf_append(buf, author[i], strlen(author[i]));
        }
      }
    }
  }

  if (search_state[2] == '1') {
    for (int i = 0; i < affiliation_line_count; i++) {
      if (affiliation_test[i] != NULL) {
        if (refind(affiliation_test[i], &data[SEARCH_STATES]) == 0) {
          row_count++;
          if (row_count > 1000) {
            break;
          }
          kore_buf_append(buf, affiliation[i], strlen(affiliation[i]));
        }
      }
    }
  }

  if (search_state[3] == '1') {
    for (int i = 0; i < equations_line_count; i++) {
      if (equations_test[i] != NULL) {
        if (refind(equations_test[i], &data[SEARCH_STATES]) == 0) {
          row_count++;
          if (row_count > 500) {
            break;
          }
          kore_buf_append(buf, equations[i], strlen(equations[i]));
        }
      }
    }
  }

  if (search_state[4] == '1') {
    for (int i = 0; i < citations_line_count; i++) {
      if (citations_test[i] != NULL) {
        if (refind(citations_test[i], &data[SEARCH_STATES]) == 0) {
          row_count++;
          if (row_count > 1000) {
            break;
          }
          kore_buf_append(buf, citations[i], strlen(citations[i]));
        }
      }
    }
  }

  CURL *curl_handle;
  CURLcode res;

  struct MemoryStruct chunk;

  chunk.memory = malloc(1); /* will be grown as needed by the realloc above */
  chunk.size = 0;           /* no data at this point */

  curl_global_init(CURL_GLOBAL_ALL);

  /* init the curl session */
  curl_handle = curl_easy_init();

  /* specify URL to get */
  curl_easy_setopt(curl_handle, CURLOPT_URL,
                   "http://159.223.177.134:3000/equation?limit=1");

  /* send all data to this function  */
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);

  /* we pass our 'chunk' struct to the callback function */
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *)&chunk);

  /* some servers do not like requests that are made without a user-agent
     field, so we provide one */
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");

  /* get it! */
  res = curl_easy_perform(curl_handle);

  /* check for errors */
  if (res != CURLE_OK) {
    fprintf(stderr, "curl_easy_perform() failed: %s\n",
            curl_easy_strerror(res));
  } else {
    /*
     * Now, our chunk.memory points to a memory block that is chunk.size
     * bytes big and contains the remote file.
     *
     * Do something nice with it!
     */
   
    kore_buf_append(buf,chunk.memory,chunk.size);
    /* cleanup curl stuff */
  curl_easy_cleanup(curl_handle);

  free(chunk.memory);

  /* we are done with libcurl, so clean it up */
  curl_global_cleanup();

  data2 = kore_buf_release(buf, &len2);
  kore_websocket_broadcast(c, op, data2, len2, WEBSOCKET_BROADCAST_GLOBAL);
  kore_free(data2);
}}

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
		resub(reply->element[j]->str,"assets/html/","",tmp_file_loc);
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
