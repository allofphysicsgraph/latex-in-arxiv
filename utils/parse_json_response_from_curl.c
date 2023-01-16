// https://gitlab.com/bztsrc/jsonc
#include <ctype.h>
#include <curl/curl.h>
#include <err.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

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

int main(void) {
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
                   "http://159.223.177.134:3000/equation?limit=100");

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

    json_dump(chunk.memory);

    printf("%lu: bytes retrieved\n", (unsigned long)chunk.size);
  }

  /* cleanup curl stuff */
  curl_easy_cleanup(curl_handle);

  free(chunk.memory);

  /* we are done with libcurl, so clean it up */
  curl_global_cleanup();

  return 0;
}

