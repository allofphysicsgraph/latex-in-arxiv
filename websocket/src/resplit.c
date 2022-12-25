#include <errno.h>
#include <math.h>
#include <regex.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ARRAY_SIZE(arr) (sizeof((arr)) / sizeof((arr)[0]))

void resplit(char * str, char* re) {
//static const char *const str =
    "1) John Driverhacker;\n2) John Doe;\n3) John Foo;\n";
//static const char *const re = "John.*o";

  char *s = str;
  regex_t regex;
  regmatch_t pmatch[1];
  regoff_t off, len;

  if (regcomp(&regex, re, REG_NEWLINE))
    exit(EXIT_FAILURE);

  printf("Matches:\n");

  for (unsigned int i = 0;; i++) {
    if (regexec(&regex, s, ARRAY_SIZE(pmatch), pmatch, 0))
      break;

    off = pmatch[0].rm_so + (s - str);
    len = pmatch[0].rm_eo - pmatch[0].rm_so;
    printf("#%zu:\n", i);
    printf("offset = %jd; length = %jd\n", (intmax_t)off, (intmax_t)len);
    printf("substring = \"%.*s\"\n", len, s + pmatch[0].rm_so);

    s += pmatch[0].rm_eo;
  }
}
