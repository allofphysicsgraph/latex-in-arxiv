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
#define MAX_LEN 10000
char results[MAX_LEN];
int idx;

struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	action url { n--; 
	if (idx > 0) {results[idx]='\n';idx++; };
	strncat(results,"\\url{",strlen("\\url{")+1);
	idx+=strlen("\\url{");
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
	
	url = '\\url{' @url;

	b = '}' @b;
	ws = ' '+;
        c = '{' @c;
	nl = '\n' @{printf(" ");};
	ignore = (any+ - url) ;
	inc = ([^\n] - b) @inc ;
 
	mach = 
		start: ( 
			url -> st1 |
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

void init(){
	idx = 0;
	int n = 0;
	memset(results,'\0',MAX_LEN);
}

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




