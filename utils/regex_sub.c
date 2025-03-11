#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

// Function to perform regex replace on a file
//
// Parameters:
//   filepath: Path to the file to modify.
//   pattern:  Regular expression pattern to search for.
//   replacement: String to replace the matched pattern with.
//
// Returns:
//   0 on success, -1 on error (and prints error message to stderr).
//
int regex_replace_file(const char *filepath, const char *pattern, const char *replacement) {
    FILE *fp = NULL;
    char *file_content = NULL;
    long file_size;
    regex_t regex;
    int regex_result;
    char error_buffer[1024];
    char *modified_content = NULL;
    size_t modified_content_len = 0;
    size_t content_pos = 0;
    regmatch_t match;

    // 1. Open the file in read mode
    fp = fopen(filepath, "r");
    if (fp == NULL) {
        perror("Error opening file");
        return -1;
    }

    // 2. Get file size
    fseek(fp, 0, SEEK_END);
    file_size = ftell(fp);
    fseek(fp, 0, SEEK_SET); // rewind to the beginning

    // 3. Allocate memory to read the entire file content
    file_content = (char *)malloc(file_size + 1); // +1 for null terminator
    if (file_content == NULL) {
        perror("Error allocating memory for file content");
        fclose(fp);
        return -1;
    }

    // 4. Read the file content
    if (fread(file_content, 1, file_size, fp) != file_size) {
        perror("Error reading file");
        fclose(fp);
        free(file_content);
        return -1;
    }
    file_content[file_size] = '\0'; // Null-terminate the string
    fclose(fp); // Close the file after reading

    // 5. Compile the regular expression
    regex_result = regcomp(&regex, pattern, REG_EXTENDED); // REG_EXTENDED for extended regex syntax like in sed -E
    if (regex_result != 0) {
        regerror(regex_result, &regex, error_buffer, sizeof(error_buffer));
        fprintf(stderr, "Regex compilation error: %s\n", error_buffer);
        free(file_content);
        return -1;
    }

    // 6. Perform regex replace iteratively
    modified_content = (char *)malloc(file_size + 1); // Initial allocation, might realloc later
    if (modified_content == NULL) {
        perror("Error allocating memory for modified content");
        regfree(&regex);
        free(file_content);
        return -1;
    }
    modified_content[0] = '\0'; // Initialize as empty string

    while (1) {
        regex_result = regexec(&regex, file_content + content_pos, 1, &match, 0);
        if (regex_result == REG_NOMATCH) {
            // No more matches, append the rest of the content and break
            strcat(modified_content, file_content + content_pos);
            break;
        } else if (regex_result != 0) {
            regerror(regex_result, &regex, error_buffer, sizeof(error_buffer));
            fprintf(stderr, "Regex execution error: %s\n", error_buffer);
            regfree(&regex);
            free(file_content);
            free(modified_content);
            return -1;
        }

        // Append the part of the content before the match
        size_t prefix_len = match.rm_so;
        strncat(modified_content, file_content + content_pos, prefix_len);
        modified_content_len += prefix_len;
        modified_content[modified_content_len] = '\0'; // Keep null-terminated

        // Append the replacement string
        strcat(modified_content, replacement);
        modified_content_len += strlen(replacement);

        // Move content_pos to the end of the matched part
        content_pos += match.rm_eo;
    }

    regfree(&regex); // Free the regex resources
    free(file_content); // Free the original file content

    // 7. Open the file in write mode to overwrite with modified content
    fp = fopen(filepath, "w");
    if (fp == NULL) {
        perror("Error opening file for writing");
        free(modified_content);
        return -1;
    }

    // 8. Write the modified content back to the file
    if (fputs(modified_content, fp) == EOF) {
        perror("Error writing modified content to file");
        fclose(fp);
        free(modified_content);
        return -1;
    }

    fclose(fp);
    free(modified_content); // Free the modified content buffer

    return 0; // Success
}

// Example of how to call this function from another C program
// You can compile this file and then link it with another C program.
//#ifdef BUILD_AS_EXECUTABLE // Define this when compiling this file directly to test
int main() {
    const char *filepath = "test.txt"; // Replace with your test file
    const char *pattern = "old_pattern";   // Replace with your regex pattern
    const char *replacement = "new_pattern"; // Replace with your replacement string

    // Create a dummy test file if it doesn't exist
    FILE *test_fp = fopen(filepath, "r");
    if (test_fp == NULL) {
        test_fp = fopen(filepath, "w");
        if (test_fp != NULL) {
            fprintf(test_fp, "This is a line with old_pattern in it.\nAnother line with old_pattern again.\nAnd one more line without the pattern.\n");
            fclose(test_fp);
        } else {
            perror("Error creating test file");
            return 1;
        }
    } else {
        fclose(test_fp);
    }


    if (regex_replace_file(filepath, pattern, replacement) == 0) {
        printf("Regex replace successful on file: %s\n", filepath);
    } else {
        fprintf(stderr, "Regex replace failed on file: %s\n", filepath);
        return 1;
    }

    return 0;
}
//#endif


