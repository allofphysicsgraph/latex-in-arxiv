#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <math.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/param.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <inttypes.h> // For PRIu64 etc. (though not directly used for filename here, helpful for printing digests)
#include "globals.h"
char temp_buffer[10024];
int n;
int prefix_length = 0;
int suffix_length = 0;
int in_size = 0;
int replace_prefix_suffix = 0;
size_t len;
va_list args;
// Function to convert a byte to its hexadecimal representation (two characters)
void byte_to_hex(uint8_t byte, char hex_str[3]) {
    const char hex_digits[] = "0123456789abcdef";
    hex_str[0] = hex_digits[(byte >> 4) & 0x0F]; // Upper nibble
    hex_str[1] = hex_digits[byte & 0x0F];        // Lower nibble
    hex_str[2] = '\0';                            // Null terminator
}

int match_to_file(XXH64_canonical_t dst, char* temp){
    // Create filename string
    char filename2[21]; // 8 bytes * 2 hex chars per byte + null terminator
    filename2[0] = '\0'; // Initialize as empty string

    for (int i = 0; i < 8; ++i) {
        char hex_byte[3];
        byte_to_hex(dst.digest[i], hex_byte);
        strcat(filename2, hex_byte);
        }
    strcat(filename2,".tex");
    // Create the file
    FILE *fp = fopen(filename2, "w"); // "w" mode will create if it doesn't exist, truncate if it does

    if (fp == NULL) {
        perror("Error opening file");
        return 1; // Indicate error
    }
    // Write some content to the file (optional)
    fprintf(fp, "%s", temp);
    // Close the file
    fclose(fp);
    //printf("File '%s' created successfully.\n", filename2);
    return EXIT_SUCCESS;
    }

%%{

  machine strings;
  include latex "latex.rl";

main :=|*
frac  => {
    if (in_size<2000) {
        strncat(output_buffer," FRAC ",7);
  }};

sum  => {
    if (in_size<2000) {
        strncat(output_buffer," SUM ",6);
  }};
lim  => {
    if (in_size<2000) {
        strncat(output_buffer," LIM ",6);
  }};
int  => {
    if (in_size<2000) {
        strncat(output_buffer," INTEGRAL ",11);
  }};
prod  => {
    if (in_size<2000) {
        strncat(output_buffer," PROD ",7);
  }};
'='  => {
    if (in_size<2000) {
        strncat(output_buffer," EQ ",6);
  }};
'('  => {
    if (in_size<2000) {
        strncat(output_buffer," LP ",6);
  }};
'['  => {
    if (in_size<2000) {
        strncat(output_buffer," LBR ",6);
  }};
']'  => {
    if (in_size<2000) {
        strncat(output_buffer," RBR ",6);
  }};

')'  => {
    if (in_size<2000) {
        strncat(output_buffer," RP ",6);
  }};

'{'  => {
    if (in_size<2000) {
        strncat(output_buffer," LBR ",7);
  }};
'}'  => {
    if (in_size<2000) {
        strncat(output_buffer," RBR ",7);
  }};

'_'  => {
    if (in_size<2000) {
        strncat(output_buffer," SUB ",7);
  }};
'^'  => {
    if (in_size<2000) {
        strncat(output_buffer," SUP ",7);
  }};


'<s>' => {};
'</s>' => {};
label => {};

('0'|[1-9] digit*) => {

    if (in_size<2000) {
        strncat(output_buffer," INTEGER ",10);
  }};

any => {
      int offset = ts - in;
      int length = te - ts;
      strncat(output_buffer, &in[offset], length);
  };

('\\bf '|'\\left'|'\\right'|'\\qquad'|'\\quad'|'\\hspace' braces) ;
('\\'[a-z]+|'\\' [A-Z] [a-z]+) => {
    if (in_size<2000) {
      int offset = ts - in;
      int length = te - ts;
      strncat(output_buffer," ",2);
      strncat(output_buffer,&in[offset+1],length-1);
      strncat(output_buffer," ",2);
  }};
*| ;
}%%

    %% write data;
int scanner(const char *in, FILE* hash_test,int length,char* filename) {
  in_size = length;
  char output_buffer[in_size*2];
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + length;
  const char *ts = NULL, *te = NULL;
  const char *eof = pe;

  memset(output_buffer,'\0',in_size+1);
  %% write init;
  %% write exec;

  if (cs == strings_error)
    printf("Error near %zd\n", p - in);
  printf("%s",output_buffer);
  return EXIT_SUCCESS;
}

