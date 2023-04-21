
#line 1 "scan7.rl"
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


#line 47 "scan7.rl"




#line 23 "scan7.c"
static const char _scanner_actions[] = {
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12
};

static const char _scanner_key_offsets[] = {
	0, 0, 1, 2, 7, 8, 9, 11
};

static const char _scanner_trans_keys[] = {
	93, 43, 10, 34, 92, 94, 125, 125, 
	92, 34, 115, 44, 0
};

static const char _scanner_single_lengths[] = {
	0, 1, 1, 5, 1, 1, 2, 1
};

static const char _scanner_range_lengths[] = {
	0, 0, 0, 0, 0, 0, 0, 0
};

static const char _scanner_index_offsets[] = {
	0, 0, 2, 4, 10, 12, 14, 17
};

static const char _scanner_trans_targs[] = {
	3, 3, 3, 3, 0, 4, 5, 6, 
	7, 3, 1, 3, 3, 3, 3, 2, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 0
};

static const char _scanner_trans_actions[] = {
	11, 23, 15, 25, 0, 5, 0, 5, 
	0, 17, 0, 19, 7, 21, 13, 0, 
	21, 9, 21, 23, 25, 19, 21, 21, 
	21, 0
};

static const char _scanner_to_state_actions[] = {
	0, 0, 0, 1, 0, 0, 0, 0
};

static const char _scanner_from_state_actions[] = {
	0, 0, 0, 3, 0, 0, 0, 0
};

static const char _scanner_eof_trans[] = {
	0, 20, 21, 0, 22, 25, 25, 25
};

static const int scanner_start = 3;
static const int scanner_first_final = 3;
static const int scanner_error = 0;

static const int scanner_en_main = 3;


#line 51 "scan7.rl"
int cs;
int blen;
#define BUF_MAX_LEN 100000
extern char buffer[BUF_MAX_LEN];
int idx;
void ragel_init(){

	
#line 90 "scan7.c"
	{
	cs = scanner_start;
	ts = 0;
	te = 0;
	act = 0;
	}

#line 59 "scan7.rl"
	idx=0;
	memset(buffer,'\0',BUF_MAX_LEN);
}

void  unescape_tex( char *data, int len )
{
	char *p = data;
	char *pe = data + len;
	char *eof = pe;
	
#line 105 "scan7.c"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_acts = _scanner_actions + _scanner_from_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 1:
#line 1 "NONE"
	{ts = p;}
	break;
#line 124 "scan7.c"
		}
	}

	_keys = _scanner_trans_keys + _scanner_key_offsets[cs];
	_trans = _scanner_index_offsets[cs];

	_klen = _scanner_single_lengths[cs];
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

	_klen = _scanner_range_lengths[cs];
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
_eof_trans:
	cs = _scanner_trans_targs[_trans];

	if ( _scanner_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _scanner_actions + _scanner_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 2:
#line 1 "NONE"
	{te = p+1;}
	break;
	case 3:
#line 26 "scan7.rl"
	{te = p+1;{ 
			buffer[idx]='\\';
			idx++;
		}}
	break;
	case 4:
#line 31 "scan7.rl"
	{te = p+1;}
	break;
	case 5:
#line 33 "scan7.rl"
	{te = p+1;}
	break;
	case 6:
#line 35 "scan7.rl"
	{te = p+1;}
	break;
	case 7:
#line 37 "scan7.rl"
	{te = p+1;}
	break;
	case 8:
#line 41 "scan7.rl"
	{te = p+1;{ 
			buffer[idx]=(*p);
			idx++;
		}}
	break;
	case 9:
#line 39 "scan7.rl"
	{te = p;p--;}
	break;
	case 10:
#line 41 "scan7.rl"
	{te = p;p--;{ 
			buffer[idx]=(*p);
			idx++;
		}}
	break;
	case 11:
#line 39 "scan7.rl"
	{{p = ((te))-1;}}
	break;
	case 12:
#line 41 "scan7.rl"
	{{p = ((te))-1;}{ 
			buffer[idx]=(*p);
			idx++;
		}}
	break;
#line 233 "scan7.c"
		}
	}

_again:
	_acts = _scanner_actions + _scanner_to_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 0:
#line 1 "NONE"
	{ts = 0;}
	break;
#line 244 "scan7.c"
		}
	}

	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	if ( _scanner_eof_trans[cs] > 0 ) {
		_trans = _scanner_eof_trans[cs] - 1;
		goto _eof_trans;
	}
	}

	_out: {}
	}

#line 69 "scan7.rl"
}

void finish( )
{
	if ( cs >= scanner_first_final )
		printf( "ACCEPT\n" );
	else
		printf( "FAIL\n" );
}

