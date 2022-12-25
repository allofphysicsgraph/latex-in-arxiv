#include <string.h>
#include <regex.h>
#define MAX_FILE_SIZE 120000
int refind(char *buffer, char *pattern) {
  int current_offset = 0;
  char current_buffer[MAX_FILE_SIZE];
  regex_t preg;
  regmatch_t substmatch[1];
  regcomp(&preg, pattern, REG_EXTENDED); // this assumes matching <
  current_offset = 0;
  memset(current_buffer, '\0', MAX_FILE_SIZE);
  strcpy(current_buffer, buffer);
   if (regexec(&preg, current_buffer, 1, substmatch, 0) == 0) {
   regfree(&preg);	
	   return 0; 
   } else {
	   regfree(&preg);
  return -1;
  }}

