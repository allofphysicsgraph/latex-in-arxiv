/* 
 * @LANG: c++
 */

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

	action inc {c++; }
	action dec {c--; }
	action balanced { c == 0}
	action print_fc {printf("%c",fc);}
	action init_c { c = 0;}
	action done { printf("***************\ndone\n***********"); }
	begin_abstract = '\\begin{abstract}' @inc  @{ printf("\\begin{abstract}"); };
	end_abstract = '\\end{abstract}'  @dec @{ printf("}"); } ;

	# The any* includes '\n' when hit_5 is true, so use guarded concatenation.
	main :=   (any-begin_abstract)* . begin_abstract . any* @print_fc :>> end_abstract  :> any* when balanced  ;
}%%

%% write data noerror;

void test( const char *str )
{
	int cs = foo_start;
	int c = 0;
	const char *p = str;
	const char *pe = str + strlen( str );
	%% write exec;
	if ( cs >= foo_first_final )
		printf(" \n success \n");
	else
		printf(" \n failure \n");
}

int main(int argc, char** argv) {
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
    test(buffer);
    munmap(buffer, s.st_size);
  }
  close(fd);
return 0;
}

