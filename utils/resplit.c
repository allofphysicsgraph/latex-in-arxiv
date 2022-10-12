/*==88561== Memcheck, a memory error detector
*==88561== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
*==88561== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
*==88561== Command: ./a.out
*==88561== 
*:hle:lg==88561== 
*==88561== HEAP SUMMARY:
*==88561==     in use at exit: 0 bytes in 0 blocks
*==88561==   total heap usage: 66 allocs, 66 frees, 15,376 bytes allocated
*==88561== 
*==88561== All heap blocks were freed -- no leaks are possible
*==88561== 
*==88561== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
*/

#include <errno.h>
#include <math.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_FILE_SIZE 10000

void resplit(char *buffer, char *pattern) {
  char current_buffer[MAX_FILE_SIZE];
  regex_t preg;
  regmatch_t substmatch[1];
  regcomp(&preg, pattern, REG_EXTENDED); // this assumes matching <
  memset(current_buffer, '\0', MAX_FILE_SIZE);
  strcpy(current_buffer, buffer);
  if (regexec(&preg, current_buffer, 1, substmatch, 0) == 0) {
    memset(current_buffer, '\0', MAX_FILE_SIZE);
    strncpy(current_buffer, buffer, substmatch[0].rm_so);
    printf(":%s:", current_buffer);
    memset(current_buffer, '\0', MAX_FILE_SIZE);
    strcpy(current_buffer, &buffer[substmatch[0].rm_eo]);
    regfree(&preg);
    resplit(current_buffer, pattern);
  } else {
    printf("%s", buffer);
    regfree(&preg);
  }
}

int main() {
  resplit("hlelolg", "lo");
  return 0;
}
