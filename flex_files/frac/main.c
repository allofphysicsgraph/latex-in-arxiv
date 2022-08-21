#include "base_flex.h"
#include <ctype.h>
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include "globals.h"

int main(int argc, char **argv) {
struct stat s;
char *buffer;
int fd;
fd = open(argv[1], O_RDONLY);
if (fd < 0)
  return EXIT_FAILURE;
strcpy(filename,argv[1]);
strncpy(results_filename,argv[0],strlen(argv[0])-3);
strcat(results_filename,"csv");
fstat(fd, &s);
/* PROT_READ disallows writing to buffer: will segv */
buffer = mmap(0, s.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
// read file ok -> then process with flex
if (buffer != (void *)-1) {
  yybuffer buff1; // create a new buffer
  buff1 = S1__scan_string(buffer); // read string into buff1
  S1__switch_to_buffer(buff1);     // switch to the new buffer
  S1_out=fopen(results_filename,"a+");
  S1_lex();                        // run the lexer defined in scanner.l
  S1__delete_buffer(buff1);        // delete the buffer
  munmap(buffer, s.st_size);       // unmap the file from memory
}

close(fd); // close file descriptor.
return 0;
}
