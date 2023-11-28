#include <assert.h>
#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

// Experimenting with searching large arrays of structs
// memory grows exponentially beyond 10K lines
// does not properly compile with O2 or O3 flags

// real	0m1.372s
// user	0m1.308s
// sys	0m0.064s

// valgrind running ./a.out 10K lines
/*==72363==
==72363== HEAP SUMMARY:
==72363==     in use at exit: 0 bytes in 0 blocks
==72363==   total heap usage: 9,978 allocs, 9,978 frees, 17,240,975,368 bytes
allocated
==72363==
==72363== All heap blocks were freed -- no leaks are possible
==72363==
==72363== For lists of detected and suppressed errors, rerun with: -s
==72363== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
*/

int array_length = 0;
#define MAX_FILE_PATH_LENGTH 128
#define MAX_LINE_COUNT 13500

struct Finfo {
  char sha256[65];
  int filePathidx;
  char filePaths[MAX_LINE_COUNT][MAX_FILE_PATH_LENGTH];
};

struct Finfo *Finfo_create(char *sha256, char *filePath) {
  struct Finfo *file = malloc(sizeof(struct Finfo));
  assert(file != NULL);
  assert(sha256 != NULL);
  assert(filePath != NULL);
  strcpy(file->sha256, sha256);
  strcpy(file->filePaths[0], filePath);
  file->filePathidx = 1;
};

void Finfo_destroy(struct Finfo *file) {
  assert(file != NULL);
  free(file);
};

int Finfo_search(struct Finfo **array, char *sha256) {
  for (int i = 0; i < array_length; i++) {
    if (strcmp(array[i]->sha256, sha256) == 0) {
      return i;
    }
  }
  return -1;
}

void Finfo_create_append_fp(struct Finfo **array, char *sha256, char *fp) {
  assert(sha256 != NULL);
  assert(fp != NULL);
  int exists = Finfo_search(array, sha256);
  if (exists == -1) {
    array[array_length] = Finfo_create(sha256, fp);
    array_length++;
  } else {
    int fp_idx = array[exists]->filePathidx;
    strcpy(array[exists]->filePaths[fp_idx], fp);
    array[exists]->filePathidx++;
  }
}

void Finfo_print(struct Finfo **array) {
  for (int i = 0; i < array_length; i++) {
    assert(array[i]->sha256 != NULL);

    if (array[i]->filePathidx > 1) {

      printf("%s\n", array[i]->sha256);

      for (int j = 0; j < array[i]->filePathidx; j++) {
        if (array[i]->filePaths[j] != NULL) {
          if (j == 0) {
            printf("%s\n", array[i]->filePaths[j]);
          } else {
            // tab for duplicate files for scripting deletion
            printf("\t%s\n", array[i]->filePaths[j]);
          }
        }
      }
    }
  }
}

int main(int argc, char **argv) {

  struct Finfo *array[MAX_LINE_COUNT];
  int array_idx = 0;
  struct stat s;
  char *buffer;
  int fd;
  char *filePath;
  char *sha256;
  fd = open(argv[1], O_RDONLY);
  if (fd < 0)
    return EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */
  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (buffer != (void *)-1) {
    char tmp[s.st_size];
    memset(tmp, '\0', s.st_size);
    int tmp_idx = 0;
    for (int i = 0; i < s.st_size; i++) {
      tmp[tmp_idx] = buffer[i];
      if (tmp[tmp_idx] == '\n') {
        tmp[strcspn(tmp, "\n")] = 0;
        sha256 = strtok(tmp, "  .");
        filePath = strtok(NULL, "\n");
        if (sha256 != NULL && filePath != NULL) {
          Finfo_create_append_fp(array, sha256, filePath);
        }
        memset(tmp, '\0', s.st_size);
        tmp_idx = 0;
      } else {
        tmp_idx++;
      }
    }
    munmap(buffer, s.st_size);
  }
  close(fd);

  Finfo_print(array);

  for (int i = 0; i < array_length; i++) {
    assert(array[i] != NULL);
    Finfo_destroy(array[i]);
  }

  return 0;
}
