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
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <math.h>  
#include <stdio.h>
#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <kore/http.h>
#include <kore/kore.h>
#include <kore/seccomp.h>
#include "assets.h"
#include "shared.h"

int		page(struct http_request *);
int		websocket_message_connect(struct http_request *req);

void		websocket_connect(struct connection *);
void		websocket_disconnect(struct connection *);
void		websocket_message(struct connection *,
		    u_int8_t, void *, size_t);

void            websocket_author_search(struct connection *c, u_int8_t op, void *data, size_t len);



int		init(int);




struct output {
        char    fname[10];
        char    equation[1024];
};

extern struct output sample;


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
		kore_log(LOG_NOTICE, "%p: connected", c);
}


void websocket_author_search(struct connection *c, u_int8_t op, void *data,
                             size_t len) {

  kore_log(LOG_NOTICE, "%s:\n", (char *)data);
  size_t len2;
  struct kore_buf *buf;
  u_int8_t *data2;
  buf = kore_buf_alloc(10 * 1024 * 1024);


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
                   "http://127.0.0.1:3000/equation?limit=10");

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
    
	  
#define BUF_MAX_LEN 100000

	memset(buffer,'\0',BUF_MAX_LEN);

    char *test_out[2048];
    int test_count;
    char html[2048];
    char tmp_buff[100000];
    memset(tmp_buff,'\0',100000);
    test_count = kore_split_string(chunk.memory, "\n", test_out, 100);
    for(int i=0;i<test_count;i++){
	   memset(html,'\0',2048);
	   test(test_out[i]);
	ragel_init();
	unescape_tex(sample.equation,strlen(sample.equation));
	finish();
	   sprintf(html,"<tr><td>%s</td><td>$$%s$$</td></tr>",sample.fname,&buffer[1]);
    	   kore_buf_append(buf,html,strlen(html));
	}
    /* cleanup curl stuff */
  curl_easy_cleanup(curl_handle);

  free(chunk.memory);

  /* we are done with libcurl, so clean it up */
  curl_global_cleanup();

  data2 = kore_buf_release(buf, &len2);
  kore_websocket_broadcast(c, op, data2, len2, WEBSOCKET_BROADCAST_GLOBAL);
  kore_free(data2);
}}



void
websocket_disconnect(struct connection *c)
{
	kore_log(LOG_NOTICE, "%p: disconnecting", c);
}

int
page(struct http_request *req)
{
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

