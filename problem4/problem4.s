.text
# Check if the integer stored in %rax is a palindrome
is_palindrome:
    # Save the context
    push %rbp
    push %rbx
    mov %rsp, %rbp
    xor %rcx, %rcx

is_palindrome_format:
    # Divide by ten to get a single digit
    xor %rdx, %rdx
    mov $10, %rbx
    div %rbx
    sub $1, %rsp
    movb %dl, (%rsp)
    inc %rcx

    # Loop until the quotient is zero
    test %rax, %rax
    jnz is_palindrome_format

    lea -1(%rbp), %r8
is_palindrome_test:
    # Test if the paired digits are the same
    mov (%rsp), %al
    cmp (%r8), %al
    jne is_palindrome_false
    inc %rsp
    dec %r8
    cmp %rsp, %r8
    jg is_palindrome_test

    # The number is a palindrome
    xor %rax, %rax
    jmp is_palindrome_end

is_palindrome_false:
    # The number is not a palindrome
    mov $1, %rax

is_palindrome_end:
    # Restore the context
    mov %rbp, %rsp
    pop %rbx
    pop %rbp
    ret


.globl _start
_start:
    mov $1000, %r12
    xor %r15, %r15

loop1:
    # Loop to find the result
    dec %r12
    cmp $99, %r12
    jle done
    mov %r12, %r13
loop2:
    xor %rdx, %rdx
    mov %r12, %rax
    mul %r13
    # Skip if this product is smaller than the biggest palindrome found so far
    cmp %r15, %rax
    jle loop2_skip
    mov %rax, %r14
    call is_palindrome
    test %rax, %rax
    jnz loop2_skip
    # This is the new biggest palindrome, store it
    mov %r14, %r15
loop2_skip:
    dec %r13
    cmp $99, %r13
    jle loop1
    jmp loop2

done:
    # Print the result
    mov %r15, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
