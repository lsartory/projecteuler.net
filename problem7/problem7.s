.equ TARGET, 10001

.text
# Check if the integer in %rax is a prime number
is_prime:
    cmp $3, %rax      # Integers up to 3 are all prime
    jle is_prime_true
    test $1, %rax     # Even numbers are not prime
    jz is_prime_false
    mov %rax, %r8     # Store the integer in %r8
    mov %rax, %rcx    # Start trying all lower values as divisors
    shr $1, %rcx      # Skip the first half because they cannot be divisors
is_prime_loop:
    xor %rdx, %rdx    # Clear the upper bits of the dividend
    mov %r8, %rax     # Set the lower bits of the dividend
    div %rcx          # Divide by the counter
    test %rdx, %rdx   # If the remainder is zero, it is not a prime number
    jz is_prime_false
    dec %rcx          # Decrement the counter
    cmp $1, %rcx      # Stop if the next divisor is one
    jg is_prime_loop
is_prime_true:
    xor %rax, %rax
    ret
is_prime_false:
    mov $1, %rax
    ret


.globl _start
_start:
    # Set the initial values
    mov $1, %r12
    xor %r13, %r13

main_loop:
    inc %r12          # Increment the integer
    mov %r12, %rax    # Move it to %rax
    call is_prime     # Check if the integer is a prime number
    test %rax, %rax
    jnz main_loop     # If not, try the next one
    inc %r13          # If yes, increment the prime counter
    cmp $TARGET, %r13 # Check if the target was reached
    jl main_loop      # If not, continue with the next integer

    # Print the result
    mov %r12, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
