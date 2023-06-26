/* 
 * @LANG: c++
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
#define MAX_LEN 10000
char results[MAX_LEN];
int idx;
%%{
	machine foo;

	action inc {c++; }
	action dec {c--; }
	action balanced { c == 0}
	action print_fc {
		if (fc != '\n'){
			results[idx]=fc;
			idx++;
		}
	}
	action init_c { c = 0;}
	action done { printf(""); }
	begin_algorithm = '\\begin{algorithm}' @inc  @{ 
	strncat(results,"\\begin{algorithm}",strlen("\\begin{algorithm}")+1);
	idx+=strlen("\\begin{algorithm}");
	};
	end_algorithm = '\\end{algorithm}'  @dec @{ 
	char matched_string[64];
	memset(matched_string,'\0',64);
	strcpy(matched_string,"\\end{algorithm}");
	strncat(results,"}",2);
	idx++;
	if (idx > 0) {results[idx]='\n';idx++; };
	};
	newline = '\n' @{printf(" ");};
	main :=  ( (any-begin_algorithm)* . begin_algorithm . (((any-newline) @print_fc)|newline)*  :>> end_algorithm  @done :> any* when balanced )+   ;
}%%

%% write data noerror;

char* test( const char *str )
{
	int cs = foo_start;
	int c = 0;
	const char *p = str;
	const char *pe = str + strlen( str );
	%% write exec;
	if ( cs >= foo_first_final )
		printf("EQUATION OK\n");
	else
		printf("EQUATION FAILED\n");
	return results;
}
void init(){
	idx = 0;
	memset(results,'\0',MAX_LEN);
}

