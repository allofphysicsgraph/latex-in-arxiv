#include <string.h>
#include <stdio.h> 

struct output {
	char	fname[10];
	char 	equation[1024];
};

extern struct output sample;

int main(int argc, char **argv) {
  // memset(results,'\0',RES_MAX_LEN);
  test("\"filename\":\"0004057\",\"equation\":\"G^{\\mu\\nu\\alpha\\beta}(x - x') = \n");
  printf("%s\n:%s",sample.fname,sample.equation);
  return 0;
}



