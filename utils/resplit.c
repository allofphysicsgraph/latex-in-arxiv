/*
==32186== Memcheck, a memory error detector
==32186== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
==32186== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
==32186== Command: ./a.out
==32186==
he:o:==32186==
==32186== HEAP SUMMARY:
==32186==     in use at exit: 0 bytes in 0 blocks
==32186==   total heap usage: 68 allocs, 68 frees, 14,612 bytes allocated
==32186==
==32186== All heap blocks were freed -- no leaks are possible
==32186==
==32186== For lists of detected and suppressed errors, rerun with: -s
==32186== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
*/

#include <errno.h>
#include <math.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_SPLITS 100
#define MAX_LINE_LEN 100
#define MAX_FILE_SIZE 10000

int count;
char dst[MAX_SPLITS][MAX_LINE_LEN];

void resplit(char *buffer, char *pattern, int *count,
             char (*dst)[MAX_LINE_LEN]) {
  char current_buffer[MAX_FILE_SIZE];
  regex_t preg;
  regmatch_t substmatch[1];
  regcomp(&preg, pattern, REG_EXTENDED); // this assumes matching <
  memset(current_buffer, '\0', MAX_FILE_SIZE);
  strcpy(current_buffer, buffer);
  if (regexec(&preg, current_buffer, 1, substmatch, 0) == 0) {
    memset(current_buffer, '\0', MAX_FILE_SIZE);
    strncpy(current_buffer, buffer, substmatch[0].rm_so);
    if (strlen(current_buffer) > 0) {
      memset(dst[*count], '\0', MAX_LINE_LEN);
      strcpy(dst[*count], current_buffer);
      (*count)++;
    }
    memset(current_buffer, '\0', MAX_FILE_SIZE);
    strcpy(current_buffer, &buffer[substmatch[0].rm_eo]);
    regfree(&preg);
    resplit(current_buffer, pattern, count, dst);
  } else {
    memset(dst[*count], '\0', MAX_LINE_LEN);
    strcpy(dst[*count], buffer);
    (*count)++;
    regfree(&preg);
  }
}

int main() {
  resplit("xxlo \\frac{1}{2}this is hello hllo", "\\frac", &count, dst);
  for (int i = 0; i < count; i++) {
    printf("<%s>", dst[i]);
  }
  return 0;
}
