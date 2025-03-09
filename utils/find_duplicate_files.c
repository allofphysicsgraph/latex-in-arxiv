/*

**Explanation and Improvements:**

1.  **Includes:**
    *   `<ftw.h>`: For directory traversal using `nftw`.
    *   `<stdio.h>`, `<stdlib.h>`, `<string.h>`, `<unistd.h>`, `<errno.h>`: Standard C libraries.
    *   `<openssl/sha.h>`: For SHA256 hashing using OpenSSL. You'll need to have OpenSSL installed and linked during compilation (e.g., `-lssl -lcrypto`).
    *   `"uthash.h"`: For using the `uthash` library to create a hash table for efficient duplicate detection. You'll need to download `uthash.h` and place it in your project directory or include path.

2.  **Error Handling:**  Includes `perror` for system call errors (like `fopen`, `fread`, `nftw`, memory allocation) and checks return values to handle failures gracefully.  Critical memory allocation failures will now exit the program to prevent further issues.

3.  **Performance and Memory Efficiency:**
    *   **Chunked File Reading:**  `calculate_sha256` reads files in `CHUNK_SIZE` (16KB) chunks, preventing loading the entire file into memory, crucial for large files and handling 100K files.
    *   **`nftw` for Directory Traversal:** `nftw` is a standard and efficient way to traverse directories in C.
    *   **Hash Table (`uthash`)**: Uses `uthash` for efficient storage and lookup of SHA256 hashes. Hash tables provide near constant-time average complexity for insertion and search, which is much better than linear search used in the original code (or even balanced trees for this specific purpose).

4.  **No Memory Leaks:**
    *   **`strdup` and `free`:** File paths are duplicated using `strdup` and freed when the hash table is cleaned up in `free_duplicates_table`.
    *   **SHA256 String `free`:** The SHA256 hash string returned by `calculate_sha256` is `free`d in `process_path` after being added to the hash table.
    *   **Hash Table Cleanup:** `free_duplicates_table` iterates through the hash table, frees all allocated file paths and the hash table entries themselves, preventing memory leaks.

5.  **Handling 100K Files:** The use of a hash table and chunked file reading is designed to handle a large number of files efficiently in terms of both time and memory.

6.  **Structure `DuplicateFiles`:**
    *   `sha256`: Stores the SHA256 hash as a string.
    *   `filepaths`: Dynamically allocated array of strings to hold file paths with the same SHA256.
    *   `count`:  Keeps track of the number of file paths for a given SHA256.
    *   `UT_hash_handle hh`: Required by `uthash` to make the structure hashable.

7.  **`calculate_sha256` Function:**
    *   Opens the file in binary read mode (`"rb"`).
    *   Initializes the SHA256 context.
    *   Reads the file in chunks using `fread`.
    *   Updates the SHA256 context with each chunk.
    *   Finalizes the SHA256 calculation.
    *   Converts the binary SHA256 digest to a hexadecimal string representation.
    *   Returns the SHA256 string (caller is responsible for freeing it).

8.  **`add_duplicate` Function:**
    *   Uses `HASH_FIND_STR` to check if a SHA256 already exists in the `duplicates` hash table.
    *   If it exists, it reallocates memory for `filepaths` to add the new file path.
    *   If it doesn't exist, it allocates a new `DuplicateFiles` structure and adds it to the hash table using `HASH_ADD_STR`.

9.  **`process_path` Function (NFTW Callback):**
    *   Called by `nftw` for each entry in the directory tree.
    *   Checks if the entry is a regular file (`FTW_F`).
    *   Calculates the SHA256 hash of the file using `calculate_sha256`.
    *   Calls `add_duplicate` to add the SHA256 and file path to the hash table.
    *   **Crucially frees the `sha256_str` returned by `calculate_sha256` to prevent memory leaks.**

10. **`print_duplicates` Function:**
    *   Iterates through the `duplicates` hash table using `HASH_ITER`.
    *   For each entry, if `count` is greater than 1 (meaning duplicates found), it prints the SHA256 and all the associated file paths.

11. **`free_duplicates_table` Function:**
    *   Iterates through the `duplicates` hash table using `HASH_ITER` and `HASH_DEL`.
    *   For each entry, it frees the allocated memory for `filepaths` and the `DuplicateFiles` structure itself.
    *   This is essential for cleaning up all dynamically allocated memory and preventing leaks.

12. **`main` Function:**
    *   Handles command-line arguments (expects the directory path as an argument).
    *   Calls `nftw` to start the directory traversal.
    *   Calls `print_duplicates` to display the results.
    *   Calls `free_duplicates_table` to free all allocated memory.

**To Compile and Run:**
**To Compile and Run:**

1.  **Install OpenSSL:**  Make sure you have OpenSSL development libraries installed on your system (e.g., `libssl-dev` on Debian/Ubuntu, `openssl-devel` on Fedora/CentOS).
2.  **Download `uthash.h`:** Get `uthash.h` from [https://troydhanson.github.io/uthash/](https://troydhanson.github.io/uthash/) and place it in the same directory as your C code or in your include path.
3.  **Compile:**
    ```bash
    gcc -o find_duplicates find_duplicates.c -lssl -lcrypto
    ```
4.  **Run:**
    ```bash
    ./find_duplicates <directory_to_scan>
    ```
*/

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
        for (int i = 0; i < dup_file->count; i++) {
            free(dup_file->filepaths[i]);
        }
        free(dup_file->filepaths);
        HASH_DEL(duplicates, dup_file);
        free(dup_file);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <directory>\n", argv[0]);
        return EXIT_FAILURE;
    }

    char *dir_path = argv[1];

    if (nftw(dir_path, process_path, 20, FTW_PHYS) == -1) {
        perror("nftw");
        return EXIT_FAILURE;
    }

    print_duplicates();
    free_duplicates_table(); // Clean up memory

    return EXIT_SUCCESS;
}
