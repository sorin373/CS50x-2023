// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
} node;

// TODO: Choose number of buckets in hash table
const unsigned int N = 26;
unsigned int value, wordCount;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    value = hash(word);
    node *ptr = table[value];

    while (ptr != NULL)
    {
        if (strcasecmp(word, ptr->word) == 0)
            return true;
        ptr = ptr->next;
    }

    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    unsigned int hashValue = 0;

    for (int i = 0; i < strlen(word); i++)
        hashValue += toupper(word[i]);

    return hashValue % N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO
    FILE *file = fopen(dictionary, "r");
    char word[46] = {0};

    if (file == NULL)
    {
        printf("Can't open dictionary!\n");
        return false;
    }

    while (fscanf(file, "%s", word) != EOF)
    {
        node *word_node = malloc(sizeof(node));

        if (word_node == NULL)
            return false;

        strcpy(word_node->word, word);
        value = hash(word);

        word_node->next = table[value];
        table[value] = word_node;
        wordCount++;
    }

    fclose(file);

    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    if (wordCount > 0)
        return wordCount;
    return 0;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    for (unsigned int i = 0; i < N; i++)
    {
        node *ptr = table[i];
        while (ptr != NULL)
        {
            node *temp = ptr;
            ptr = ptr->next;
            free(temp);
        }
    }

    return true;
}
