#include <stdio.h>
#include <stdlib.h> 
#define MAXN 15

int* arr = (int*)0x30000000;
int* flag = (int*)0x30000004;

void swap(int *a, int *b)
{
    *a = *a ^ *b;
    *b = *a ^ *b;
    *a = *a ^ *b;
}

void random_init()
{
    for (int i = 0; i < MAXN; i++)
    {
        *(arr+i) = rand() % 100;
    }
}

void print_address()
{
    printf("%p\n", flag);
    for (int i = 0; i < MAXN; i++)
    {
        printf("%p\n", arr + i);
    }
    printf("\n");
}

int main()
{
    *flag = 1;
    random_init();
    print_address();
    while (1)
    {
        if (*flag) {
            for (int i = 0; i < MAXN; i++)
            {
                for (int j = 0; j < MAXN - i - 1; j++)
                {
                    if (*(arr+j) > *(arr + j + 1))
                    {
                        swap(arr + j, arr + j + 1);
                    }
                }
            }
            //flag = 0;
        }
        // // clear the screen
        // system("cls");
        // for (int i = 0; i < MAXN; i++)
        // {
        //     printf("%d ", arr[i]);
        // }
    }
}