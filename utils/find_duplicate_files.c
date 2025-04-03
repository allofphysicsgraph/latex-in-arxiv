#define _XOPEN_SOURCE 500 // Required for nftw in some systems
#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <openssl/sha.h>
#include <errno.h>
#include <pthread.h>
#include <semaphore.h>

#include "uthash.h" // Include uthash.h for hash table

#define PATH_MAX 4096 // Standard PATH_MAX, adjust if needed
#define SHA256_DIGEST_STRING_LENGTH (SHA256_DIGEST_LENGTH * 2 + 1) // Length of SHA256 hex string + null terminator
#define CHUNK_SIZE 16384 // 16KB chunk size for reading files
#define THREAD_POOL_SIZE 8 // Number of threads in the pool, can be adjusted
#define TASK_QUEUE_SIZE 65536 // Size of the task queue, can be adjusted

// Structure to hold file paths for a given SHA256
struct DuplicateFiles {
    char sha256[SHA256_DIGEST_STRING_LENGTH];
    char **filepaths;
    int count;
    pthread_mutex_t filepaths_mutex; // Mutex to protect filepaths array
    UT_hash_handle hh; // UTHash handle
};

struct DuplicateFiles *duplicates = NULL; // Hash table to store duplicates
pthread_mutex_t duplicates_mutex = PTHREAD_MUTEX_INITIALIZER; // Mutex for hash table

// Task structure for the thread pool
typedef struct {
    char filepath[PATH_MAX];
} Task;

// Thread pool structure
typedef struct {
    pthread_t threads[THREAD_POOL_SIZE];
    Task task_queue[TASK_QUEUE_SIZE];
    int queue_head;
    int queue_tail;
    pthread_mutex_t queue_mutex;
    sem_t queue_sem; // Semaphore to signal tasks in queue
    pthread_mutex_t shutdown_mutex;
    int shutdown;
} ThreadPool;

ThreadPool pool;

// Function to calculate SHA256 hash of a file
char* calculate_sha256(const char *filepath) {
    FILE *file = fopen(filepath, "rb");
    if (!file) {
        if (errno != ENOENT) { // Only print error if not "file not found" (which can happen during traversal)
            perror("Error opening file");
        }
        return NULL; // Indicate error, but handle ENOENT silently in caller if needed
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

// Function to add a file path to the duplicates hash table (thread-safe)
void add_duplicate(const char *sha256, const char *filepath) {
    struct DuplicateFiles *dup_file;

    pthread_mutex_lock(&duplicates_mutex); // Lock hash table for thread-safe access
    HASH_FIND_STR(duplicates, sha256, dup_file);

    if (dup_file) {
        // SHA256 already exists, add filepath to the list
        pthread_mutex_lock(&dup_file->filepaths_mutex); // Lock filepaths list
        dup_file->filepaths = realloc(dup_file->filepaths, (dup_file->count + 1) * sizeof(char*));
        if (!dup_file->filepaths) {
            perror("Memory allocation error");
            pthread_mutex_unlock(&dup_file->filepaths_mutex);
            pthread_mutex_unlock(&duplicates_mutex);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->filepaths[dup_file->count] = strdup(filepath);
        if (!dup_file->filepaths[dup_file->count]) {
            perror("Memory allocation error");
            pthread_mutex_unlock(&dup_file->filepaths_mutex);
            pthread_mutex_unlock(&duplicates_mutex);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->count++;
        pthread_mutex_unlock(&dup_file->filepaths_mutex); // Unlock filepaths list
    } else {
        // SHA256 is new, create a new entry
        dup_file = malloc(sizeof(struct DuplicateFiles));
        if (!dup_file) {
            perror("Memory allocation error");
            pthread_mutex_unlock(&duplicates_mutex);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        strncpy(dup_file->sha256, sha256, SHA256_DIGEST_STRING_LENGTH);
        dup_file->sha256[SHA256_DIGEST_STRING_LENGTH - 1] = '\0';
        dup_file->filepaths = malloc(sizeof(char*));
        if (!dup_file->filepaths) {
            perror("Memory allocation error");
            free(dup_file);
            pthread_mutex_unlock(&duplicates_mutex);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->filepaths[0] = strdup(filepath);
        if (!dup_file->filepaths[0]) {
            perror("Memory allocation error");
            free(dup_file->filepaths);
            free(dup_file);
            pthread_mutex_unlock(&duplicates_mutex);
            exit(EXIT_FAILURE); // Critical error, exit
        }
        dup_file->count = 1;
        pthread_mutex_init(&dup_file->filepaths_mutex, NULL); // Initialize mutex for new entry
        HASH_ADD_STR(duplicates, sha256, dup_file);
    }
    pthread_mutex_unlock(&duplicates_mutex); // Unlock hash table
}

// Worker thread function
void *worker_thread(void *arg) {
    ThreadPool *pool = (ThreadPool*)arg;
    while (1) {
        sem_wait(&pool->queue_sem); // Wait for a task to be available
        pthread_mutex_lock(&pool->queue_mutex);
        if (pool->shutdown && pool->queue_head == pool->queue_tail) {
            pthread_mutex_unlock(&pool->queue_mutex);
            break; // Exit thread on shutdown signal
        }
        Task task = pool->task_queue[pool->queue_head % TASK_QUEUE_SIZE];
        pool->queue_head = (pool->queue_head + 1) % TASK_QUEUE_SIZE;
        pthread_mutex_unlock(&pool->queue_mutex);

        char *sha256_str = calculate_sha256(task.filepath);
        if (sha256_str) {
            add_duplicate(sha256_str, task.filepath);
            free(sha256_str);
        }
    }
    return NULL;
}

// Initialize thread pool
void thread_pool_init(ThreadPool *pool) {
    pool->queue_head = pool->queue_tail = 0;
    pthread_mutex_init(&pool->queue_mutex, NULL);
    sem_init(&pool->queue_sem, 0, 0);
    pthread_mutex_init(&pool->shutdown_mutex, NULL);
    pool->shutdown = 0;

    for (int i = 0; i < THREAD_POOL_SIZE; i++) {
        if (pthread_create(&pool->threads[i], NULL, worker_thread, pool) != 0) {
            perror("Failed to create thread");
            exit(EXIT_FAILURE);
        }
    }
}

// Add task to thread pool
void thread_pool_add_task(ThreadPool *pool, const char *filepath) {
    pthread_mutex_lock(&pool->queue_mutex);
    if ((pool->queue_tail + 1) % TASK_QUEUE_SIZE == pool->queue_head) {
        fprintf(stderr, "Task queue is full. Filepath: %s\n", filepath); // Handle queue overflow, consider increasing TASK_QUEUE_SIZE
        pthread_mutex_unlock(&pool->queue_mutex);
        return; // Or handle overflow in a different way, like blocking or resizing queue.
    }
    strncpy(pool->task_queue[pool->queue_tail % TASK_QUEUE_SIZE].filepath, filepath, PATH_MAX - 1);
    pool->task_queue[pool->queue_tail % TASK_QUEUE_SIZE].filepath[PATH_MAX - 1] = '\0'; // Ensure null termination
    pool->queue_tail = (pool->queue_tail + 1) % TASK_QUEUE_SIZE;
    pthread_mutex_unlock(&pool->queue_mutex);
    sem_post(&pool->queue_sem); // Signal that a new task is available
}

// Shutdown thread pool
void thread_pool_shutdown(ThreadPool *pool) {
    pthread_mutex_lock(&pool->shutdown_mutex);
    pool->shutdown = 1;
    pthread_mutex_unlock(&pool->shutdown_mutex);
    for (int i = 0; i < THREAD_POOL_SIZE; i++) {
        sem_post(&pool->queue_sem); // Signal threads to exit
    }
    for (int i = 0; i < THREAD_POOL_SIZE; i++) {
        if (pthread_join(pool->threads[i], NULL) != 0) {
            perror("Failed to join thread");
        }
    }
    pthread_mutex_destroy(&pool->queue_mutex);
    sem_destroy(&pool->queue_sem);
    pthread_mutex_destroy(&pool->shutdown_mutex);
}


// Function called by nftw for each file/directory
int process_path(const char *filepath, const struct stat *sb, int typeflag, struct FTW *ftwbuf) {
    if (typeflag == FTW_F) { // Only process regular files
        thread_pool_add_task(&pool, filepath);
    }
    return 0; // Continue traversal
}

// Function to print duplicate files
void print_duplicates() {
    struct DuplicateFiles *dup_file, *tmp;
    pthread_mutex_lock(&duplicates_mutex); // Lock for reading hash table
    HASH_ITER(hh, duplicates, dup_file, tmp) {
        if (dup_file->count > 1) {
            printf("SHA256: %s\n", dup_file->sha256);
            pthread_mutex_lock(&dup_file->filepaths_mutex); // Lock filepaths list for printing
            for (int i = 0; i < dup_file->count; i++) {
                printf("%s\n", dup_file->filepaths[i]);
            }
            pthread_mutex_unlock(&dup_file->filepaths_mutex); // Unlock filepaths list
            printf("\n");
        }
    }
    pthread_mutex_unlock(&duplicates_mutex); // Unlock hash table
}

// Function to free memory used by the duplicates hash table
void free_duplicates_table() {
    struct DuplicateFiles *dup_file, *tmp;
    pthread_mutex_lock(&duplicates_mutex); // Lock for modifying hash table
    HASH_ITER(hh, duplicates, dup_file, tmp) {
        HASH_DEL(duplicates, dup_file); // Remove from hash table
        pthread_mutex_lock(&dup_file->filepaths_mutex); // Lock before accessing filepaths
        if (dup_file->filepaths) {
            for (int i = 0; i < dup_file->count; i++) {
                if (dup_file->filepaths[i]) {
                    free(dup_file->filepaths[i]);
                }
            }
            free(dup_file->filepaths);
        }
        pthread_mutex_unlock(&dup_file->filepaths_mutex);
        pthread_mutex_destroy(&dup_file->filepaths_mutex); // Destroy mutex
        free(dup_file);
    }
    pthread_mutex_unlock(&duplicates_mutex); // Unlock hash table
    pthread_mutex_destroy(&duplicates_mutex); // Destroy hash table mutex
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <directory1> <directory2> ...\n", argv[0]);
        return EXIT_FAILURE;
    }

    thread_pool_init(&pool);

    // Process each directory path provided as command line arguments
    for (int i = 1; i < argc; i++) {
        char *dir_path = argv[i];
        if (nftw(dir_path, process_path, 20, FTW_PHYS) == -1) {
            perror("nftw");
            fprintf(stderr, "Error processing directory: %s\n", dir_path);
            // Continue to next directory even if one fails
        }
    }

    thread_pool_shutdown(&pool); // Wait for all tasks to complete

    print_duplicates();
    free_duplicates_table(); // Clean up memory

    return EXIT_SUCCESS;
}
