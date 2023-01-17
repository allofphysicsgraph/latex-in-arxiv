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
int results_idx;
int n;

struct output {
	char	fname[10];
	char 	equation[RES_MAX_LEN];
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
		memset(sample.fname,'\0',10);
		memset(sample.equation,'\0',RES_MAX_LEN);
		memset(results,'\0',RES_MAX_LEN);
		results_idx=0;	
	}
	

	action inc { 
		results[results_idx]=fc;	
		results_idx++;
	}

	action print_str{
		if(strcmp(results,"\"")!=0 && strlen(results)>0){
			results[strlen(results)-1]='\0';
			if(fsm->cs<23){
				strcpy(sample.fname,results);
				printf("%s\n",sample.fname);
			} else {
				strcpy(sample.equation,results);
				printf("%s:%s\n",sample.fname,sample.equation);

			}
		}
	}
	fn = '"filename":"' . (digit{7} $inc) . '",'    ;
	equation = '"equation":'   ;
	ignore = (any+ - fn) ;
	inc = ([^\n]+ - equation) @inc ;
	nl = '\n'; 
	inc2 = ([^\n]+ ) @inc;
	mach = 
		start: ( 
			fn  -> st1 |
			ignore -> start |
			zlen -> final   
		),
		st1: ( 
			inc -> st1 |
			(equation >print_str $init_results) -> st2|	
			(nl >print_str $init_results) -> start |
			zlen -> final 
		),

		st2: (
			inc2 -> st1 |
			(nl >print_str $init_results) -> start |
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

void test( char *buf )
{
	int len = strlen( buf );
	state_chart_init( &sc );
	state_chart_execute( &sc, buf, len );
	state_chart_finish( &sc );
	printf("\n");
}

int main(int argc, char **argv) {
  memset(results,'\0',RES_MAX_LEN);
  test("\"filename\":\"0004057\",\"equation\":\"G^{\\mu\\nu\\alpha\\beta}(x - x') = \n");
  return 0;
}



