#include <cs50.h>
#include <stdio.h>

long int N;
unsigned int digit;

bool valid_card(void)
{
    unsigned int two_sum = 0, sum = 0, finalSum = 0;
    long int CN = N;

    while (CN)
    {
        digit++;
        if (digit % 2 == 0)
        {
            unsigned int digit_sum = 0, d = (CN % 10) * 2;

            if (d >= 10)
                while (d > 0)
                {
                    digit_sum += d % 10;
                    d /= 10;
                }
            else
                digit_sum = d;

            two_sum += digit_sum;
        }
        else
            sum += CN % 10;

        finalSum = two_sum + sum;

        CN /= 10;
    }

    printf("%i", finalSum);

    if (finalSum % 10 != 0)
        return false;

    return true;
}

void card_type(void)
{
    if (valid_card() == true)
    {
        while (N > 99)
            N /= 10;

        if (digit == 15 && (N == 34 || N == 37))
            printf("AMEX\n");
        else if (digit == 16 && (N > 50 && N < 56))
            printf("MASTERCARD\n");
        else if ((digit == 13 || digit == 16) && (N / 10) % 10 == 4)
            printf("VISA\n");
        else
            printf("INVALID\n");
    }
    else
        printf("INVALID\n");
}

int main(void)
{
    N = get_long("Enter: ");

    card_type();
}