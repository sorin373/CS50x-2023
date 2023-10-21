#include <cs50.h>
#include <stdio.h>

int startingPop = 0, endingPop = 0;

// Prompt user for input
void startPrompt(void)
{
    do
    {
        startingPop = get_int("Start size: ");
    }
    while (startingPop < 9);

    do
    {
        endingPop = get_int("End size: ");
    }
    while (endingPop < startingPop);
}

// Problem logic
int calcYears(void)
{
    int years = 0;

    // printf("%i %i\n", startingPop, endingPop);

    while (startingPop < endingPop)
    {
        startingPop = startingPop + (startingPop / 3) - (startingPop / 4);
        years++;
    }

    return years;
}

int main(void)
{
    startPrompt();

    printf("Years: %i\n", calcYears());
}
