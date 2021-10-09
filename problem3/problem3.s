.equ TARGET, 600851475143

.text
is_prime:
    # Save context
    push %rbx
    push %rdx
    push %r8
    push %r9
    mov %rax, %r8

    # Pair numbers are never prime except for 2
    cmp $2, %rax
    je prime
    jl not_prime
    test $1, %rax
    jz not_prime

    # Find the first potential divisor
    mov %rax, %r9
    shr $1, %r9
    test $1, %r9
    jnz prime_loop
    inc %r9

prime_loop:
    # Divide the number
    xor %rdx, %rdx
    mov %r8, %rax
    div %r9

    # Divisible -> not prime
    test %rdx, %rdx
    jz not_prime

    # Find the next potential divisor
    sub $2, %r9
    cmp $1, %r9
    je prime
    jmp prime_loop

prime:
    # Return 0 if prime
    xor %rax, %rax
    jmp prime_end

not_prime:
    # Return the largest divisor if not prime
    mov %r9, %rax

prime_end:
    # Restore context
    pop %r9
    pop %r8
    pop %rdx
    pop %rbx
    ret


.globl _start
_start:
    # Set the initial value
    mov $TARGET, %r8
    mov $1, %r9

loop:
    # Find the next prime number
    add $2, %r9
    mov %r9, %rax
    call is_prime
    test %rax, %rax
    jnz loop

    # Check if this is a divisor
    xor %rdx, %rdx
    mov %r9, %rbx
    mov %r8, %rax
    div %rbx
    test %rdx, %rdx
    jnz loop

    # Save the division result and loop if not equal to 1
    mov %rax, %r8
    cmp $1, %rax
    jne loop

end:
    # Print the result
    mov %r9, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
