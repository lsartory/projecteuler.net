.data
hi:
    .ascii "Hello World!\n"
    len = . - hi

.text
// Print a simple "Hello Word" banner to stdout
print_banner:
    mov x0, 1   // stdout
    adr x1, hi  // buffer address
    mov x2, len // buffer length
    mov x8, 64  // sys_write
    svc 0
    ret


.globl _start
_start:
    // Print banner
    bl print_banner

    // Initialize loop
    mov x19, -15
loop:
    mov x0, x19
    bl print_int
    bl print_endl

    // Loop up to fifteen
    add x19, x19, 1
    cmp x19, 15
    ble loop

    // Exit the program
    mov x0, 0  // Return 0
    mov x8, 93 // Select the sys_exit function
    svc 0      // Perform the system call
