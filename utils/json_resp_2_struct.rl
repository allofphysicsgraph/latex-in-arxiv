/*
 * @LANG: c
 */

/*
 * Test in and out state actions.
 */


#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <kore/kore.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#define FN_MAX_LEN 1024
char filename[FN_MAX_LEN];
char results[1024];
int results_idx;
int n;

struct output {
	char	fname[10];
	char 	equation[1024];
};


struct output sample;
struct state_chart
{
	int cs;
};

%%{
	machine state_chart;
	variable cs fsm->cs;

	
	action init_results {
		memset(results,'\0',1024);
		results_idx=0;	
	}
	
	
	action init_res {
		memset(results,'\0',1024);
		results_idx=0;	
	}

	action inc { 
			//printf(":%i:%s\n",fsm->cs,results);
		results[results_idx]=fc;	
		results_idx++;
	}

	action save_filename{
		strncpy(sample.fname,results,strlen(results));
	}
	action save_equation{
		strcpy(sample.equation,&results[7]);
	}

	action print_results {
		printf("%s",results);
	}	

	newline = '\n';
	ws = [ \t];
	fn = ( ws* '['? '{"filename":"' >init_results) . (digit{7}  $inc) @save_filename . '","equation":'    ;
	inc = (any+ - newline) @inc ;
	mach =  (
		start: ( 
			fn -> st1|
			zlen -> final   
		),
		st1: (
			inc -> st1 |
			(zlen >save_equation) -> final
		)
	);	
	main :=  mach  ;
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
	const char *eof = pe;
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
}





