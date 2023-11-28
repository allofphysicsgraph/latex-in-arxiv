#include <errno.h>
#include <math.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_FILE_SIZE 10000
#include "globals.h"

char results[1024];
/*
 *	memset(results,'\0',1024);
 *	resub("hello this is a pattern:       test:    again",":\\s+",": ");
 *	printf("%s",results);
 */

void resub(char *buffer, char *pattern, char *replacement) {
  int current_offset = 0;
  char current_buffer[MAX_FILE_SIZE];
  regex_t preg;
  regmatch_t substmatch[1];
  regcomp(&preg, pattern, REG_EXTENDED); // this assumes matching <
  current_offset = 0;
  memset(current_buffer, '\0', MAX_FILE_SIZE);
  strcpy(current_buffer, buffer);
  while (current_offset < strlen(buffer)) {
    if (regexec(&preg, current_buffer, 1, substmatch, 0) == 0) {
      memset(current_buffer, '\0', MAX_FILE_SIZE);
      strncpy(current_buffer, &buffer[current_offset], substmatch[0].rm_so);
      strcat(current_buffer, &buffer[current_offset + substmatch[0].rm_eo]);
      strncat(results, current_buffer, substmatch[0].rm_so);
      strcat(results, replacement);
      current_offset += substmatch[0].rm_eo;
      strcpy(current_buffer, &buffer[current_offset]);
    } else {
      strcat(results, current_buffer);
      break;
    }
  }
  regfree(&preg);
}
