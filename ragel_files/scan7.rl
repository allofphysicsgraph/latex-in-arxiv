/*
 * @LANG: c
 */

#include <string.h>
#include <stdio.h>

/*
 * DEMONSTRATS FAILURE TO CALL LEAVING ACTIONS
 * leave on lag not called
 * leave swith3a not called
 */

char * ts ;
char * te ;
int act ;
int token ;

%%{
	machine scanner;


	# Warning: changing the patterns or the input string will affect the
	# coverage of the scanner action types.
	main := |*
		'\\\\' => { 
			buffer[idx]='\\';
			idx++;
		};

		'},' zlen  => {};
	
		'"}]' zlen  => {};

		/^/'"' => {};		

		/^\s+/ => {};

		'"' zlen {};

		(any-'\n') => { 
			buffer[idx]=fc;
			idx++;
		};
		
	*|  ;
}%%


%% write data;
int cs;
int blen;
#define BUF_MAX_LEN 100000
extern char buffer[BUF_MAX_LEN];
int idx;
void ragel_init(){

	%% write init;
	idx=0;
	memset(buffer,'\0',BUF_MAX_LEN);
}

void  unescape_tex( char *data, int len )
{
	char *p = data;
	char *pe = data + len;
	char *eof = pe;
	%% write exec;
}

void finish( )
{
	if ( cs >= scanner_first_final )
		printf( "ACCEPT\n" );
	else
		printf( "FAIL\n" );
}

