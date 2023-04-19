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

char results[10000];
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
	begin_abstract = '\\begin{abstract}' @inc  @{ 
	strncat(results,"\\begin{abstract}",strlen("\\begin{abstract}")+1);
	idx+=strlen("\\begin{abstract}");
	};
	end_abstract = '\\end{abstract}'  @dec @{ 
	char matched_string[64];
	memset(matched_string,'\0',64);
	strcpy(matched_string,"\\end{abstract}");
	strncat(results,"}",2);
	idx++;
	if (idx > 0) {results[idx]='\n';idx++; };
	};
	newline = '\n' @{printf(" ");};
	main :=  ( (any-begin_abstract)* . begin_abstract . (((any-newline) @print_fc)|newline)*  :>> end_abstract  @done :> any* when balanced )+   ;
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
		printf("ABSTRACT OK\n");
	else
		printf("ABSTRACT FAILED\n");
	return results;
}