.globl _start

.data
hi:
    .ascii "Hello World!\n"
    len = . - hi

.text
print:
    mov $len, %rdx
    mov $hi, %rsi
    mov $1, %rdi # stdout
    mov $1, %rax # sys_write
    syscall
    ret


_start:
    # Print banner
    call print

    # Initialize loop
    mov $-15, %r12
loop:
    mov %r12, %rax
    call print_int
    call print_endl

    # Loop up to fifteen
    inc %r12
    cmp $15, %r12
    jle loop

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
