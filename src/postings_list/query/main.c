#define _XOPEN_SOURCE 500 // Required for nftw in some systems
#include "globals.h"
#include "uthash.h"
#include "xxhash.h"
#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <ftw.h>
#include <math.h>
#include <regex.h>
#include <stdio.h>  /* printf */
#include <stdlib.h> /* atoi, malloc */
#include <string.h> /* strcpy */
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define PATH_MAX 4096              // Standard PATH_MAX, adjust if needed
#define INITIAL_ARRAY_SIZE 1048576 // Initial size for the file path array
#define ARRAY_RESIZE_FACTOR 2      // Factor to resize the array by

// Structure to hold the array of matching file paths
struct MatchingFiles {
  char **filepaths;
  int count;
  int capacity;
};

struct MatchingFiles matching_files;
regex_t regex; // Compiled regex

// Function called by nftw for each file/directory
int process_path(const char *filepath, const struct stat *sb, int typeflag,
                 struct FTW *ftwbuf) {
  if (typeflag == FTW_F) { // Only process regular files
    if (regexec(&regex, filepath, 0, NULL, 0) == 0) { // Regex match found
      if (matching_files.count >= matching_files.capacity) {
        matching_files.capacity *= ARRAY_RESIZE_FACTOR;
        matching_files.filepaths = realloc(
            matching_files.filepaths, matching_files.capacity * sizeof(char *));
        if (!matching_files.filepaths) {
          perror("Memory allocation error");
          exit(EXIT_FAILURE);
        }
      }
      matching_files.filepaths[matching_files.count] = strdup(filepath);
      if (!matching_files.filepaths[matching_files.count]) {
        perror("Memory allocation error");
        exit(EXIT_FAILURE);
      }
      matching_files.count++;
    }
  }
  return 0; // Continue traversal
}

// Function to free memory used by the matching files array
void free_matching_files_array() {
  for (int i = 0; i < matching_files.count; i++) {
    free(matching_files.filepaths[i]);
  }
  free(matching_files.filepaths);
  matching_files.filepaths = NULL;
  matching_files.count = 0;
  matching_files.capacity = 0;
}

struct my_struct *tokens = NULL;

void add_token(XXH64_hash_t token_id, const char *token, int tok_len,
               char filename[256]) {
  struct my_struct *s;

  HASH_FIND_INT(tokens, &token_id, s); /* id already in the hash? */
  if (s == NULL) {
    s = (struct my_struct *)malloc(sizeof *s);
    s->id = token_id;
    s->count = 1;
    s->length = tok_len;
    s->doc_count = 1;
    s->tf_idf = 0.0;
    memset(s->current_file, '\0', 256);
    strncpy(s->current_file, filename, 256);
    HASH_ADD_INT(tokens, id, s); /* id is the key field */
  } else {
    s->count++;
    if (strncmp(s->current_file, filename, 256) != 0) {
      s->doc_count++;
      strncpy(s->current_file, filename, 256);
    }
  }
  strncpy(s->token, token, MAX_TOKEN_LENGTH);
}

void delete_all() {
  struct my_struct *current_token;
  struct my_struct *tmp;
  HASH_ITER(hh, tokens, current_token, tmp) {
    HASH_DEL(tokens, current_token); /* delete it (tokens advances to next) */
    free(current_token);             /* free it */
  }
}

void update_tf_idf(int total_doc_count) {
  struct my_struct *s;
  for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
    float tf = 1 + log10(s->count + 1);
    float idf = log10(total_doc_count / s->doc_count);
    float tf_idf = tf * idf;
    s->tf_idf = tf_idf;
  }
}

float avg_tfidf() {
  struct my_struct *s;
  float total = 0;
  int counter = 0;
  for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
    total += s->tf_idf;
    counter++;
  }
  if (counter > 0) {
    return total / counter;
  } else {
    return 0;
  }
}

void write_tf_idf() {
  FILE *tf_idf;                      /* output-file pointer */
  char *tf_idf_file_name = "tf_idf"; /* output-file name    */

  tf_idf = fopen(tf_idf_file_name, "a+");
  if (tf_idf == NULL) {
    fprintf(stderr, "couldn't open file '%s'; %s\n", tf_idf_file_name,
            strerror(errno));
    exit(EXIT_FAILURE);
  }

  struct my_struct *s;
  XXH64_canonical_t dst;
  if (avg_tfidf() >= 0) {
    for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
      /*   don't print tf_idf where the scores are all 0 ie a single document.
       */
      size_t i;
      XXH64_canonicalFromHash(&dst, s->id);
      fprintf(tf_idf, "id:");
      for (i = 0; i < 8; i++) {
        fprintf(tf_idf, "%02x", dst.digest[i]);
      }
      fprintf(tf_idf, ": count:%d docs:%d tf_idf:%f tok:%s\n", s->count,
              s->doc_count, s->tf_idf, s->token);
    }
  } else {
    for (s = tokens; s != NULL; s = (struct my_struct *)(s->hh.next)) {
      size_t i;
      XXH64_canonicalFromHash(&dst, s->id);
      fprintf(tf_idf, "id:");
      for (i = 0; i < 8; i++) {
        fprintf(tf_idf, "%02x", dst.digest[i]);
      }
      fprintf(tf_idf, ": count:%d docs:%d tok:%s\n", s->count, s->doc_count,
              s->token);
    }
  }
  fclose(tf_idf);
}

int by_tf_idf(const struct my_struct *a, const struct my_struct *b) {
  return ((int)(100 * (a->tf_idf)) - (int)(100 * (b->tf_idf)));
}

int by_count(const struct my_struct *a, const struct my_struct *b) {
  return (a->count - b->count);
}

void srt() {
  if (avg_tfidf() > .05) {
    HASH_SORT(tokens, by_tf_idf);
  } else {
    HASH_SORT(tokens, by_count);
  }
}

void count() {
  int temp;
  temp = HASH_COUNT(tokens);
  printf("%d", temp);
}

/*
 * Converts one hexadecimal character to integer.
 * Returns -1 if the given character is not hexadecimal.
 * cli/xxhsum.c is the original source
 */
static int charToHex(char c) {
  int result = -1;
  if (c >= '0' && c <= '9') {
    result = (int)(c - '0');
  } else if (c >= 'A' && c <= 'F') {
    result = (int)(c - 'A') + 0x0a;
  } else if (c >= 'a' && c <= 'f') {
    result = (int)(c - 'a') + 0x0a;
  }
  return result;
}

/* CanonicalFromString in cli/xxhsum.c */
int cmp_Canonical_XXH64(const char *hashStr, XXH64_hash_t hash) {
  unsigned char dst[16];
  size_t dstSize = 8;
  int h0, h1;
  size_t i = 0;
  for (i = 0; i < dstSize; ++i) {
    h0 = charToHex(hashStr[i * 2 + 0]);
    /* printf("<h0>%x\n",h0); */
    h1 = charToHex(hashStr[i * 2 + 1]);
    dst[i] = (unsigned char)((h0 << 4) | h1);
  }
  XXH64_hash_t hashFromStr = XXH64_hashFromCanonical((XXH64_canonical_t *)dst);
  if (hashFromStr == hash) {
    return 0;
  }
  return -1;
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
    fprintf(stderr, "Usage: %s <directory> <regex_pattern>\n", argv[0]);
    return EXIT_FAILURE;
  }

  char *dir_path = argv[1];
  char *regex_pattern = argv[2];
  int regex_comp_result;

  // Compile regex pattern
  regex_comp_result = regcomp(&regex, regex_pattern, REG_EXTENDED);
  if (regex_comp_result) {
    char error_buffer[512];
    regerror(regex_comp_result, &regex, error_buffer, sizeof(error_buffer));
    fprintf(stderr, "Regex compilation error: %s\n", error_buffer);
    return EXIT_FAILURE;
  }

  // Initialize matching_files structure
  matching_files.capacity = INITIAL_ARRAY_SIZE;
  matching_files.count = 0;
  matching_files.filepaths = malloc(matching_files.capacity * sizeof(char *));
  if (!matching_files.filepaths) {
    perror("Memory allocation error");
    regfree(&regex); // Free regex resources before exiting
    return EXIT_FAILURE;
  }

  if (nftw(dir_path, process_path, 20, FTW_PHYS) == -1) {
    perror("nftw");
    regfree(&regex);             // Free regex resources before exiting
    free_matching_files_array(); // Free allocated array memory
    return EXIT_FAILURE;
  }

  for (int i = 0; i < matching_files.count; i++) {
    // printf("%s\n", matching_files.filepaths[i]);
    int fd;
    struct stat s;
    fd = open(matching_files.filepaths[i], O_RDONLY);
    if (fd < 0) {
      printf("EXIT FAILURE");
      return EXIT_FAILURE;
    }
    fstat(fd, &s);
    /* PROT_READ disallows writing to buff: will segv */
    char *buff = mmap(NULL, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (buff != (void *)-1) {
      // printf("%s",buff);
      FILE *fname;                          /* input-file pointer */
      char *fname_file_name = "file_xxh64"; /* input-file name    */
      fname = fopen(fname_file_name, "a+");
      if (fname == NULL) {
        fprintf(stderr, "couldn't open file '%s'; %s\n", fname_file_name,
                strerror(errno));
        exit(EXIT_FAILURE);
      }
      {
        // fprintf(fname, "%s  ", matching_files.filepaths[i]);
        XXH64_hash_t test_hash = XXH64(buff, s.st_size, 0);
        size_t i = 0;
        XXH64_canonical_t dst;
        XXH64_canonicalFromHash(&dst, test_hash);
        for (i = 0; i < 8; i++) {
          fprintf(fname, "%02x", dst.digest[i]);
        }
        fprintf(fname, "%s", "\n");
      }
      if (fclose(fname) == EOF) { /* close input file   */
        fprintf(stderr, "couldn't close file '%s'; %s\n", fname_file_name,
                strerror(errno));
        exit(EXIT_FAILURE);
      }

      FILE *hash_test;
      hash_test = fopen("offsets", "a+");
      if (hash_test == NULL) {
        fprintf(stderr, "couldn't open file '%s'; %s\n", "offsets",
                strerror(errno));
        exit(EXIT_FAILURE);
      }
      fprintf(hash_test, "%s\n", matching_files.filepaths[i]);
      scanner((char *)buff, hash_test, s.st_size, matching_files.filepaths[i]);
      if (fclose(hash_test) == EOF) { /* close output file   */
        fprintf(stderr, "couldn't close file '%s'; %s\n", "offsets",
                strerror(errno));
        exit(EXIT_FAILURE);
      }
    }
  }
  update_tf_idf(matching_files.count);
  printf("sorting structs\n");
  srt();
  printf("writing tf_idf scores to tf_idf\n");
  write_tf_idf();
  delete_all();

  free_matching_files_array(); // Clean up array memory
  regfree(&regex);             // Free regex resources

  return EXIT_SUCCESS;
}
