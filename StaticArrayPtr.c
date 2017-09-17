#include <stdlib.h>
#include <stdio.h>

void change_int_array(int *a, int a_size)
{
    for(int i=0; i< a_size; i++)
    {
        a[i] = i*100;
    }
}

int main()
{
    int a[10];
    int a_size = 10;
    
    int *ap = a;
    //int *ap = (int *)&a; Ashley's version
    
    for (int i = 0; i < a_size; i++)
    {
        printf("a[%d] = %d \n", i, a[i]);
    }
    
    change_int_array(ap, a_size);
    
    for (int i = 0; i < a_size; i++)
    {
        printf("a[%d] = %d \n", i, a[i]);
    }
    
    return 0;
}
