.equ TARGET, 1000

.text
.globl _start
_start:
    # Set the initial conditions
    xor %r8, %r8
    mov $TARGET, %r9

loop:
    # Decrement the counter and exit when zero is attained
    dec %r9
    jz end

    # Check if the integer is divisible by 3
    xor %rdx, %rdx
    mov %r9, %rax
    mov $3, %rbx
    div %rbx
    test %edx, %edx
    jz found

    # Check if the integer is divisible by 5
    xor %rdx, %rdx
    mov %r9, %rax
    mov $5, %rbx
    div %rbx
    test %edx, %edx
    jnz loop

found:
    # Sum the integers
    add %r9, %r8
    jmp loop

end:
    # Print the result
    mov %r8, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
