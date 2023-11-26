#include <regex.h>
#include <string.h>
#include <stdio.h>

int resub(char *buffer, char *pattern) {
  regex_t preg;
  regmatch_t match[1];
  regcomp(&preg, pattern, REG_EXTENDED); // this assumes matching 
    if (regexec(&preg, buffer, 1, match, 0) == 0) {
  	regfree(&preg);
    	return 0;	    
    } else {
  	regfree(&preg);
    	return 1;
    }
  regfree(&preg);
  return -1;
}

int main(){

	printf("%d\n",resub("hello","a"));
	return 0;
}
