#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
int n;

char *pe;
char *eof;
int stack [1024];
%%{
	machine foo;
	action print_fc {
		printf("%c",fc);
	}

	action print_nl {
		printf("\n");
	}

	B_Abstract = '\\begin{abstract}' @{ printf("\\begin{abstract}"); }  ;
	ignore_abstract = any* - B_Abstract;
	E_Abstract = '\\end{abstract}' @print_fc @print_nl; 
	incl_abstract = (any+ - E_Abstract) $print_fc ;


	action balanced {n == 1 } 
	action inc_n { n++ ; }
	action dec_n { n--;  }
	action print_n {
		printf(":%i:",n);
	}

	B_Equation = '\\begin{equation}' @inc_n  @{ if(n==1) printf("\n\\begin{equation}"); }  ;
	ignore_eq = any* - B_Equation;
	E_Equation = '\\end{equation}' @dec_n  @print_fc @{ if(n==1) printf("\n"); }; 
	incl_eq = (any+ - E_Equation) $print_fc ;

	B_TheBibliography = '\\begin{thebibliography}' @inc_n  @{ if(n==1) printf("\n\\begin{thebibliography}"); }  ;
	ignore_tb = any* - B_TheBibliography;
	E_TheBibliography = '\\end{thebibliography}' @dec_n  @print_fc @{ if(n==1) printf("\n"); }; 
	incl_tb = (any+ - E_TheBibliography) $print_fc ;

	abstract = (ignore_abstract . B_Abstract . incl_abstract? :>>  E_Abstract ); 
	equation = (ignore_eq . (B_Equation . (incl_eq|B_Equation){,5} :>>  E_Equation when balanced @{printf("\n"); fgoto main;} )); 
	thebibliography = (ignore_tb . B_TheBibliography . incl_tb? :>>  E_TheBibliography ); 

	main:= (abstract|equation|thebibliography);

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

