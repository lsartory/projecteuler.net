.equ TARGET, 100

.text
.globl _start
_start:
    # Set the initial value
    mov $TARGET, %ecx
    xor %r8, %r8
    xor %r9, %r9

main_loop:
    add %rcx, %r8  # Accumulate all integers in %r8

    xor %rdx, %rdx # Set the upper bits to zero for the multiplication
    mov %rcx, %rax # Set the lower bits
    mul %rax       # Muliply %rax by %rax to get the square value
    add %rax, %r9  # Accumulate the squares
    loop main_loop # Loop until %rcx is zero

    xor %rdx, %rdx # Set the upper bits to zero for the multiplication
    mov %r8, %rax  # Set the lower bits
    mul %rax       # Muliply %rax by %rax to get the square value

    # Print the result
    sub %r9, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
