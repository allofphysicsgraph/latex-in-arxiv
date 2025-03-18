#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

#define handle_error(msg) \
    do { perror(msg); exit(EXIT_FAILURE); } while (0)

int main(int argc, char *argv[]) {
    if (argc < 4 || (argc - 2) % 2 != 0) {
        fprintf(stderr, "Usage: %s <filepath> <offset1_start> <offset1_end> [<offset2_start> <offset2_end> ...]\n", argv[0]);
        fprintf(stderr, "Offsets are integers representing byte positions within the file.\n");
        return EXIT_FAILURE;
    }

    const char *filepath = argv[1];
    int fd = -1;
    struct stat sb;
    char *mapped_file = MAP_FAILED;
    size_t file_size;

    // 1. Open the file
    fd = open(filepath, O_RDONLY);
    if (fd == -1)
        handle_error("open");

    // 2. Get file size
    if (fstat(fd, &sb) == -1) {
        close(fd);
        handle_error("fstat");
    }
    file_size = sb.st_size;

    // 3. Memory map the file
    mapped_file = (char *)mmap(NULL, file_size, PROT_READ, MAP_SHARED, fd, 0);
    if (mapped_file == MAP_FAILED) {
        close(fd);
        handle_error("mmap");
    }

    // 4. Iterate through offset pairs and print
    for (int i = 2; i < argc; i += 2) {
        long start_offset, end_offset;
        char *endptr_start, *endptr_end;

        // Convert start offset argument to integer
        start_offset = strtol(argv[i], &endptr_start, 10);
        if (endptr_start == argv[i] || *endptr_start != '\0' || start_offset < 0) {
            fprintf(stderr, "Invalid start offset: '%s'\n", argv[i]);
            goto cleanup;
        }

        // Convert end offset argument to integer
        if (i + 1 >= argc) {
            fprintf(stderr, "Missing end offset for start offset '%s'\n", argv[i]);
            goto cleanup;
        }
        end_offset = strtol(argv[i + 1], &endptr_end, 10);
        if (endptr_end == argv[i + 1] || *endptr_end != '\0' || end_offset < 0) {
            fprintf(stderr, "Invalid end offset: '%s'\n", argv[i + 1]);
            goto cleanup;
        }

        // Validate offsets
        if (start_offset >= file_size) {
            fprintf(stderr, "Start offset %ld is out of bounds (file size: %zu)\n", start_offset, file_size);
            continue; // Skip to the next pair
        }
        if (end_offset > file_size) {
            fprintf(stderr, "End offset %ld is out of bounds (file size: %zu)\n", end_offset, file_size);
            end_offset = file_size; // Clamp end offset to file size
        }
        if (start_offset >= end_offset) {
            fprintf(stderr, "Start offset %ld must be less than end offset %ld\n", start_offset, end_offset);
            continue; // Skip to the next pair
        }

        // Print the content between offsets
        printf("Content between offset %ld and %ld:\n", start_offset, end_offset);
        for (long j = start_offset; j < end_offset; ++j) {
            putchar(mapped_file[j]);
        }
        printf("\n---\n");
    }

cleanup:
    // 5. Unmap and close
    if (mapped_file != MAP_FAILED) {
        if (munmap(mapped_file, file_size) == -1)
            handle_error("munmap");
    }
    if (fd != -1) {
        if (close(fd) == -1)
            handle_error("close");
    }

    return EXIT_SUCCESS;
}

