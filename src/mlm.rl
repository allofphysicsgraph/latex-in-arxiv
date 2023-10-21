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
#define MAX_LEN 100
char filename[FN_MAX_LEN];
char results[MAX_LEN];
int results_idx;
char output[RES_MAX_LEN];
int n;


struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	
	action init_results {
		memset(results,'\0',MAX_LEN);
		results_idx=0;	
	}
	
	action inc { 
		results[results_idx]=fc;	
		results_idx++;
	}

	action save_str{
		strcat(output,results);	
		strcat(output,"\n");
	}
	dollar = '$' ;
	
	ignore = (any - dollar) ;
	inc = (any - dollar) @inc ;
	nl = '\n'; 
	mach = 
		start: ( 
			dollar  -> st1 |
			ignore -> start |
			zlen -> final   
		),
		st1: ( 
			dollar  -> st2 |
			ignore -> start |
			zlen -> final   
		),
		st2: ( 
			dollar  -> st3 |
			inc -> st2 |
			zlen -> final   
		),
		st3: ( 
			(dollar  $save_str  $init_results) -> start|
			ignore -> start |	
			(nl $init_results) -> start |
			zlen -> final 
		)
		
		;
	
	main := ( mach '\n' )*;
}%%

%% write data;

void init(){
	memset (results,'\0',MAX_LEN);
	memset (output,'\0',RES_MAX_LEN);
	results_idx = 0;
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
	return output;
}



