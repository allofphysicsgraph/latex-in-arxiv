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
#define MAX_FILE_COUNT 10000

int		page(struct http_request *);
int		page_ws_connect(struct http_request *);

void		websocket_connect(struct connection *);
void		websocket_disconnect(struct connection *);
void		websocket_message(struct connection *,
		    u_int8_t, void *, size_t);

/* Called whenever we get a new websocket connection. */
void
websocket_connect(struct connection *c)
{
	kore_log(LOG_NOTICE, "%p: connected", c);
}

void
parse_latex(char* fileName ){

	YY_BUFFER_STATE buf;
        char* buffer = ReadFile(fileName);
	char test_buffer[100000];
	memset(test_buffer,'\0',100000);
        buf = yy_scan_string(buffer);
        yy_switch_to_buffer(buf);
        FILE *fp;
	fp = fopen("out_file","w");
	yyout=fp;
        yylex();
        fclose(fp);	
}

void find_files(){
  char *array[MAX_FILE_COUNT];
  int i = 0;
  int array_index = 0;
  memset(array, 0, sizeof(array));
  int r = walk_dir(".", "\\.c$", WS_DEFAULT | WS_MATCHDIRS, array, array_index);
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
  i = 0;
  while (array[i] != NULL) {
    printf("%s\n", array[i]);
    free(array[i]);
    i++;
  }
}

void
websocket_message(struct connection *c, u_int8_t op, void *data, size_t len)
{
        parse_latex("test.txt");
      	char* parsed = ReadFile("out_file");
	kore_websocket_broadcast(c, op, (void *)parsed, strlen(parsed) , WEBSOCKET_BROADCAST_GLOBAL);
}

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
page_ws_connect(struct http_request *req)
{
	/* Perform the websocket handshake, passing our callbacks. */
	kore_websocket_handshake(req, "websocket_connect",
	    "websocket_message", "websocket_disconnect");

	return (KORE_RESULT_OK);
}
