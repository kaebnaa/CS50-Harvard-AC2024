#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, string argv[])
{
    int k = atoi(argv[1]);
    string text = get_string("Plaintext: ");
    printf("Ciphertext: ");

    for (int j = 0; j < strlen(text); j++)
    {
        if (isupper(text[j]))
        {
            printf("%c", (text[j] - 65 + k) % 26 + 65);
        }
        else if (islower(text[j]))
        {
            printf("%c", (text[j] - 97 + k) % 26 + 97);
        }
        else
        {
            printf("%c", text[j]);
        }
    }
    printf("\n");
}
