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
equation  => {
    if ((te - ts) < 2000) {
      XXH64_canonical_t dst;
      char temp[te - ts + 1];
      memset(temp, '\0', te - ts + 1);
        int offset = ts - in + prefix_length;
        int length = te - ts -(prefix_length+suffix_length);
        strcat(temp,"<s>");
        strncat(temp, &in[offset], length);
        strcat(temp,"</s>");
      XXH64_hash_t test_hash = XXH64(temp, length, 0);
      add_token(test_hash, temp, length, filename);
      XXH64_canonicalFromHash(&dst, test_hash);
      size_t i;
      
      match_to_file(dst,temp);

      fprintf(hash_test,"%s\t",filename);
      for (i = 0; i < 8; i++) {
        fprintf(hash_test,"%02x",dst.digest[i]);
      }
        fprintf(hash_test, " %d  %d %d\n", offset, length,fcurs);
    }
  };
  any => {

      char temp[te - ts + 1];
      memset(temp, '\0', te - ts + 1);
      int offset = ts - in;
      int length = te - ts;
      strncpy(temp, &in[offset], length);
      printf("%s",temp);
  };

('\\left'|'\\right'|'\\qquad') ;
*| ;
}%%

    %% write data;
int scanner(const char *in, FILE* hash_test,int length,char* filename) {
  in_size = length;
  int cs = 0, act = 0;
  const char *p = in;
  const char *pe = in + length;
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

