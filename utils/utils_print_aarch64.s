.text

// Print a single space to stdout
.globl print_space
print_space:
    mov x0, 1     // Write to stdout
    mov x1, ' '   // Load the space character into a register
    strb w1, [sp] // Write the character to the stack
    mov x1, sp    // Load the address of the space character into x1
    mov x2, 1     // Set the length to 1 byte
    mov x8, 64    // Select the sys_write function
    svc 0         // Perform the system call
    ret


// Print a new line character to stdout
.globl print_endl
print_endl:
    mov x0, 1     // Write to stdout
    mov x1, '\n'  // Load the new line character into a register
    strb w1, [sp] // Write the character to the stack
    mov x1, sp    // Load the address of the newline character into x1
    mov x2, 1     // Set the length to 1 byte
    mov x8, 64    // Select the sys_write function
    svc 0         // Perform the system call
    ret


# Print the integer stored in x0 to stdout
.globl print_int
print_int:
    // Save the context and move the stack pointer
    mov x3, sp
    sub sp, sp, 32

    // Test if the integer is negative
    mov x9, 0
    cmp x0, 0
    bge print_int_loop
    neg x0, x0
    mov x9, 1

print_int_loop:
    // Divide by ten to get a single digit
    mov x1, 10
    udiv x2, x0, x1
    mul x1, x2, x1
    sub x1, x0, x1
    mov x0, x2

    // Add '0' and copy the character
    add x1, x1, '0'
    strb w1, [x3, -1]!

    // Loop until the quotient is zero
    cmp x0, 0
    bne print_int_loop

    // If the integer was negative, add the minus sign
    cmp x9, 0
    beq print_int_end
    mov x1, '-'
    strb w1, [x3, -1]!

print_int_end:
    // Print the number
    mov x0, 1      // Write to stdout
    mov x1, x3     // Load the address of the newline character into x1
    mov x2, sp     // Load the length with sp
    add x2, x2, 32 // Add 32 to go back to the base sp
    sub x2, x2, x3 // Subtract the string base pointer to get the length
    mov x8, 64     // Select the sys_write function
    svc 0          // Perform the system call

    // Restore the context
    add sp, sp, 32
    ret

.end
