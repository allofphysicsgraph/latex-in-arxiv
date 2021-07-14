#include <stdbool.h>

#define ALPHABET_SIZE 26
#define NUMBER_OF_WORDS (4816)
#define INPUT_WORD_SIZE (100)

typedef struct TrieNode TrieNode;
TrieNode *createTrieNode();
void insert(TrieNode *root, char *word);
void printArray(char chars[], int len);
int printPathsRecur(TrieNode *node, char prefix[], int filledLen,long unsigned int length);
int traverse(char prefix[], TrieNode *root,long unsigned int length);
char *receiveInput(char *s);
