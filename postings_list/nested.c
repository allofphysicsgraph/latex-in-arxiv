
#line 1 "nested.rl"
#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define MAX_LEN 1024
#define MAX_WORD_SIZE 1024

#define MAX_VOCAB_SIZE 32000
#define MAX_FILE_COUNT 10
#define MAX_FILE_PATH_LEN 256

int wordLookup(char *);
int Test(char* token);
int Insert(char* token);
void printPostings();
int updateWordFrequency(int idx);

struct postingsList {
  int DocID;
  int WordID;
  // # DocID,  Document file Path   
  char DocPath[MAX_FILE_COUNT][MAX_FILE_PATH_LEN];
  // #WordID Word
  char Word[MAX_VOCAB_SIZE][MAX_WORD_SIZE];
  //DocID WordID Count
  int TokenFrequencies[MAX_FILE_COUNT][MAX_VOCAB_SIZE];
  int DocumentTokenCount[MAX_FILE_COUNT];
};

struct postingsList mylist;
char temp[MAX_WORD_SIZE];
char *buff;
char filename[128];
struct stat s;

int i;

int line_no = 1;
int col_number = 1;
int char_offset = 0;

extern void *malloc();

int scan(const char *in);

#line 69 "nested.rl"




#line 60 "nested.c"
static const int strings_start = 48;
static const int strings_first_final = 48;
static const int strings_error = -1;

static const int strings_en_main = 48;


#line 73 "nested.rl"

int scan(const char *in) {
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  
#line 74 "nested.c"
	{
	cs = strings_start;
	ts = 0;
	te = 0;
	act = 0;
	}

#line 82 "nested.rl"
  
#line 80 "nested.c"
	{
	if ( p == pe )
		goto _test_eof;
	switch ( cs )
	{
tr0:
#line 67 "nested.rl"
	{{p = ((te))-1;}}
	goto st48;
tr19:
#line 1 "NONE"
	{	switch( act ) {
	case 1:
	{{p = ((te))-1;} 
    memset(temp, '\0', MAX_WORD_SIZE);
    strncpy(temp, &buff[ts - in], te - ts);
    Test(temp);
    //printf("%s,%zd,%zd,%s\n", filename, ts - in, te - ts, temp);
  }
	break;
	default:
	{{p = ((te))-1;}}
	break;
	}
	}
	goto st48;
tr50:
#line 67 "nested.rl"
	{te = p+1;}
	goto st48;
tr52:
#line 67 "nested.rl"
	{te = p;p--;}
	goto st48;
tr54:
#line 7 "nested_vocab.rl"
	{printf(" "); }
#line 60 "nested.rl"
	{te = p;p--;{ 
    memset(temp, '\0', MAX_WORD_SIZE);
    strncpy(temp, &buff[ts - in], te - ts);
    Test(temp);
    //printf("%s,%zd,%zd,%s\n", filename, ts - in, te - ts, temp);
  }}
	goto st48;
st48:
#line 1 "NONE"
	{ts = 0;}
	if ( ++p == pe )
		goto _test_eof48;
case 48:
#line 1 "NONE"
	{ts = p;}
#line 125 "nested.c"
	if ( (*p) == 92 )
		goto tr51;
	goto tr50;
tr51:
#line 1 "NONE"
	{te = p+1;}
#line 67 "nested.rl"
	{act = 2;}
	goto st49;
st49:
	if ( ++p == pe )
		goto _test_eof49;
case 49:
#line 136 "nested.c"
	if ( (*p) == 98 )
		goto st0;
	goto tr52;
st0:
	if ( ++p == pe )
		goto _test_eof0;
case 0:
	if ( (*p) == 101 )
		goto st1;
	goto tr0;
st1:
	if ( ++p == pe )
		goto _test_eof1;
case 1:
	if ( (*p) == 103 )
		goto st2;
	goto tr0;
st2:
	if ( ++p == pe )
		goto _test_eof2;
case 2:
	if ( (*p) == 105 )
		goto st3;
	goto tr0;
st3:
	if ( ++p == pe )
		goto _test_eof3;
case 3:
	if ( (*p) == 110 )
		goto st4;
	goto tr0;
st4:
	if ( ++p == pe )
		goto _test_eof4;
case 4:
	if ( (*p) == 123 )
		goto st5;
	goto tr0;
st5:
	if ( ++p == pe )
		goto _test_eof5;
case 5:
	if ( (*p) == 97 )
		goto st6;
	goto tr0;
st6:
	if ( ++p == pe )
		goto _test_eof6;
case 6:
	if ( (*p) == 98 )
		goto st7;
	goto tr0;
st7:
	if ( ++p == pe )
		goto _test_eof7;
case 7:
	if ( (*p) == 115 )
		goto st8;
	goto tr0;
st8:
	if ( ++p == pe )
		goto _test_eof8;
case 8:
	if ( (*p) == 116 )
		goto st9;
	goto tr0;
st9:
	if ( ++p == pe )
		goto _test_eof9;
case 9:
	if ( (*p) == 114 )
		goto st10;
	goto tr0;
st10:
	if ( ++p == pe )
		goto _test_eof10;
case 10:
	if ( (*p) == 97 )
		goto st11;
	goto tr0;
st11:
	if ( ++p == pe )
		goto _test_eof11;
case 11:
	if ( (*p) == 99 )
		goto st12;
	goto tr0;
st12:
	if ( ++p == pe )
		goto _test_eof12;
case 12:
	if ( (*p) == 116 )
		goto st13;
	goto tr0;
st13:
	if ( ++p == pe )
		goto _test_eof13;
case 13:
	if ( (*p) == 125 )
		goto st14;
	goto tr0;
st14:
	if ( ++p == pe )
		goto _test_eof14;
case 14:
	if ( (*p) == 92 )
		goto tr16;
	goto tr15;
tr15:
#line 6 "nested_vocab.rl"
	{printf(" ");}
	goto st15;
st15:
	if ( ++p == pe )
		goto _test_eof15;
case 15:
#line 251 "nested.c"
	if ( (*p) == 92 )
		goto st17;
	goto st16;
st16:
	if ( ++p == pe )
		goto _test_eof16;
case 16:
	if ( (*p) == 92 )
		goto st17;
	goto st16;
st17:
	if ( ++p == pe )
		goto _test_eof17;
case 17:
	switch( (*p) ) {
		case 92: goto st17;
		case 101: goto st18;
	}
	goto st16;
st18:
	if ( ++p == pe )
		goto _test_eof18;
case 18:
	switch( (*p) ) {
		case 92: goto st17;
		case 110: goto st19;
	}
	goto st16;
st19:
	if ( ++p == pe )
		goto _test_eof19;
case 19:
	switch( (*p) ) {
		case 92: goto st17;
		case 100: goto st20;
	}
	goto st16;
st20:
	if ( ++p == pe )
		goto _test_eof20;
case 20:
	switch( (*p) ) {
		case 92: goto st17;
		case 123: goto st21;
	}
	goto st16;
st21:
	if ( ++p == pe )
		goto _test_eof21;
case 21:
	switch( (*p) ) {
		case 92: goto st17;
		case 97: goto st22;
	}
	goto st16;
st22:
	if ( ++p == pe )
		goto _test_eof22;
case 22:
	switch( (*p) ) {
		case 92: goto st17;
		case 98: goto st23;
	}
	goto st16;
st23:
	if ( ++p == pe )
		goto _test_eof23;
case 23:
	switch( (*p) ) {
		case 92: goto st17;
		case 115: goto st24;
	}
	goto st16;
st24:
	if ( ++p == pe )
		goto _test_eof24;
case 24:
	switch( (*p) ) {
		case 92: goto st17;
		case 116: goto st25;
	}
	goto st16;
st25:
	if ( ++p == pe )
		goto _test_eof25;
case 25:
	switch( (*p) ) {
		case 92: goto st17;
		case 114: goto st26;
	}
	goto st16;
st26:
	if ( ++p == pe )
		goto _test_eof26;
case 26:
	switch( (*p) ) {
		case 92: goto st17;
		case 97: goto st27;
	}
	goto st16;
st27:
	if ( ++p == pe )
		goto _test_eof27;
case 27:
	switch( (*p) ) {
		case 92: goto st17;
		case 99: goto st28;
	}
	goto st16;
st28:
	if ( ++p == pe )
		goto _test_eof28;
case 28:
	switch( (*p) ) {
		case 92: goto st17;
		case 116: goto st29;
	}
	goto st16;
st29:
	if ( ++p == pe )
		goto _test_eof29;
case 29:
	switch( (*p) ) {
		case 92: goto st17;
		case 125: goto tr32;
	}
	goto st16;
tr32:
#line 1 "NONE"
	{te = p+1;}
#line 60 "nested.rl"
	{act = 1;}
	goto st50;
st50:
	if ( ++p == pe )
		goto _test_eof50;
case 50:
#line 386 "nested.c"
	if ( (*p) == 92 )
		goto st17;
	goto st16;
tr16:
#line 6 "nested_vocab.rl"
	{printf(" ");}
	goto st30;
st30:
	if ( ++p == pe )
		goto _test_eof30;
case 30:
#line 396 "nested.c"
	switch( (*p) ) {
		case 92: goto st17;
		case 98: goto st31;
		case 101: goto st46;
	}
	goto st16;
st31:
	if ( ++p == pe )
		goto _test_eof31;
case 31:
	switch( (*p) ) {
		case 92: goto st17;
		case 101: goto st32;
	}
	goto st16;
st32:
	if ( ++p == pe )
		goto _test_eof32;
case 32:
	switch( (*p) ) {
		case 92: goto st17;
		case 103: goto st33;
	}
	goto st16;
st33:
	if ( ++p == pe )
		goto _test_eof33;
case 33:
	switch( (*p) ) {
		case 92: goto st17;
		case 105: goto st34;
	}
	goto st16;
st34:
	if ( ++p == pe )
		goto _test_eof34;
case 34:
	switch( (*p) ) {
		case 92: goto st17;
		case 110: goto st35;
	}
	goto st16;
st35:
	if ( ++p == pe )
		goto _test_eof35;
case 35:
	switch( (*p) ) {
		case 92: goto st17;
		case 123: goto st36;
	}
	goto st16;
st36:
	if ( ++p == pe )
		goto _test_eof36;
case 36:
	switch( (*p) ) {
		case 92: goto st17;
		case 97: goto st37;
	}
	goto st16;
st37:
	if ( ++p == pe )
		goto _test_eof37;
case 37:
	switch( (*p) ) {
		case 92: goto st17;
		case 98: goto st38;
	}
	goto st16;
st38:
	if ( ++p == pe )
		goto _test_eof38;
case 38:
	switch( (*p) ) {
		case 92: goto st17;
		case 115: goto st39;
	}
	goto st16;
st39:
	if ( ++p == pe )
		goto _test_eof39;
case 39:
	switch( (*p) ) {
		case 92: goto st17;
		case 116: goto st40;
	}
	goto st16;
st40:
	if ( ++p == pe )
		goto _test_eof40;
case 40:
	switch( (*p) ) {
		case 92: goto st17;
		case 114: goto st41;
	}
	goto st16;
st41:
	if ( ++p == pe )
		goto _test_eof41;
case 41:
	switch( (*p) ) {
		case 92: goto st17;
		case 97: goto st42;
	}
	goto st16;
st42:
	if ( ++p == pe )
		goto _test_eof42;
case 42:
	switch( (*p) ) {
		case 92: goto st17;
		case 99: goto st43;
	}
	goto st16;
st43:
	if ( ++p == pe )
		goto _test_eof43;
case 43:
	switch( (*p) ) {
		case 92: goto st17;
		case 116: goto st44;
	}
	goto st16;
st44:
	if ( ++p == pe )
		goto _test_eof44;
case 44:
	switch( (*p) ) {
		case 92: goto st17;
		case 125: goto st45;
	}
	goto st16;
st45:
	if ( ++p == pe )
		goto _test_eof45;
case 45:
	goto st16;
st46:
	if ( ++p == pe )
		goto _test_eof46;
case 46:
	switch( (*p) ) {
		case 92: goto st17;
		case 110: goto st47;
	}
	goto st16;
st47:
	if ( ++p == pe )
		goto _test_eof47;
case 47:
	switch( (*p) ) {
		case 92: goto st17;
		case 100: goto st35;
	}
	goto st16;
	}
	_test_eof48: cs = 48; goto _test_eof; 
	_test_eof49: cs = 49; goto _test_eof; 
	_test_eof0: cs = 0; goto _test_eof; 
	_test_eof1: cs = 1; goto _test_eof; 
	_test_eof2: cs = 2; goto _test_eof; 
	_test_eof3: cs = 3; goto _test_eof; 
	_test_eof4: cs = 4; goto _test_eof; 
	_test_eof5: cs = 5; goto _test_eof; 
	_test_eof6: cs = 6; goto _test_eof; 
	_test_eof7: cs = 7; goto _test_eof; 
	_test_eof8: cs = 8; goto _test_eof; 
	_test_eof9: cs = 9; goto _test_eof; 
	_test_eof10: cs = 10; goto _test_eof; 
	_test_eof11: cs = 11; goto _test_eof; 
	_test_eof12: cs = 12; goto _test_eof; 
	_test_eof13: cs = 13; goto _test_eof; 
	_test_eof14: cs = 14; goto _test_eof; 
	_test_eof15: cs = 15; goto _test_eof; 
	_test_eof16: cs = 16; goto _test_eof; 
	_test_eof17: cs = 17; goto _test_eof; 
	_test_eof18: cs = 18; goto _test_eof; 
	_test_eof19: cs = 19; goto _test_eof; 
	_test_eof20: cs = 20; goto _test_eof; 
	_test_eof21: cs = 21; goto _test_eof; 
	_test_eof22: cs = 22; goto _test_eof; 
	_test_eof23: cs = 23; goto _test_eof; 
	_test_eof24: cs = 24; goto _test_eof; 
	_test_eof25: cs = 25; goto _test_eof; 
	_test_eof26: cs = 26; goto _test_eof; 
	_test_eof27: cs = 27; goto _test_eof; 
	_test_eof28: cs = 28; goto _test_eof; 
	_test_eof29: cs = 29; goto _test_eof; 
	_test_eof50: cs = 50; goto _test_eof; 
	_test_eof30: cs = 30; goto _test_eof; 
	_test_eof31: cs = 31; goto _test_eof; 
	_test_eof32: cs = 32; goto _test_eof; 
	_test_eof33: cs = 33; goto _test_eof; 
	_test_eof34: cs = 34; goto _test_eof; 
	_test_eof35: cs = 35; goto _test_eof; 
	_test_eof36: cs = 36; goto _test_eof; 
	_test_eof37: cs = 37; goto _test_eof; 
	_test_eof38: cs = 38; goto _test_eof; 
	_test_eof39: cs = 39; goto _test_eof; 
	_test_eof40: cs = 40; goto _test_eof; 
	_test_eof41: cs = 41; goto _test_eof; 
	_test_eof42: cs = 42; goto _test_eof; 
	_test_eof43: cs = 43; goto _test_eof; 
	_test_eof44: cs = 44; goto _test_eof; 
	_test_eof45: cs = 45; goto _test_eof; 
	_test_eof46: cs = 46; goto _test_eof; 
	_test_eof47: cs = 47; goto _test_eof; 

	_test_eof: {}
	if ( p == eof )
	{
	switch ( cs ) {
	case 49: goto tr52;
	case 0: goto tr0;
	case 1: goto tr0;
	case 2: goto tr0;
	case 3: goto tr0;
	case 4: goto tr0;
	case 5: goto tr0;
	case 6: goto tr0;
	case 7: goto tr0;
	case 8: goto tr0;
	case 9: goto tr0;
	case 10: goto tr0;
	case 11: goto tr0;
	case 12: goto tr0;
	case 13: goto tr0;
	case 14: goto tr0;
	case 15: goto tr0;
	case 16: goto tr19;
	case 17: goto tr19;
	case 18: goto tr19;
	case 19: goto tr19;
	case 20: goto tr19;
	case 21: goto tr19;
	case 22: goto tr19;
	case 23: goto tr19;
	case 24: goto tr19;
	case 25: goto tr19;
	case 26: goto tr19;
	case 27: goto tr19;
	case 28: goto tr19;
	case 29: goto tr19;
	case 50: goto tr54;
	case 30: goto tr0;
	case 31: goto tr0;
	case 32: goto tr0;
	case 33: goto tr0;
	case 34: goto tr0;
	case 35: goto tr0;
	case 36: goto tr0;
	case 37: goto tr0;
	case 38: goto tr0;
	case 39: goto tr0;
	case 40: goto tr0;
	case 41: goto tr0;
	case 42: goto tr0;
	case 43: goto tr0;
	case 44: goto tr0;
	case 45: goto tr0;
	case 46: goto tr0;
	case 47: goto tr0;
	}
	}

	}

#line 83 "nested.rl"

  if (cs == strings_error)
    printf("Error near %zd\n", p - in);
  else if (ts)
    printf("offsets: ts %zd te: %zd pe: %zd\n", ts - in, te - in, pe - in);

  return EXIT_SUCCESS;
}


int main(int argc, char **argv) {
  mylist.WordID=0;
  mylist.DocID=0;

  if (argc != 2) {
    printf("input filename\n");
    return -1;
  }

strncpy(mylist.DocPath[mylist.DocID],argv[1],MAX_FILE_PATH_LEN);

strncpy(filename, argv[1],128);
  char buffer[s.st_size];
  int cs, res = 0;

  int fd;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buff: will segv */
  buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buff != (void *)-1) {
    scan((char *)buff);
    munmap(buff, s.st_size);
  }
  close(fd);
  printPostings();
return 0;
}


int Lookup(char *){
  for(int i = 0;i<mylist.WordID;i++){
    if(strcmp(temp,mylist.Word[i])==0){
        return i;
      }
    }
    return -1;
}

int Test(char *token){
    int match = Lookup(token);
    if ( match == -1){
      Insert(token);
    } else {
      updateWordFrequency(match);
    }
} 


int Insert(char *token){
  mylist.TokenFrequencies[mylist.DocID][mylist.WordID]++;
  strncpy(mylist.Word[mylist.WordID],token,MAX_WORD_SIZE);
  //printf("adding Token:<%s>",token);
  mylist.DocumentTokenCount[mylist.DocID]++;
  mylist.WordID++;
}


int updateWordFrequency(int idx){
  mylist.TokenFrequencies[mylist.DocID][idx]++;
  mylist.DocumentTokenCount[mylist.DocID]++;
  //printf("update Token Count:<%d><%d>",idx,cnt);
}

void printPostings(){
for(int i = 0; i <= mylist.DocID;i++){
  int DocumentTokenCnt = mylist.DocumentTokenCount[mylist.DocID];
for(int j = 0;j < mylist.WordID;j++){
  int tokenFreq = mylist.TokenFrequencies[mylist.DocID][j];
  printf("Term Frequency:<%s><%d><%d><%f>\n",mylist.Word[j],tokenFreq,DocumentTokenCnt,(1.0*tokenFreq/DocumentTokenCnt));
  //mylist.DocumentTokenCount[mylist.DocID]);
  }}

  printf("document Token Count <%d>",mylist.DocumentTokenCount[mylist.DocID]);
}


