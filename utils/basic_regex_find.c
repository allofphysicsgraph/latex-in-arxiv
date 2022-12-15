#include <errno.h>
#include <math.h>  
#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <regex.h>
#define MAX_FILE_SIZE 10000

char results[1024];
/*	
*	memset(results,'\0',1024);
*	resub("hello this is a pattern:       test:    again",":\\s+",": ");
*	printf("%s",results);
*/

void refind(char *buffer, char *pattern,char* replacement) {
  int current_offset = 0;
  char current_buffer[MAX_FILE_SIZE];
  regex_t preg;
  regmatch_t substmatch[1];
  regcomp(&preg, pattern, REG_EXTENDED); // this assumes matching <
  current_offset = 0;
  memset(current_buffer, '\0', MAX_FILE_SIZE);
  strcpy(current_buffer, buffer);
  while (current_offset < strlen(buffer)) {
   printf("%d",current_offset);
   if (regexec(&preg, current_buffer, 1, substmatch, 0) == 0) {
      memset(current_buffer, '\0', MAX_FILE_SIZE);
      strncpy(results, buffer,current_offset+substmatch[0].rm_so+(substmatch[0].rm_eo-substmatch[0].rm_so));
      printf("%s\n",results);
      memset(results,'\0',1024); 
      current_offset += substmatch[0].rm_so+1;
      strcpy(current_buffer, &buffer[current_offset]);
    } else {
	    current_offset++;
      break;
    }
  }
  regfree(&preg);
}

int main(int argc, char** argv){
	memset(results,'\0',1024);
	refind("hello this is a pattern:       test:    again",argv[1],": ");
	printf("%s",results);
	return 0;
}
