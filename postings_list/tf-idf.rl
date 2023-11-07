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

#define MAX_VOCAB_SIZE 3200
#define MAX_FILE_COUNT 100
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
%%{
	machine strings;
  include strings "vocab.rl";
	main := |*
  word => { 
    memset(temp, '\0', MAX_WORD_SIZE);
    strncpy(temp, &buff[ts - in], te - ts);
    Test(temp);
    printf("%s,%zd,%zd,%s\n", filename, ts - in, te - ts, temp);
  };
  
  any ;
  *|;
}%%


%% write data;

int scan(const char *in) {
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + strlen(in);
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  %% write init;
  %% write exec;

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

