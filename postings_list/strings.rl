#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define MAX_FILE_COUNT 10
#define MAX_FILE_PATH_LEN 256
#define MAX_VOCAB_SIZE 32000
#define MAX_WORD_LEN  32768

char *buff;
char filename[MAX_FILE_PATH_LEN];
char temp[MAX_WORD_LEN];
int getTokenFreq(int WordID);
int Insert(char *token);
int i, n;
int Test(char *token);
int updateWordFrequency(int idx);
int wordLookup(char *);
struct stat s;
void print_docids();
void printPostings();
void print_tfid(int WordID, int argc);
void print_wordids();

struct tf_idf {
  char *token[MAX_WORD_LEN];
  int token_count;
  int dft;           // number of documents that contain token t
  int documentCount; // Total number of documents
  int current_DocID;
};

struct postingsList {
  int DocID;
  int WordID;
  // # DocID,  Document file Path
  char DocPath[MAX_FILE_COUNT][MAX_FILE_PATH_LEN];
  // #WordID Word
  char Word[MAX_VOCAB_SIZE][MAX_WORD_LEN];
  // DocID WordID Count
  int TokenFrequencies[MAX_FILE_COUNT][MAX_VOCAB_SIZE];
  int DocumentTokenCount[MAX_FILE_COUNT];
};

struct postingsList mylist;
struct tf_idf tfidf_array[MAX_VOCAB_SIZE];

int scan(const char *in);
%%{
	machine strings;
  include strings "vocab.rl";
	main := |*
  word => { 
    memset(temp, '\0', MAX_WORD_LEN);
    assert(te-ts< MAX_WORD_LEN);
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
  mylist.WordID = 0;
  mylist.DocID = 0;

  if (argc < 2) {
    printf("input filename\n");
    return -1;
  }

  for (int i = 0; i < argc - 1; i++) {
    int docCount = argc - 1;
    mylist.DocID = i;
    strncpy(mylist.DocPath[mylist.DocID], argv[i + 1], MAX_FILE_PATH_LEN);

    strncpy(filename, argv[i + 1], MAX_FILE_PATH_LEN);
    char buffer[s.st_size];
    int cs, res = 0;

    int fd;
    fd = open(argv[i + 1], O_RDONLY);
    if (fd < 0)
      return EXIT_FAILURE;
    fstat(fd, &s);
    /* PROT_READ disallows writing to buff: will segv */
    buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (buff != (void *)-1) {
      scan((char *)buff);
      // printf("%s",buff);
      munmap(buff, s.st_size);
    }
    close(fd);
  }

  print_docids();
  print_wordids();
  print_tfid(1, argc);
  return 0;
}

int Lookup(char *) {
  for (int i = 0; i < mylist.WordID; i++) {
    if (strcmp(temp, mylist.Word[i]) == 0) {
      return i;
    }
  }
  return -1;
}

int Test(char *token) {
  int match = Lookup(token);
  if (match == -1) {
    Insert(token);
  } else {
    updateWordFrequency(match);
  }
}

int Insert(char *token) {

  struct tf_idf tmp_val = tfidf_array[mylist.WordID];
  tmp_val.token_count = 1;
  tmp_val.dft = 1;
  tmp_val.current_DocID = mylist.DocID;
  tfidf_array[mylist.WordID] = tmp_val;

  mylist.TokenFrequencies[mylist.DocID][mylist.WordID]++;
  strncpy(mylist.Word[mylist.WordID], token, MAX_WORD_LEN);
  mylist.DocumentTokenCount[mylist.DocID]++;
  mylist.WordID++;
}

int updateWordFrequency(int idx) {
  mylist.TokenFrequencies[mylist.DocID][idx]++;
  mylist.DocumentTokenCount[mylist.DocID]++;
  //"update Token Count:<%d><%d>"

  struct tf_idf tmp_val = tfidf_array[idx];
  tmp_val.token_count++;
  if (mylist.DocID != tmp_val.current_DocID) {
    tmp_val.dft++;
    tmp_val.current_DocID = mylist.DocID;
  }
  tfidf_array[idx] = tmp_val;
}

int getTokenFreq(int WordID) {
  int df = 0;
  for (i = 0; i <= mylist.DocID; i++) {
    if (mylist.TokenFrequencies[i][WordID] > 0) {
      df++;
    }
  }
  return df;
}

void print_docids() {
  for (i = 0; i <= mylist.DocID; i++) {
    printf("<DocID:%d %s>\n", i, mylist.DocPath[i]);
  }
}

void print_wordids() {
  for (i = 0; i <= mylist.WordID; i++) {
    printf("<WordID:%d %s>\n", i, mylist.Word[i]);
  }
}

void print_tfid(int WordID, int argc) {
  int documentCount = argc - 1;
  struct tf_idf tmp_val = tfidf_array[WordID];
  float tf = 1 + log10(tmp_val.token_count + 1);
  float idf = 0;
  if (tmp_val.dft > 0) {
    idf = log10(1.0 * documentCount / tmp_val.dft);
  }
  printf("\n<<token:%s\ttf:%d\tdft:%d\t#Documents:%d\ttflog10(tf+1):%f\tidf:"
         "log10(N/dft):%f,tf-idf:%f>>",
         mylist.Word[WordID], tmp_val.token_count, tmp_val.dft, argc - 1, tf,
         idf, tf * idf);
}
