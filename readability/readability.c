#include <cs50.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int getSentences(const string s, const unsigned int l)
{
    unsigned int count = 0;
    for (unsigned int i = 0; i < l; i++)
        if (s[i] == '.' || s[i] == '!' || s[i] == '?')
            count++;

    return count;
}

int getLetters(const string s, const unsigned int l)
{
    unsigned int count = 0;
    for (unsigned int i = 0; i < l; i++)
        if ((s[i] >= 'a' && s[i] <= 'z') || (s[i] >= 'A' && s[i] <= 'Z'))
            count++;

    return count;
}

int getWords(const string s, const unsigned int l)
{
    unsigned int count = 0;
    for (unsigned int i = 0; i < l; i++)
        if (s[i] == ' ')
            count++;

    return count + 1;
}

int main(void)
{
    unsigned int l;
    string s = get_string("Enter: ");
    l = strlen(s);

    // printf("%i %i %i\n\n", getSentences(s, l), getLetters(s, l), getWords(s, l));

    double words = getWords(s, l), letters = getLetters(s, l), sentences = getSentences(s, l);
    double L = ((double) letters / (double) words) * 100, S = ((double) sentences / (double) words) * 100;

    // printf("%f %f\n\n", L, S);

    int index = round(0.0588 * L - 0.296 * S - 15.8);

    if (index < 1)
        printf("Before Grade 1\n");
    else if (index < 16)
        printf("Grade %i\n", index);
    else
        printf("Grade 16+\n");
}