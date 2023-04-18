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
char results[100000];
int idx;

struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	action section { n--;
	if (idx > 0) {results[idx]='\n';idx++; };
	strncat(results,"\\begin{thebibliography}",strlen("\\begin{bibliography}")+1);
	idx+=strlen("\\begin{thebibliography}");
	}
	
	action inc { 
	if (idx > 0) {results[idx]='\n';idx++; };
	strncat(results,"\\bibliography{",strlen("\\bibliography{")+1);
	idx+=strlen("\\bibliography{");
	}
	
	begin = '\\begin{thebibliography}' @section;
	end = '\\end{thebibliography}' @{ printf("}"); fbreak; };
	ignore = (any+ - begin) ;
	keep = (any+ - end) @inc ;

	mach = 
		start: ( 
			begin -> st1 |
			ignore -> start |
			zlen -> final   
		),
		st1: ( 
			end -> st2 |
			keep -> st1 |	
			zlen -> final 
		),
		st2: ( 
			ignore  -> st2 |
			zlen -> final
		)
		
;
	
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

char*  test( char *buf )
{
	int len = strlen( buf );
	state_chart_init( &sc );
	state_chart_execute( &sc, buf, len );
	state_chart_finish( &sc );
	return results;
}




