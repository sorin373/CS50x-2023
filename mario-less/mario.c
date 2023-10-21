#include <cs50.h>
#include <stdio.h>

unsigned int N;

void promptUser(void)
{
    do
    {
        N = get_int("Enter: ");
    }
    while (N < 1 || N > 8);
}

void solution(void)
{
    promptUser();

    for (unsigned int i = 1; i <= N; i++)
    {
        for (unsigned int k = N; k > i; k--)
            printf(" ");

        for (unsigned int t = 1; t <= i; t++)
            printf("#");

        printf("\n");
    }
}

int main(void)
{
    solution();
}