#define _XOPEN_SOURCE 500 // Required for nftw in some systems
#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>
#include <errno.h>
#include "globals.h"

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



#define PATH_MAX 4096 // Standard PATH_MAX, adjust if needed
#define INITIAL_ARRAY_SIZE 1048576 // Initial size for the file path array
#define ARRAY_RESIZE_FACTOR 2 // Factor to resize the array by

// Structure to hold the array of matching file paths
struct MatchingFiles {
    char **filepaths;
    int count;
    int capacity;
};

struct MatchingFiles matching_files;
regex_t regex; // Compiled regex

// Function called by nftw for each file/directory
int process_path(const char *filepath, const struct stat *sb, int typeflag, struct FTW *ftwbuf) {
    if (typeflag == FTW_F) { // Only process regular files
        if (regexec(&regex, filepath, 0, NULL, 0) == 0) { // Regex match found
            if (matching_files.count >= matching_files.capacity) {
                matching_files.capacity *= ARRAY_RESIZE_FACTOR;
                matching_files.filepaths = realloc(matching_files.filepaths, matching_files.capacity * sizeof(char*));
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

// Function to print the array of matching files
void print_matching_files() {
    printf("Matching files:\n");
    for (int i = 0; i < matching_files.count; i++) {
        printf("%s\n", matching_files.filepaths[i]);
    }
    printf("Total matching files: %d\n", matching_files.count);
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
    matching_files.filepaths = malloc(matching_files.capacity * sizeof(char*));
    if (!matching_files.filepaths) {
        perror("Memory allocation error");
        regfree(&regex); // Free regex resources before exiting
        return EXIT_FAILURE;
    }


    if (nftw(dir_path, process_path, 20, FTW_PHYS) == -1) {
        perror("nftw");
        regfree(&regex); // Free regex resources before exiting
        free_matching_files_array(); // Free allocated array memory
        return EXIT_FAILURE;
    }

    //print_matching_files();
    
    for (int i = 0; i < matching_files.count; i++) {
        //printf("%s\n", matching_files.filepaths[i]);
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
        //printf("%s",buff);
      FILE *fname;                          /* input-file pointer */
      char *fname_file_name = "file_xxh64"; /* input-file name    */
      fname = fopen(fname_file_name, "a+");
      if (fname == NULL) {
        fprintf(stderr, "couldn't open file '%s'; %s\n", fname_file_name,
                strerror(errno));
        exit(EXIT_FAILURE);
      }
      {
        fprintf(fname, "%s  ", matching_files.filepaths[i]);

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
		fprintf(hash_test,"%s\n",matching_files.filepaths[i]);
		scanner((char *)buff, hash_test, s.st_size,matching_files.filepaths[i]);
		  if (fclose(hash_test) == EOF) { /* close output file   */
    fprintf(stderr, "couldn't close file '%s'; %s\n", "offsets",
            strerror(errno));
    exit(EXIT_FAILURE);
  }}}
  update_tf_idf(matching_files.count); 
  printf("sorting structs\n");
  srt();
  /* print_tokens(); */
  /* print_tf_idf(); */
  printf("writing tf_idf scores to tf_idf\n");
  write_tf_idf();
  delete_all();

    free_matching_files_array(); // Clean up array memory
    regfree(&regex); // Free regex resources

    return EXIT_SUCCESS;
    }


