.text
.globl _start
_start:
    # Set the initial values
    mov $1, %r12    # Use %r12 as storage for a
    mov $2, %r13    # Use %r13 as storage for b
    mov $3, %r14    # Use %r14 as storage for c

loop:
    # Check if a + b + c = 1000?
    mov %r12, %rax
    add %r13, %rax
    add %r14, %rax
    cmp $1000, %rax
    jne continue

    # Check if a² + b² = c²?
    mov %r14, %rax
    mul %rax
    mov %rax, %r8
    mov %r13, %rax
    mul %rax
    sub %rax, %r8
    mov %r12, %rax
    mul %rax
    cmp %rax, %r8
    je done

continue:
    inc %r12        # Increment a
    cmp %r13, %r12  # Check if a is smaller than b
    jl loop         # If yes, proceed
    mov $1, %r12    # If no, restart with a = 1
    inc %r13        # Increment b
    cmp %r14, %r13  # Check if b is smaller than c
    jl loop         # If yes, proceed
    mov $2, %r13    # If no, restart with b = 2
    inc %r14        # Increment c
    cmp $998, %r14  # Check if c is smaller than 998
    jl loop         # If yes, proceed

done:
    # Compute and print the result
    mov %r12, %rax
    mul %r13
    mul %r14
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
