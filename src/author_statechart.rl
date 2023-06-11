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
char results[10000];
int idx;
struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	action author { n--;
	if (idx > 0) {results[idx]='\n';idx++; };
	strncat(results,"\\author{",strlen("\\author{")+1);
	idx+=strlen("\\author{");
	}
	action title { n--; 
	if (idx > 0) {results[idx]='\n';idx++; };
	strncat(results,"\\title{",strlen("\\title{")+1);
	idx+=strlen("\\title{");
	}

	action affiliation { n--; 
	if (idx > 0) {results[idx]='\n';idx++; };
	strncat(results,"\\affiliation{",strlen("\\affiliation{")+1);
	idx+=strlen("\\affiliation{");
	}
	action b { 
		results[idx]=fc;
		idx++;
		n++; 
		if(n==0){
			printf("\n");
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
	
	author = '\\author{' @author;
	title = '\\title{' @title;
	affiliation = '\\affiliation{' @affiliation;

	b = '}' @b;
	ws = ' '+;
        c = '{' @c;
	nl = '\n' @{printf(" ");};
	ignore = (any+ - author) ;
	inc = ([^\n] - b) @inc ;
 
	mach = 
		start: ( 
			title -> st1 |
			affiliation -> st1 | 
			author -> st1 |
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

char* test( char *buf )
{
	int len = strlen( buf );
	state_chart_init( &sc );
	state_chart_execute( &sc, buf, len );
	state_chart_finish( &sc );
	return results;
}




