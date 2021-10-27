//https://github.com/zedshaw/learn-c-the-hard-way-lectures/tree/master/ex16

/*
 * ==70251==
 * ==70251== HEAP SUMMARY:
 * ==70251==     in use at exit: 0 bytes in 0 blocks
 * ==70251==   total heap usage: 48 allocs, 48 frees, 7,118 bytes allocated
 * ==70251==
 * ==70251== All heap blocks were freed -- no leaks are possible
 * ==70251==
 * ==70251== For lists of detected and suppressed errors, rerun with: -s
 * ==70251== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
*/




#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#define MAX_LEN 256

typedef struct File {
    char *sha256;
    int count;
    char *filePath;
} File_type;

File_type *File_create(char *sha256, char* filePath, int count, int *array_idx)
{
    
    File_type *file = malloc(sizeof(File_type));
    assert(file != NULL);
    file->sha256 = strdup(sha256);
    file->filePath =strdup(filePath);
    file->count = count;
    (*array_idx)++;
    return file;
}

void File_destroy(File_type *file)
{
    assert(file != NULL);
    
    free(file->sha256);
    free(file->filePath);
    free(file);
}

void File_print(File_type *file)
{
    printf("sha256: %s\n", file->sha256);
    printf("\tfilePath: %s\n", file->filePath);
    printf("\tcount: %d\n", file->count);
}


int main(int argc, char *argv[])
{
    if (argc != 2) return -1;

    File_type *array[10000];
    FILE* fp;
    int array_idx=0;
    int *ptr = &array_idx;
    int i = 0;
    // print them out and where they are in memory
    char str[] = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  ./test_data";
    char *sha256, *filePath;
    char buffer[MAX_LEN];
    
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
      perror("Failed: ");
      return 1;
    }
    
    // -1 to allow room for NULL terminator for really long string
    // pass filename as argument where the file contains data from sha256sum     
    while (fgets(buffer, MAX_LEN - 1, fp))
    {
        // Remove trailing newline
        buffer[strcspn(buffer, "\n")] = 0;
    	sha256 = strtok( buffer, "  .");
    	filePath = strtok(NULL, "\n");
       	array[array_idx] = File_create(sha256, &filePath[1],i,ptr);
   	printf("%s:%s\n",array[array_idx-1]->sha256,array[array_idx-1]->filePath);  //array_idx gets incremented in File_create
    }

    fclose(fp);
    File_print(array[0]);
    
    for(i = 0; i<array_idx;i++){
	    File_destroy(array[i]);
    }

    return 0;
}
