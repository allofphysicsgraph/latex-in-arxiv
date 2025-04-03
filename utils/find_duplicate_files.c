//gcc -O2 find_duplicate_files.c -lssl -lcrypto
#define _XOPEN_SOURCE 500 // Required for nftw in some systems
#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <openssl/sha.h>
#include <errno.h>

#include "uthash.h" // Include uthash.h for hash table

#define PATH_MAX 4096 // Standard PATH_MAX, adjust if needed
#define SHA256_DIGEST_STRING_LENGTH (SHA256_DIGEST_LENGTH * 2 + 1) // Length of SHA256 hex string + null terminator
#define CHUNK_SIZE 16384 // 16KB chunk size for reading files

// Structure to hold file paths for a given SHA256
struct DuplicateFiles {
    char sha256[SHA256_DIGEST_STRING_LENGTH];
    char **filepaths;
    int count;
    UT_hash_handle hh; // UTHash handle
};

struct DuplicateFiles *duplicates = NULL; // Hash table to store duplicates

// Function to calculate SHA256 hash of a file
char* calculate_sha256(const char *filepath) {
    FILE *file = fopen(filepath, "rb");
    if (!file) {
        perror("Error opening file");
        return NULL; // Indicate error
    }

    SHA256_CTX sha256_ctx;
    SHA256_Init(&sha256_ctx);

    unsigned char buffer[CHUNK_SIZE];
    size_t bytes_read;

    while ((bytes_read = fread(buffer, 1, CHUNK_SIZE, file))) {
        SHA256_Update(&sha256_ctx, buffer, bytes_read);
    }

    if (ferror(file)) {
        perror("Error reading file");
        fclose(file);
        return NULL; // Indicate error
    }

    fclose(file);

    unsigned char digest[SHA256_DIGEST_LENGTH];
    SHA256_Final(digest, &sha256_ctx);

    char *sha256_str = malloc(SHA256_DIGEST_STRING_LENGTH);
    if (!sha256_str) {
        perror("Memory allocation error");
        return NULL; // Indicate error
    }

    for (int i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        sprintf(&sha256_str[i * 2], "%02x", digest[i]);
    }
    sha256_str[SHA256_DIGEST_STRING_LENGTH - 1] = '\0';

    return sha256_str;
}

// Function to add a file path to the duplicates hash table
void add_duplicate(const char *sha256, const char *filepath) {
    struct DuplicateFiles *dup_file;
    HASH_FIND_STR(duplicates, sha256, dup_file);

    if (dup_file) {
        // SHA256 already exists, add filepath to the list
        dup_file->filepaths = realloc(dup_file->filepaths, (dup_file->count + 1) * sizeof(char*));
        if (!dup_file->filepaths) {
            perror("Memory allocation error");
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->filepaths[dup_file->count] = strdup(filepath);
        if (!dup_file->filepaths[dup_file->count]) {
            perror("Memory allocation error");
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->count++;
    } else {
        // SHA256 is new, create a new entry
        dup_file = malloc(sizeof(struct DuplicateFiles));
        if (!dup_file) {
            perror("Memory allocation error");
            exit(EXIT_FAILURE); // Critical error, exit
        }
        strncpy(dup_file->sha256, sha256, SHA256_DIGEST_STRING_LENGTH);
        dup_file->sha256[SHA256_DIGEST_STRING_LENGTH - 1] = '\0';
        dup_file->filepaths = malloc(sizeof(char*));
        if (!dup_file->filepaths) {
            perror("Memory allocation error");
            free(dup_file);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->filepaths[0] = strdup(filepath);
        if (!dup_file->filepaths[0]) {
            perror("Memory allocation error");
            free(dup_file->filepaths);
            free(dup_file);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->count = 1;
        HASH_ADD_STR(duplicates, sha256, dup_file);
    }
}

// Function called by nftw for each file/directory
int process_path(const char *filepath, const struct stat *sb, int typeflag, struct FTW *ftwbuf) {
    if (typeflag == FTW_F) { // Only process regular files
        char *sha256_str = calculate_sha256(filepath);
        if (sha256_str) {
            add_duplicate(sha256_str, filepath);
            free(sha256_str); // Free the SHA256 string after use
        }
    }
    return 0; // Continue traversal
}

// Function to print duplicate files
void print_duplicates() {
    struct DuplicateFiles *dup_file, *tmp;
    HASH_ITER(hh, duplicates, dup_file, tmp) {
        if (dup_file->count > 1) {
            printf("SHA256: %s\n", dup_file->sha256);
            for (int i = 0; i < dup_file->count; i++) {
                printf("%s\n", dup_file->filepaths[i]);
            }
            printf("\n");
        }
    }
}

// Function to free memory used by the duplicates hash table
void free_duplicates_table() {
    struct DuplicateFiles *dup_file, *tmp;
    HASH_ITER(hh, duplicates, dup_file, tmp) {
        HASH_DEL(duplicates, dup_file); // Remove from hash table BEFORE freeing to avoid issues if deletion itself has problems.
        if (dup_file->filepaths) { // Add null checks before freeing
            for (int i = 0; i < dup_file->count; i++) {
                if (dup_file->filepaths[i]) {
                    free(dup_file->filepaths[i]);
                }
            }
            free(dup_file->filepaths);
        }
        free(dup_file);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <directory1> <directory2> ...\n", argv[0]);
        return EXIT_FAILURE;
    }

    // Process each directory path provided as command line arguments
    for (int i = 1; i < argc; i++) {
        char *dir_path = argv[i];
        if (nftw(dir_path, process_path, 20, FTW_PHYS) == -1) {
            perror("nftw");
            fprintf(stderr, "Error processing directory: %s\n", dir_path);
            // Continue to next directory even if one fails, but you might want to exit
            // depending on desired error handling.  For now, continue processing other paths.
        }
    }

    print_duplicates();
    free_duplicates_table(); // Clean up memory

    return EXIT_SUCCESS;
}
