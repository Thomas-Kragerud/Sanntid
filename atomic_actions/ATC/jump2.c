#include <stdio.h>
#include <setjmp.h>

static jmp_buf buff;

void second() {
    printf("second\n"),
    longjmp(buff, 1);
}

void first(){
    second();
    printf("first\n");
}

int main() {
    if ( !setjmp(buff)) {
        first();
    } else {
        printf("main ...\n");
    }
    return 0;
}

// output:
// second 
// main ... 