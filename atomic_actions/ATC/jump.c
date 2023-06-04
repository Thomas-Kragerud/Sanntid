#include <stdio.h>
#include <setjmp.h>

jmp_buf buffer;

void functionB() {
    printf("Jumping from function B to function A!\n");
    longjmp(buffer, 1);
    // When longjmp is called, it restores the state that was saved in jmp_buf by setjmp
    // causing the program to jump back to the point where setjmp was called.
}

void functionA() {
    // Setjmp is called in the if statment
    // Since its the first time its called it returns zero
    // setjmp saves the programs stack pointer and instruction pointer 
    if (setjmp(buffer) != 0) {
        // Since longjump was called with "1", setjmp returns 1 the second time, and we go in here
        printf("Back in function A\n");
    } else {
        printf("Going from functionA to functionB...\n");
        functionB();
    }
}

int main() {
    functionA();
    return 0;
}