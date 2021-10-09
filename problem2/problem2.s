.equ TARGET, 4000000

.text
.globl _start
_start:
    # Set 1 and 1 as the initial values
    mov $1, %r9
    mov $1, %r10
    xor %r11, %r11

loop:
    # Compute the Fibonacci sequence
    mov %r9, %r8
    mov %r10, %r9
    add %r8, %r10

    # Test if the upper bound is attained
    cmp $TARGET, %r10
    jge end

    # Check the parity
    test $1, %r10
    jnz loop

    # Sum the elements
    add %r10, %r11
    jmp loop

end:
    # Print the result
    mov %r11, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
