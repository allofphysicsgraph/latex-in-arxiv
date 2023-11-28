#include "xxhash.h"
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
#include <unistd.h>

/* hash a symbol */
static unsigned long long tokenHash(char token[]) {
  XXH64_hash_t const seed = 0;

  XXH64_hash_t hash = XXH64(token, strlen(token) * sizeof(*token), seed);
  return hash;
}

int main(int argc, char **argv) {

  struct stat s;
  int fd;
  fd = open(argv[1], O_RDONLY);
  char *buffer;
  // if (fd < 0)
  // kore_log(EXIT_FAILURE;
  fstat(fd, &s);
  /* PROT_READ disallows writing to buffer: will segv */
  buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  char test_buffer[s.st_size];

  memset(test_buffer, '\0', s.st_size);
  if (buffer != (void *)-1) {
    size_t buffer_idx = 0;
    int test_buffer_idx = 0;
    while (buffer_idx < strlen(buffer)) {
      if (buffer[buffer_idx] != '\n') {
        test_buffer[test_buffer_idx] = buffer[buffer_idx];
        test_buffer_idx++;
      } else {
        printf("%016llx:%s\n", tokenHash(test_buffer), test_buffer);
        memset(test_buffer, '\0', s.st_size);
        test_buffer_idx = 0;
      }
      buffer_idx++;
    }
    munmap(buffer, s.st_size);
  }
  close(fd);

  return 0;
}
