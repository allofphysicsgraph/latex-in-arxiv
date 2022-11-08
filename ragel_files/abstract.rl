#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

%%{
	machine foo;
	action print_fc {
		printf("%c",fc);
	}
	t = '\\begin{abstract}' @{ printf("\\begin{abstract}"); }  ;
	ignore = any* - t;
	e = '\\end{abstract}' @print_fc; 
	incl = (any+ - e) $print_fc ;
	main := ignore . t . incl? :>>  e;
}%%

%% write data;

	

int main(int argc, char **argv) {
  struct stat s;
  char *buffer;
  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */
  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {
	int cs,res=0;
	char *p = buffer;
	char *pe = p + strlen(p) + 1;
	%% write init;
	%% write exec;
    munmap(buffer, s.st_size);
  }
  close(fd);
return 0;
}

