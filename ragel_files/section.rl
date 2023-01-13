/*
 * @LANG: c
 */

/*
 * Test in and out state actions.
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

#define FN_MAX_LEN 1024
#define RES_MAX_LEN 10000
char filename[FN_MAX_LEN];
char results[RES_MAX_LEN];
int n;

struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	action section { n--; printf("\n%s:\\section{",filename);}
	action b { printf("%c",fc); n++; if(n==0){
	}
	}

	
	action c { n--; printf("%c",fc);}
	action inc { 
	printf("%c",fc); }
	action balanced { n == -1 }
	action not_balanced {n != -1}	
	
	section = '\\section{' @section;

	b = '}' @b;
	ws = ' '+;
        c = '{' @c;
	nl = '\n' @{printf(" ");};
	ignore = (any+ - section) ;
	inc = ([^\n] - b) @inc ;
 
	mach = 
		start: ( 
			section -> st1 |
			ignore -> start |
			zlen -> final   
		),
		st1: ( 
			(b when balanced) -> start |
			(b when not_balanced) -> st1 | 
			c -> st1 | 	
			inc -> st1 |	
			nl -> st1 |
			zlen -> final 
		),
		st2: ( 
			zlen -> final
		);
	
	main := ( mach '\n' )*;
}%%

%% write data;

void state_chart_init( struct state_chart *fsm )
{
	%% write init;
}

void state_chart_execute( struct state_chart *fsm, const char *_data, int _len )
{
	const char *p = _data;
	const char *pe = _data+_len;

	%% write exec;
}

int state_chart_finish( struct state_chart *fsm )
{
	if ( fsm->cs == state_chart_error )
		{ printf("ERR");return -1; }
	if ( fsm->cs >= state_chart_first_final )
		return 1;
	return 0;
}

struct state_chart sc;

void test( char *buf )
{
	int len = strlen( buf );
	state_chart_init( &sc );
	state_chart_execute( &sc, buf, len );
	state_chart_finish( &sc );
	printf("\n");
}

int main(int argc, char **argv) {
  struct stat s;
  char *buffer;
  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  strncpy(filename, argv[1], FN_MAX_LEN);

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



