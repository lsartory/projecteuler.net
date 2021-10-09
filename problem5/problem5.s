.equ TARGET, 20

.text
.globl _start
_start:
    # Set the initial value
    mov $TARGET, %esi

outer_loop:
    add $TARGET, %esi
    mov $TARGET, %ecx

inner_loop:
    xor %edx, %edx
    mov %esi, %eax
    div %ecx
    test %edx, %edx
    jnz outer_loop
    loop inner_loop

end:
    # Print the result
    mov %esi, %eax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
