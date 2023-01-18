
#line 1 "json_resp_2_struct.rl"
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


#line 87 "json_resp_2_struct.rl"



#line 47 "json_resp_2_struct.c"
static const char _state_chart_actions[] = {
	0, 1, 0, 1, 1, 1, 3, 2, 
	1, 2
};

static const char _state_chart_key_offsets[] = {
	0, 0, 4, 5, 6, 7, 8, 9, 
	10, 11, 12, 13, 14, 15, 16, 17, 
	19, 21, 23, 25, 27, 29, 31, 32, 
	33, 34, 35, 36, 37, 38, 39, 40, 
	41, 42, 43, 44, 44, 48, 49
};

static const char _state_chart_trans_keys[] = {
	9, 32, 91, 123, 123, 34, 102, 105, 
	108, 101, 110, 97, 109, 101, 34, 58, 
	34, 48, 57, 48, 57, 48, 57, 48, 
	57, 48, 57, 48, 57, 48, 57, 34, 
	44, 34, 101, 113, 117, 97, 116, 105, 
	111, 110, 34, 58, 9, 32, 91, 123, 
	10, 0
};

static const char _state_chart_single_lengths[] = {
	0, 4, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 0, 
	0, 0, 0, 0, 0, 0, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 0, 4, 1, 0
};

static const char _state_chart_range_lengths[] = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	1, 1, 1, 1, 1, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
};

static const char _state_chart_index_offsets[] = {
	0, 0, 5, 7, 9, 11, 13, 15, 
	17, 19, 21, 23, 25, 27, 29, 31, 
	33, 35, 37, 39, 41, 43, 45, 47, 
	49, 51, 53, 55, 57, 59, 61, 63, 
	65, 67, 69, 71, 72, 77, 79
};

static const char _state_chart_indicies[] = {
	0, 0, 2, 3, 1, 3, 1, 4, 
	1, 5, 1, 6, 1, 7, 1, 8, 
	1, 9, 1, 10, 1, 11, 1, 12, 
	1, 13, 1, 14, 1, 15, 1, 16, 
	1, 17, 1, 18, 1, 19, 1, 20, 
	1, 21, 1, 22, 1, 23, 1, 24, 
	1, 25, 1, 26, 1, 27, 1, 28, 
	1, 29, 1, 30, 1, 31, 1, 32, 
	1, 33, 1, 34, 1, 35, 1, 36, 
	0, 0, 2, 3, 1, 37, 36, 36, 
	0
};

static const char _state_chart_trans_targs[] = {
	1, 0, 2, 3, 4, 5, 6, 7, 
	8, 9, 10, 11, 12, 13, 14, 15, 
	16, 17, 18, 19, 20, 21, 22, 23, 
	24, 25, 26, 27, 28, 29, 30, 31, 
	32, 33, 34, 37, 38, 35
};

static const char _state_chart_trans_actions[] = {
	0, 0, 0, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	3, 3, 3, 3, 3, 3, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 3, 0
};

static const char _state_chart_eof_actions[] = {
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 5, 5
};

static const int state_chart_start = 36;
static const int state_chart_first_final = 36;
static const int state_chart_error = 0;

static const int state_chart_en_main = 36;


#line 90 "json_resp_2_struct.rl"

void state_chart_init( struct state_chart *fsm )
{
	
#line 145 "json_resp_2_struct.c"
	{
	( fsm->cs) = state_chart_start;
	}

#line 94 "json_resp_2_struct.rl"
}

void state_chart_execute( struct state_chart *fsm, const char *_data, int _len )
{
	const char *p = _data;
	const char *pe = _data+_len;
	const char *eof = pe;
	
#line 159 "json_resp_2_struct.c"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( ( fsm->cs) == 0 )
		goto _out;
_resume:
	_keys = _state_chart_trans_keys + _state_chart_key_offsets[( fsm->cs)];
	_trans = _state_chart_index_offsets[( fsm->cs)];

	_klen = _state_chart_single_lengths[( fsm->cs)];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (unsigned int)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _state_chart_range_lengths[( fsm->cs)];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += (unsigned int)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	_trans = _state_chart_indicies[_trans];
	( fsm->cs) = _state_chart_trans_targs[_trans];

	if ( _state_chart_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _state_chart_actions + _state_chart_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
#line 44 "json_resp_2_struct.rl"
	{
		memset(results,'\0',1024);
		results_idx=0;	
	}
	break;
	case 1:
#line 55 "json_resp_2_struct.rl"
	{ 
			//printf(":%i:%s\n",fsm->cs,results);
		results[results_idx]=(*p);	
		results_idx++;
	}
	break;
	case 2:
#line 61 "json_resp_2_struct.rl"
	{
		strncpy(sample.fname,results,strlen(results));
	}
	break;
#line 254 "json_resp_2_struct.c"
		}
	}

_again:
	if ( ( fsm->cs) == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	const char *__acts = _state_chart_actions + _state_chart_eof_actions[( fsm->cs)];
	unsigned int __nacts = (unsigned int) *__acts++;
	while ( __nacts-- > 0 ) {
		switch ( *__acts++ ) {
	case 3:
#line 64 "json_resp_2_struct.rl"
	{
		strcpy(sample.equation,&results[7]);
	}
	break;
#line 276 "json_resp_2_struct.c"
		}
	}
	}

	_out: {}
	}

#line 102 "json_resp_2_struct.rl"
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





