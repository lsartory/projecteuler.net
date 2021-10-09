.text

# Print a single space to stdout
.globl print_space
print_space:
    movb $' ', -1(%rsp) # Push the space character to the stack
    lea -1(%rsp), %rsi  # Load the address of the space
    mov $1, %rdx        # Set the length to 1 byte
    mov $1, %rdi        # Write to stdout
    mov $1, %rax        # Select the sys_write function
    syscall
    ret


# Print a new line character to stdout
.globl print_endl
print_endl:
    movb $'\n', -1(%rsp) # Push the newline character to the stack
    lea -1(%rsp), %rsi   # Load the address of the newline
    mov $1, %rdx         # Set the length to 1 byte
    mov $1, %rdi         # Write to stdout
    mov $1, %rax         # Select the sys_write function
    syscall
    ret


# Print the integer stored in %rax to stdout
.globl print_int
print_int:
    # Save the context
    push %rbp
    push %rbx
    mov %rsp, %rbp

    # Test if the integer is negative
    xor %r8, %r8
    cmp $0, %rax
    jge print_int_loop
    neg %rax
    inc %r8

print_int_loop:
    # Divide by ten to get a single digit
    xor %rdx, %rdx
    mov $10, %rbx
    div %rbx

    # Add '0' and copy the character
    add $'0', %rdx
    sub $1, %rsp
    movb %dl, (%rsp)

    # Loop until the quotient is zero
    test %rax, %rax
    jnz print_int_loop

    # If the integer was negative, add the minus sign
    test %r8, %r8
    jz print_int_end
    sub $1, %rsp
    movb $'-', (%rsp)

print_int_end:
    # Print the number
    lea (%rsp), %rsi
    mov %rbp, %rdx
    sub %rsp, %rdx
    mov $1, %rdi # stdout
    mov $1, %rax # sys_write
    syscall

    # Restore the context
    mov %rbp, %rsp
    pop %rbx
    pop %rbp
    ret

.end
