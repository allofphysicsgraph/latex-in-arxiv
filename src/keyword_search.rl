/*
 * @LANG: c
 */
#include <string.h>
#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>


int scan(const char *in);
%%{
	machine part_token;
	main := |*

'\\begin{document}' => { 
	printf("token:%s:%zd:%zd\n", "\\begin{document}",ts-in,te-in);
 };

'\\begin{abstract}' => { 
	printf("token:%s:%zd:%zd\n", "\\begin{abstract}",ts-in,te-in);
 };


any => {};

	*|;
}%%

%% write data;

int scan(const char *in)
{
	int cs = 0, act = 0;
	const char *p = in;
	const char *pe = in + strlen(in);
	const char *ts = NULL, *te = NULL;
	const char *eof = pe;

	%% write init;
	%% write exec;


	if (cs == part_token_error)
		printf("Error near %zd\n", p-in);
	else if(ts)
		printf("offsets: ts %zd te: %zd pe: %zd\n", ts-in, te-in, pe-in);

	return EXIT_SUCCESS;
}


int main(int argc, char **argv) {
  int cs, res = 0;
  struct stat s;
  void *buff;
  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    	scan((char*)buff);
	munmap(buff, s.st_size);
  }
  close(fd);
  return 0;
}

