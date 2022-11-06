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

int n;

struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	action author { n--; printf("\\author{");}
	action title { n--; printf("\\title{");}
	action affiliation { n--; printf("\\affiliation{");}
	action b { printf("%c",fc); n++; if(n==0){
		printf("\n");}
	}

	
	action begin_abstract { n--; printf("\\begin{abstract}");}
	action end_abstract { n++; printf("\\end{abstract}");}
	

	action c { n--; printf("%c",fc);}
	action inc { 
	printf("%c",fc); }
	action balanced { n == -1 }
	action not_balanced {n != -1}	
	
	author = '\\author{' @author;
	title = '\\title{' @title;
	affiliation = '\\affiliation{' @affiliation;
	begin_abstract = '\\begin{abstract}' @begin_abstract;
	end_abstract = '\\end{abstract}' @end_abstract;

	b = '}' @b;
	ws = ' '+;
        c = '{' @c;
	ignore = (any+ - author) ;
	ignore_abstract = (any+ - end_abstract) @inc ;
	inc = (any - b) @inc ;
 
	mach = 
		start: ( 
			author -> st1 |
			affiliation -> st1 | 
			title -> st1 | 
			ignore -> start |
			zlen -> final 
		),
		st1: ( 
			(b when balanced) -> start |
			(b when not_balanced) -> st1 | 
			c -> st1 | 	
			inc -> st1 |	
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



