#include <errno.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define a more descriptive name and purpose for the function
// It now returns a dynamically allocated string containing the prefix up to the match, or NULL on error/no match.
char *get_prefix_up_to_regex_match(const char *buffer, const char *pattern) {
  if (buffer == NULL || pattern == NULL) {
    fprintf(stderr, "Error: Input buffer or pattern is NULL.\n");
    return NULL; // Handle null input
  }

  regex_t preg;
  regmatch_t substmatch[1];
  int regcomp_result;
  int regexec_result;
  char *result_string = NULL;

  // Compile the regex pattern
  regcomp_result = regcomp(&preg, pattern, REG_EXTENDED);
  if (regcomp_result != 0) {
    size_t error_buffer_size = 256;
    char error_buffer[error_buffer_size];
    regerror(regcomp_result, &preg, error_buffer, error_buffer_size);
    fprintf(stderr, "Error: regcomp failed: %s\n", error_buffer);
    return NULL; // Handle regex compilation error
  }

  // Execute the regex against the buffer
  regexec_result = regexec(&preg, buffer, 1, substmatch, 0);

  if (regexec_result == 0) {
    // Match found
    int match_end_offset = substmatch[0].rm_eo;
    if (match_end_offset > 0) {
      result_string = (char *)malloc(match_end_offset + 1); // +1 for null terminator
      if (result_string == NULL) {
        perror("malloc failed"); // Handle memory allocation failure
        regfree(&preg);
        return NULL;
      }
      strncpy(result_string, buffer, match_end_offset);
      result_string[match_end_offset] = '\0'; // Ensure null termination
    } else {
      // Empty match at the beginning of the string. Return empty string.
      result_string = strdup(""); // Allocate and copy empty string, handle malloc fail if needed.
      if (result_string == NULL) {
          perror("strdup failed");
          regfree(&preg);
          return NULL;
      }
    }

  } else if (regexec_result == REG_NOMATCH) {
    // No match found. Return NULL to indicate no match, caller can decide what to do.
    result_string = NULL; // or could return strdup(buffer) if you want the whole buffer back in nomatch case.
  } else {
    // regexec error
    size_t error_buffer_size = 256;
    char error_buffer[error_buffer_size];
    regerror(regexec_result, &preg, error_buffer, error_buffer_size);
    fprintf(stderr, "Error: regexec failed: %s\n", error_buffer);
    regfree(&preg);
    return NULL; // Handle regex execution error
  }

  regfree(&preg); // Free the compiled regex
  return result_string; // Return the dynamically allocated result string (or NULL)
}

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "Usage: %s <regex_pattern>\n", argv[0]);
    return EXIT_FAILURE; // Use EXIT_FAILURE and EXIT_SUCCESS for standard return codes
  }

  const char *test_buffer = "hello this is a pattern:       test:    again";
  const char *regex_pattern = argv[1];

  char *result = get_prefix_up_to_regex_match(test_buffer, regex_pattern);

  if (result != NULL) {
    printf("Result: %s\n", result);
    free(result); // Important: Free dynamically allocated memory when done
    return EXIT_SUCCESS;
  } else {
    printf("No match found or error occurred.\n");
    return EXIT_FAILURE; // Indicate failure if no match or error.
  }
}
/*
**Improvements and Explanations:**

1.  **Function Name and Purpose Clarity:**
    *   `get_prefix_up_to_regex_match` is a more descriptive name, clearly indicating the function's purpose.
    *   The function now returns a dynamically allocated string containing the portion of the input `buffer` *up to and including* the first regex match. If there's no match or an error, it returns `NULL`.

2.  **No Global `results` Buffer:**
    *   The global `results` buffer is removed. The function now dynamically allocates memory for the result string using `malloc`. This is crucial for memory safety and flexibility.

3.  **Simplified Logic and Efficiency:**
    *   The `while` loop and manual offset tracking are removed. `regexec` directly provides the starting and ending offsets of the *first* match in `substmatch[0].rm_so` and `substmatch[0].rm_eo`.
    *   We directly calculate the length of the prefix based on `substmatch[0].rm_eo`.
    *   Unnecessary string copies and manipulations are avoided.

4.  **Dynamic Memory Allocation and Memory Leak Prevention:**
    *   `malloc` is used to allocate memory for `result_string`.
    *   **Crucially, `free(result)` is called in `main`** after printing the result to release the allocated memory, preventing memory leaks.
    *   Error handling is added for `malloc` failure.
    *   `strdup("")` is used for allocating an empty string result when the match is at the beginning of the string. This also requires error handling for `strdup`.

5.  **Robust Error Handling:**
    *   **Input Validation:** Checks for `NULL` input `buffer` and `pattern`.
    *   **`regcomp` Error Handling:**  Uses `regerror` to get a human-readable error message if `regcomp` fails and prints it to `stderr`.
    *   **`regexec` Error Handling:** Uses `regerror` to handle errors from `regexec` other than `REG_NOMATCH`.
    *   **`malloc` Error Handling:** Checks if `malloc` returns `NULL` and handles memory allocation failures using `perror`.

6.  **Usability and Return Value:**
    *   The function returns a `char *` which is the dynamically allocated prefix string, or `NULL` on error or no match. This allows the caller to handle the result as needed (print it, further process it, etc.).
    *   The `replacement` argument is removed as it was unused and misleading.

7.  **Standard Return Codes:**
    *   `main` now returns `EXIT_SUCCESS` (0) on success and `EXIT_FAILURE` (non-zero) on failure, which are standard practice in C.

8.  **Usage Message:**
    *   `main` now prints a usage message to `stderr` if the correct number of arguments is not provided, improving usability.

**How to Compile and Run:**

1.  **Save:** Save the code as a `.c` file (e.g., `regex_prefix.c`).
2.  **Compile:** Use a C compiler (like GCC) to compile the code:
    ```bash
    gcc regex_prefix.c -o regex_prefix
    ```
3.  **Run:** Execute the compiled program, providing the regex pattern as a command-line argument:
    ```bash
    ./regex_prefix "test:\\s+"
    ```
    ```bash
    ./regex_prefix ":\\s+"
    ```
    ```bash
    ./regex_prefix "pattern:.*test:"
    ```

**Example Output (for `./regex_prefix "test:\\s+"`):**

```
Result: hello this is a pattern:       test:
```

**Key Performance Considerations:**

*   **Regex Compilation:** `regcomp` is relatively expensive. If you were to use the same regex pattern repeatedly in a loop, you would compile it *once* outside the loop and reuse the compiled `regex_t` structure for better performance. In this example, compilation is done only once per function call, which is acceptable for most cases.
*   **`regexec` Performance:** The performance of `regexec` depends on the complexity of the regex pattern and the input string. For simple patterns, it's generally quite fast. For very complex patterns or very large input strings, performance can be a concern.
*   **Memory Allocation (`malloc`, `free`):** Dynamic memory allocation has some overhead. In this case, it's necessary for memory safety and flexibility. If performance is absolutely critical and you know the maximum size of the result string in advance, you *could* potentially use a fixed-size buffer on the stack, but this would reintroduce the risk of buffer overflows and reduce flexibility. For general-purpose use, dynamic allocation is the better approach.
*   **String Copying (`strncpy`):** `strncpy` is used for copying the prefix. If performance is extremely critical, you could potentially optimize this further if needed, but for most applications, `strncpy` is efficient enough.

This improved version is more robust, memory-safe, easier to use, and performs efficiently for typical use cases. It addresses the issues in the original code and provides a better foundation for regex-based string processing in C.
*/
