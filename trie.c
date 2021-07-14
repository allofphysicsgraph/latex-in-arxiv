/*------------------Trie Data Structure----------------------------------*/
/*-------------Implimented for search a word in dictionary---------------*/

/*-----character - 97 used for get the character from the ASCII value-----*/

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

/*--Node in the Trie--*/
typedef struct TrieNode
{
    struct TrieNode *children[ALPHABET_SIZE];
    char character;
    bool isEndOfWord;

} TrieNode;

/*--Create new node--*/
TrieNode *createTrieNode()
{
    TrieNode *node;
    node = malloc(sizeof(TrieNode));
    node->isEndOfWord = false;
    int i = 0;
    while (i < ALPHABET_SIZE)
    {
        node->children[i] = NULL;
        i++;
    }
    return node;
}

/*--Insert new word to Trie--*/
void insert(TrieNode *root, char *word)
{
    /*----Addition of the word done by recurcively----*/

    // Check wheather word character pointer is NULL
    if ((strlen(word) - 1) != 0)
    {
        char character = *word;
        if (root->children[character - 97] == NULL)
        {
            TrieNode *node = NULL;
            node = createTrieNode();
            node->character = character;
            root->children[character - 97] = node;
        }
        word++;
        insert(root->children[character - 97], word);
    }
    else
    {
        root->isEndOfWord = true;
    }
    return;
}

/*--Search a word in the Trie--*/
TrieNode *search(TrieNode *root, char *word)
{
    TrieNode *temp;
    while (*word != '\0')
    {
        char character = *word;
        if (root->children[character - 97] != NULL)
        {
            temp = root->children[character - 97];
            word++;
            root = temp;
        }
        else
        {
            //printf("No possible words!!\n");
            return NULL;
        }
    }
    return root;
}

/*---Print a word in the array--*/
void printArray(char chars[], int len)
{
    int i;
    for (i = 0; i < len; i++)
    {
        printf("%c", chars[i]);
    }
    printf("\n");
}

/*---Return all the related words------*/
int printPathsRecur(TrieNode *node, char prefix[], int filledLen,long unsigned int length)
{
    if (node == NULL)
        return 0;

    prefix[filledLen] = node->character;
    filledLen++;

    if (node->isEndOfWord)
    {
        if(strlen(prefix)==length){
		return 1;
		//printArray(prefix, filledLen);
	}
    }

    //int i;
    //for (i = 0; i < ALPHABET_SIZE; i++)
    //{
       // printPathsRecur(node->children[i], prefix, filledLen,length);
    //}
    return 0;
}

/*--Travel through the Trie and return words from it--*/
int traverse(char prefix[], TrieNode *root,long unsigned int length)
{
    TrieNode *temp = NULL;
    temp = search(root, prefix);
    int j = 0;
    while (prefix[j] != '\0')
    {
        j++;
    }
    
    if(strlen(prefix)==length){
	  return  printPathsRecur(temp, prefix, j - 1,length);
    }
    
    return 0;
}

/*------Demonstrate purposes uses text file called dictionary -------*/


/*----Get input from the user------*/
char *receiveInput(char *s)
{
    scanf("%99s", s);
    return s;
}



