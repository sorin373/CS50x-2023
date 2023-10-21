#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Get user input
    string name = get_string("What is your name: ");

    // Print hello msg
    printf("hello, %s\n", name);
}