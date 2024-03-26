#include <cs50.h>
#include <math.h>
#include <stdio.h>

int main(void)
{
    int cents;
    do
    {
        cents = get_float("Enter your change: ");
    }
    while (cents <= 0);


    int coins = 0;
    while (cents >= 25)
    {
        cents -= 25;
        coins++;
    }
    while (cents >= 10)
    {
        cents -= 10;
        coins++;
    }
    while (cents >= 5)
    {
        cents -= 5;
        coins++;
    }
    while (cents >= 1)
    {
        cents -= 1;
        coins++;
    }

    printf("You will need at least %i coins\n", coins);
}
