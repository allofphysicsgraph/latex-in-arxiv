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

#define RES_MAX_LEN 100000
char results[RES_MAX_LEN];
int n;
const char* pattern="\\section";
int idx;
struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	action section { n--; 
		strcat(results,pattern);
		idx+=strlen(pattern);
	}

	action b { 
	results[idx]=fc;
	idx++;
	n++; if(n==0){
	}
	}

	
	action c { n--; 
	results[idx]=fc;
	idx++;
	}
	
	action inc { 
	results[idx]=fc;
	idx++;
	}
	
	action balanced { n == -1 }
	action not_balanced {n != -1}	
	
	section = '\\section{' @section;

	b = '}' @b;
	ws = ' '+;
        c = '{' @c;
	nl = '\n' @{printf(" ");};
	ignore = (any+ - section) ;
	keep = (any+ - section) @inc ;
	inc = ([^\n] - b) @inc ;

	mach = 
		start: ( 
			section-> st1 |
			ignore -> start |
			zlen -> final   
		),
		st1: ( 
			(b when balanced) -> st2 |
			(b when not_balanced) -> st1 | 
			c -> st1 | 	
			inc -> st1 |	
			nl -> st1 |
			section -> st2|
			zlen -> final 
		),
		st2: ( 
			keep -> st2|
			nl -> st2 |
			section -> st1 |
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

char * test( char *buf )
{
	int len = strlen( buf );
	state_chart_init( &sc );
	state_chart_execute( &sc, buf, len );
	state_chart_finish( &sc );
	return results;
}




